import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { FaPlus } from "react-icons/fa";

function Home() {
  const [contents, setContents] = useState([]);
  const [user, setUser] = useState(null);
  const [isButtonVisible, setIsButtonVisible] = useState(false);
  const navigate = useNavigate();

  useEffect(() => {
    const initializeAuth = async () => {
      try {
        let token = localStorage.getItem("token");
        let storedUser = localStorage.getItem("user");
  
        // Fetch guest token if no token exists
        if (!token || !storedUser) {
          const guestResponse = await fetch("/api/guest", {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
              "Accept": "application/json",
            },
          });
  
          if (!guestResponse.ok) {
            throw new Error("Failed to fetch guest token");
          }
  
          const guestData = await guestResponse.json();
          token = guestData.token;
          localStorage.setItem("token", token);
          
          const defaultUser = {
            role: guestData.role,
            role_id: guestData.role_id,
            permissions: guestData.permissions,
          };
          localStorage.setItem("user", JSON.stringify(defaultUser));
          storedUser = JSON.stringify(defaultUser);
        }
  
        // Decode token untuk mendapatkan informasi user
        const decodeResponse = await fetch("/api/decode", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: JSON.stringify({
            encrypted_token: token,
          }),
        });
  
        if (!decodeResponse.ok) {
          throw new Error("Failed to decode token");
        }
  
        const userData = await decodeResponse.json();
        const parsedStoredUser = JSON.parse(storedUser);
        
        // Combine stored user data with decoded permissions
        const userWithPermissions = {
          ...parsedStoredUser,
          permissions: userData.permissions || [],
        };
        
        setUser(userWithPermissions);
  
        // Fetch konten aktif jika user memiliki permission
        if (userWithPermissions.permissions?.includes("view_active_content")) {
          const contentResponse = await fetch("/api/active", {
            method: "GET",
            headers: {
              "Content-Type": "application/json",
              "Authorization": `Bearer ${token}`,
            },
          });
  
          if (!contentResponse.ok) {
            throw new Error("Failed to fetch content");
          }
  
          const contentData = await contentResponse.json();
          setContents(contentData);
        }
      } catch (error) {
        console.error("Error in initialization:", error);
      }
    };
  
    initializeAuth();
  }, [navigate]);

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

  const scrollToTop = () => {
    window.scrollTo({ top: 0, behavior: "smooth" });
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
}

export default Home;