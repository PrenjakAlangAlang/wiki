import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { FaPlus } from "react-icons/fa";

function Home() {
  const [contents, setContents] = useState([]);
  const [user, setUser] = useState(null);
  const navigate = useNavigate();

  useEffect(() => {
    const storedUser = JSON.parse(localStorage.getItem("user"));
    const token = localStorage.getItem("token");

    if (token) {
      try {
        // Decode token to extract permissions
        const tokenData = JSON.parse(atob(token.split(".")[1])); // Decode JWT payload
        const userWithPermissions = {
          ...storedUser,
          permissions: tokenData.permissions || [],
        };
        setUser(userWithPermissions);
        console.log("User loaded with permissions:", userWithPermissions);
      } catch (e) {
        console.error("Error parsing token:", e);
        setUser(storedUser);
      }
    } else {
      console.warn("No token found!");
      setUser(storedUser);
    }

    const fetchData = async () => {
      try {
        // Fetch active contents
        const response = await fetch("/api/active", {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
        });

        if (!response.ok) {
          throw new Error("Failed to fetch content data");
        }

        const data = await response.json();
        setContents(data);
      } catch (error) {
        console.error("Error fetching content:", error);
      }
    };

    fetchData();
  }, [navigate]);

  const handleAddClick = () => {
    if (!user) {
      alert("Please log in to edit content.");
      navigate("/login");
    } else if (user.permissions && user.permissions.includes("create_content")) {
      navigate(`/addcontent`);
    } else {
      alert("You are not authorized to create content.");
    }
  };

  return (
    <div className="main">
      <div className="content">
        <div className="welcome-box">
          <h2>Wiki Pemda DIY</h2>
          <p>Knowledge Management system Pemda DIY untuk berbagi pengetahuan</p>
        </div>
        <div className="welcome-side">
          <h1 id="welcome" className="content-title">
            Selamat datang di Wiki Pemda DIY
            <hr className="gradient-hr"></hr>
          </h1>
          <p className="content-p">Selamat datang di wiki Pemda DIY. Disini anda akan menemukan banyak informasi, panduan dan petunjuk terkait SPBE (Sistem Pemerintahan Berbasis Elektronik) di lingkungan Pemerintah Daerah DIY.</p>
        </div>
        <h2 id="organisasi" className="content-h2">
          Organisasi Perangkat Daerah Pemda DIY
          <hr className="gradient-hr-sub"></hr>
        </h2>

        {user && user.permissions && user.permissions.includes("view_active_content") && (
          <ul className="numbered">
            {(contents || []).map((content) => (
              <li key={content.id}>
                <Link to={`/informasi/${content.id}`}>{content.title}</Link>
              </li>
            ))}
          </ul>
        )}

        {user && user.permissions && user.permissions.includes("create_content") && (
          <button className="button-create-content" onClick={handleAddClick}>
            <span className="text">Create</span>
            <span className="icon">
              <FaPlus />
            </span>
          </button>
        )}
      </div>
    </div>
  );
}

export default Home;
