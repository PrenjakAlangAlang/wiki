import React, { useState, useEffect } from 'react';
import { useParams, useNavigate, Link } from 'react-router-dom';

const Informasi = ({ setSubheadings, setTags, setUpdatedAt, setContentId, setAuthorName }) => {
  const [user, setUser] = useState(null);
  const [content, setContent] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const { id } = useParams();
  const navigate = useNavigate();

  const formatDate = (dateString) => {
    const options = { day: 'numeric', month: 'long', year: 'numeric' };
    return new Date(dateString).toLocaleDateString('id-ID', options);
  };

  useEffect(() => {
    const storedUser = JSON.parse(localStorage.getItem('user'));
    if (storedUser) setUser(storedUser);

    const fetchData = async () => {
      const token = localStorage.getItem('token'); // Retrieve the token from localStorage

      // if (!token) {
      //   setError("Authorization token is missing. Please log in again.");
      //   setLoading(false);
      //   return;
      // }

      try {
        const response = await fetch(`http://localhost:3000/api/content/${id}`, {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${token}`, // Properly format the Authorization header
          },
        });

        if (!response.ok) {
          const errorMessage = await response.text();
          throw new Error(errorMessage || 'Failed to fetch data');
        }

        const data = await response.json();
        setContent(data);
        setSubheadings(data?.subheadings || []);
        setTags(data.content.tag ? data.content.tag.split(',') : []);
        setUpdatedAt(formatDate(data.content.updated_at));
        setContentId(id);
        setAuthorName(data.author_name);
      } catch (err) {
        console.error("Error fetching content:", err);
        setError("Failed to fetch content. Please try again later.");
      } finally {
        setLoading(false);
      }
    };

    if (id) fetchData();
  }, [id, setSubheadings, setTags, setUpdatedAt, setContentId, setAuthorName]);

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
    } else if (user.role_id === 1 || user.role_id === 2 || (user.role_id === 3 && user.user_instance_id === content?.content?.instance_id)) {
      navigate(`/edit/${id}`);
    } else {
      alert("You are not authorized to edit this content.");
    }
  };

  const handleDeleteClick = async () => {
    if (!user) {
      alert("Please log in to delete content.");
    } else if (user.role_id === 1 || user.role_id === 2 || (user.role_id === 3 && user.user_instance_id === content?.content?.instance_id)) {
      const confirmDelete = window.confirm("Are you sure you want to delete this content?");
      if (confirmDelete) {
        const token = localStorage.getItem('token'); // Retrieve token for deletion request
        if (!token) {
          alert("Authorization token is missing for deletion.");
          return;
        }

        try {
          const response = await fetch(`http://localhost:3000/api/content/delete/${id}`, {
            method: 'DELETE',
            headers: {
              'Content-Type': 'application/json',
              Authorization: `Bearer ${token}`, // Add token to Authorization header for delete request
            },
          });

          if (response.ok) {
            alert("Content deleted successfully");
            navigate('/');
          } else {
            alert("Failed to delete content");
          }
        } catch (err) {
          alert("An error occurred while deleting the content");
        }
      }
    } else {
      alert("You are not authorized to delete this content.");
    }
  };

  // Breadcrumbs component
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
              {index < paths.length - 1 && " / "} {/* Menambahkan separator */}
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
            { label: "Informasi" }, // Halaman saat ini tidak memiliki link
          ]} 
        />
        <div className='titel'></div>
        <h1 className="content-title2">{content?.content?.title || "No Title Available"}</h1>
        
        {/* Menampilkan deskripsi sebagai HTML */}
        <div
          dangerouslySetInnerHTML={{ __html: content?.content?.description.String || '' }}
        />

        <ul className="no-number">
          {content?.subheadings?.length > 0 &&
            content.subheadings.map((subheading) => (
              <li key={subheading.id} id={subheading.subheading}>
                <strong id="subheading">{subheading.subheading}</strong>
                {/* Menampilkan deskripsi subheading sebagai HTML */}
                <div
                  dangerouslySetInnerHTML={{ __html: subheading.subheading_description || '' }}
                />
              </li>
            ))}
        </ul>

        {user && (user.role_id === 1 || user.role_id === 2 || user.role_id === 3) && (
          <div className="submit-btn">
            <input
              type="button"
              value="Edit Konten"
              className="btn btn-blue"
              onClick={handleEditClick}
            />
            <input
              type="button"
              value="Hapus Konten"
              className="btn btn-red"
              onClick={handleDeleteClick}
            />
          </div>
        )}
      </div>
    </div>
  );
};

export default Informasi;