import React, { useState, useEffect, useRef } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';
import DeleteCard from '../component/DeleteCard';

const Informasi = ({ setSubheadings, setTags, setUpdatedAt, setContentId, setAuthorName }) => {
  const [user, setUser] = useState(null);
  const [content, setContent] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [isDeleteCardOpen, setIsDeleteCardOpen] = useState(false);
  const [deleteMessage, setDeleteMessage] = useState('');
  const [isButtonVisible, setIsButtonVisible] = useState(false); // State for scroll-to-top button visibility
  const { id } = useParams();
  const navigate = useNavigate();
  const hasLoadedRef = useRef(false);

  const formatDate = (dateString) => {
    const options = { day: 'numeric', month: 'long', year: 'numeric' };
    return new Date(dateString).toLocaleDateString('id-ID', options);
  };

  useEffect(() => {
    const storedUser = JSON.parse(localStorage.getItem('user'));
    const token = localStorage.getItem('token');

    const fetchAllData = async () => {
      // Skip if we've already loaded this content ID
      if (hasLoadedRef.current) {
        return;
      }

      if (!token) {
        console.warn("No token found!");
        setUser(storedUser);
        return;
      }

      try {
        hasLoadedRef.current = true;  // Mark as loaded before the fetch

        // Fetch user data and content data in parallel
        const [userResponse, contentResponse] = await Promise.all([
          fetch("/api/decode", {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
            body: JSON.stringify({
              encrypted_token: token,
            }),
          }),
          fetch(`http://localhost:3000/api/content/${id}`, {
            method: 'GET',
            headers: {
              'Content-Type': 'application/json',
              Authorization: `Bearer ${token}`,
            },
          })
        ]);

        if (!userResponse.ok) throw new Error("Failed to fetch user data");
        if (!contentResponse.ok) {
          const errorMessage = await contentResponse.text();
          throw new Error(errorMessage || 'Failed to fetch content data');
        }

        // Parse both responses
        const [userData, contentData] = await Promise.all([
          userResponse.json(),
          contentResponse.json()
        ]);

        // Update user data
        setUser(userData);
        console.log("User loaded with permissions:", userData);

        // Update content data
        setContent(contentData);
        setSubheadings(contentData?.subheadings || []);
        setTags(contentData.content.tag ? contentData.content.tag.split(',') : []);
        setUpdatedAt(formatDate(contentData.content.updated_at));
        setContentId(id);
        setAuthorName(contentData.author_name);

      } catch (error) {
        hasLoadedRef.current = false;  // Reset on error
        console.error("Error fetching data:", error);
        setUser(storedUser);
        setError("Failed to fetch content. Please try again later.");
      } finally {
        setLoading(false);
      }
    };

    fetchAllData();
  }, [id, setSubheadings, setTags, setUpdatedAt, setContentId, setAuthorName]);

  useEffect(() => {
    const handleScroll = () => {
      if (window.scrollY > 0) {
        setIsButtonVisible(true);
      } else {
        setIsButtonVisible(false);
      }
    };

    window.addEventListener('scroll', handleScroll);

    // Cleanup event listener on component unmount
    return () => {
      window.removeEventListener('scroll', handleScroll);
    };
  }, []);

  useEffect(() => {
    return () => {
      setContent(null);
      setSubheadings([]);
      setTags([]);
    };
  }, [setSubheadings, setTags]);

  const handleEditClick = () => {
    if (!user) {
      alert("Please log in to edit content.");
    } else if (user.permissions.includes("edit_content")) {
      navigate(`/edit/${id}`);
    } else {
      alert("You are not authorized to edit this content.");
    }
  };

  const handleDeleteClick = () => {
    if (!user) {
      alert("Please log in to delete content.");
      return;
    }

    if (user.permissions.includes("delete_content")) {
      setDeleteMessage('Apakah Anda yakin ingin menghapus konten ini?');
      setIsDeleteCardOpen(true); // Open the DeleteCard for confirmation
    } else {
      alert("You are not authorized to delete this content.");
    }
  };

  const handleConfirmDelete = async () => {
    const token = localStorage.getItem("token");
    if (!token) {
      alert("Authorization token is missing for deletion.");
      return;
    }

    try {
      const response = await fetch(`http://localhost:3000/api/content/delete/${id}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (response.ok) {
        const currentDate = new Date();
        const formattedDate = currentDate.toLocaleString("en-US", {
          timeZone: "Asia/Jakarta",
          hour12: false,
        });

        const [date, time] = formattedDate.split(", ");
        const [month, day, year] = date.split("/");
        const formattedMySQLDate = `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")} ${time}`;

        const historyData = {
          content_id: parseInt(id, 10),
          editor_id: user?.id,
          action: "Deleting",
          edited_at: formattedMySQLDate,
        };

        const historyResponse = await fetch("http://localhost:3000/api/history/add", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
          body: JSON.stringify(historyData),
        });

        if (!historyResponse.ok) {
          console.error("Failed to record history for Deleting action");
        } else {
          console.log("History recorded successfully");
        }

        navigate("/");
      } else {
        alert("Failed to delete content");
      }
    } catch (err) {
      console.error("Error deleting content:", err);
      alert("An error occurred while deleting the content");
    }
  };

  const handleCancelDelete = () => {
    setIsDeleteCardOpen(false);
  };

  const scrollToTop = () => {
    window.scrollTo({ top: 0, behavior: "smooth" });
  };

  const Breadcrumbs = ({ paths }) => {
    return (
      <nav>
        <ul className="breadcrumbs">
          {paths.map((path, index) => (
            <li key={index}>
              {path.link ? (
                <Link to={path.link}>{path.label}</Link>
              ) : (
                <span>{path.label}</span>
              )}
              {index < paths.length - 1 && " / "}
            </li>
          ))}
        </ul>
      </nav>
    );
  };

  if (loading) return <div>Loading content...</div>;
  if (error) return <div>Error: {error}</div>;

  return (
    <div className="main">
      <div className="content">
        <Breadcrumbs
          paths={[
            { label: "Home", link: "/" },
            { label: "Informasi" },
          ]}
        />

        <div className="titel"></div>
        <h1 className="content-title2">
          {content?.content?.title || "No Title Available"}
          <hr className="gradient-hr"></hr>
        </h1>

        <div dangerouslySetInnerHTML={{ __html: content?.content?.description.String || '' }} />

        <div style={{ marginTop: "2rem" }} className="no-number">
          {content?.subheadings?.length > 0 &&
            content.subheadings.map((subheading) => (
              <div key={subheading.id} id={subheading.subheading}>
                <h2 style={{ marginBottom: "1rem" }} id="subheading">
                  {subheading.subheading}
                  <hr className="gradient-hr-sub"></hr>
                </h2>

                <div dangerouslySetInnerHTML={{ __html: subheading.subheading_description || "" }} />
              </div>
            ))}
        </div>
        {user && user.permissions ? (
        <div className="button-submit">
          <div className="button-combined">
          {user.permissions.includes("edit_content") && (
            <div className="button-left" onClick={handleEditClick}>
              Edit
            </div>
            )}
          {user.permissions.includes("delete_content") && (
            <div className="button-right" onClick={handleDeleteClick}>
              Delete
            </div>
            )}
          </div>
        </div>
      ) : (
        <div>Loading permissions...</div>
      )}
      </div>
      <DeleteCard
        isOpen={isDeleteCardOpen}
        message={deleteMessage}
        onConfirm={handleConfirmDelete}
        onCancel={handleCancelDelete}
      />
      <button
        className={`button ${isButtonVisible ? '' : 'disabled'}`}
        onClick={scrollToTop}
        disabled={!isButtonVisible}
      >
        <svg className="svgIcon" viewBox="0 0 384 512">
          <path
            d="M214.6 41.4c-12.5-12.5-32.8-12.5-45.3 0l-160 160c-12.5 12.5-12.5 32.8 0 45.3s32.8 12.5 45.3 0L160 141.2V448c0 17.7 14.3 32 32 32s32-14.3 32-32V141.2L329.4 246.6c12.5 12.5 32.8 12.5 45.3 0s12.5-32.8 0-45.3l-160-160z"
          ></path>
        </svg>
      </button>
    </div>
  );
};

export default Informasi;