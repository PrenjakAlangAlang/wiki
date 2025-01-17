import React, { useState, useEffect } from "react";
import { useParams, Link } from "react-router-dom";

const ContentDetail = () => {
  const { id } = useParams();
  const [content, setContent] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchContent = async () => {
      const token = localStorage.getItem("token");
      try {
        const response = await fetch(
          `http://localhost:3000/api/content/${id}`,
          {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${token}`,
            },
          }
        );
        const data = await response.json();
        console.log(data);
        setContent(data);
      } catch (error) {
        console.error("Error fetching content:", error);
        setError("Failed to fetch content");
      } finally {
        setLoading(false);
      }
    };

    fetchContent();
  }, [id]);

  if (loading) return <div>Loading...</div>;
  if (error) return <div>{error}</div>;

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

  return (
    <div className="container-details">
      <div className="content">
        <Breadcrumbs 
          paths={[
            { label: "Home", link: "/" },
            { label: "Manage Content", link: "/manage-content" }, 
            { label: "Content Detail" }, // Halaman saat ini tidak memiliki link
          ]} 
        />
        <div className="manage-content">
                <h1 className="manage-content-h1">Content Detail</h1>
                <p className='manage-content-p'>pay attention to the content created</p>
        </div>
        <h1 className="content-title">{content.content.title}<hr className="gradient-hr"></hr></h1>
        <div
          dangerouslySetInnerHTML={{
            __html: content.content.description.String,
          }}
        />

        <div style={{ marginTop: "2rem" }} className="no-number">
          {content?.subheadings?.length > 0 &&
            content.subheadings.map((subheading) => (
              <div key={subheading.id} id={subheading.subheading}>
                <h2 style={{ marginBottom: "1rem" }} id="subheading">
                  {subheading.subheading}<hr className="gradient-hr-sub"></hr>
                </h2>
                {/* Menampilkan deskripsi subheading sebagai HTML */}
                <div
                  dangerouslySetInnerHTML={{
                    __html: subheading.subheading_description || "",
                  }}
                />
              </div>
            ))}
        </div>

        <Link to="/manage-content">
          <button className="btn btn-blue">Back to Manage Content</button>
        </Link>
      </div>
    </div>
  );
};

export default ContentDetail;