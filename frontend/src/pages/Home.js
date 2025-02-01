import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import { FaPlus } from "react-icons/fa";

function Home() {
  const [contents, setContents] = useState([]);
  const [user, setUser] = useState(null);
  const [isButtonVisible, setIsButtonVisible] = useState(false); // State for scroll-to-top button visibility
  const navigate = useNavigate();

  useEffect(() => {
    const storedUser = JSON.parse(localStorage.getItem("user"));
    const token = localStorage.getItem("token");

    const fetchUserData = async () => {
      if (!token) {
        console.warn("No token found!");
        setUser(storedUser);
        return;
      }

      try {
        const response = await fetch("/api/decode", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: JSON.stringify({
            encrypted_token: token, // Kirim token dalam body, bukan hanya di header
          }),
        });
        

        if (!response.ok) throw new Error("Failed to fetch user data");

        const userData = await response.json();
        setUser(userData);
        console.log("User loaded with permissions:", userData);
      } catch (error) {
        console.error("Error fetching user data:", error);
        setUser(storedUser);
      }
    };

    fetchUserData();

    const fetchData = async () => {
      try {
        const response = await fetch("/api/active", {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${token}`,
          },
        });

        if (!response.ok) throw new Error("Failed to fetch content data");

        const data = await response.json();
        setContents(data);
      } catch (error) {
        console.error("Error fetching content:", error);
      }
    };

    fetchData();
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