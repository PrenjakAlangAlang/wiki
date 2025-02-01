import React, { useState, useEffect } from "react";
import { Link, useLocation, useNavigate } from "react-router-dom";
import logo from "../assets/logojogja.png";
import profile from "../assets/user.png";
import search from "../assets/search.png";
import ModalLogout from "./ModalLogout";
import Sidebar2 from "./Sidebar2";
import "font-awesome/css/font-awesome.min.css";

const Navbar = ({ searchTerm, setSearchTerm }) => {
  const location = useLocation();
  const navigate = useNavigate();
  const [showDropdown, setShowDropdown] = useState(false);
  const [user, setUser] = useState(() => {
    try {
      return JSON.parse(localStorage.getItem("user")) || null;
    } catch {
      return null;
    }
  });
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [isSidebar2Open, setIsSidebar2Open] = useState(false);

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

    fetchUserData(); // Panggil fungsi fetchUserData saat pertama kali render

    window.addEventListener("storage", fetchUserData);
    return () => {
      window.removeEventListener("storage", fetchUserData);
    };
  }, []);

  // Close dropdown when clicking outside
  useEffect(() => {
    const handleClickOutside = (event) => {
      if (!event.target.closest(".profile-container")) {
        setShowDropdown(false);
      }
    };

    document.addEventListener("click", handleClickOutside);
    return () => {
      document.removeEventListener("click", handleClickOutside);
    };
  }, []);

  const clearSearch = () => {
    if (location.pathname !== "/") {
      setSearchTerm("");
    }
  };

  const handleSearch = (e) => {
    const value = e.target.value;
    setSearchTerm(value);
    if (value.trim()) {
      navigate(`/search/${value.trim()}`);
    }
  };

  const handleLogoutConfirmation = () => {
    setIsModalOpen(true); // Buka modal konfirmasi saat logout
  };

  const handleLogout = () => {
    try {
      localStorage.removeItem("user");
      setUser(null);
      window.dispatchEvent(new Event("storage"));
      navigate(`/`);
      setIsModalOpen(false); // Tutup modal setelah logout
    } catch (error) {
      console.error("Error during logout:", error);
    }
  };

  // Jangan render navbar di halaman login
  if (location.pathname === "/login") {
    return null; // Jangan render apa-apa jika di halaman login
  }

  return (
    <main className="main-nav">
      <div className="header">
        <nav>
          <div className="navbar-header">
            <button onClick={() => setIsSidebar2Open(!isSidebar2Open)} className="hamburger-menu">
              <svg width="24" height="24" viewBox="0 0 24 24">
                <path d="M3 6h18M3 12h18m-7 6h7" stroke="currentColor" strokeWidth="2" strokeLinecap="round" />
              </svg>
            </button>
            <div className="navbar-left">
              <Link to="/" className="nav-link logo-container" onClick={clearSearch}>
                <img src={logo} alt="Logo Pemda DIY" className="logo" />
              </Link>
            </div>
          </div>

          {user && user.permissions && user.permissions.includes("search_contents") && (
            <div className="navbar-center">
              <div className="search-bar">
                <input type="text" value={searchTerm || ""} onChange={handleSearch} placeholder="Search ..." />
                <button onClick={() => navigate(`/search/${searchTerm.trim()}`)}>
                  <img src={search} alt="Search" className="search-icon" />
                </button>
              </div>
            </div>
          )}

          <div className="navbar-right">
            {user ? (
              <>
                <div className="profile-container">
                  <div className="profile" onClick={() => setShowDropdown(!showDropdown)}>
                    <img src={profile} alt="Profile" />
                  </div>
                  <div className={`profile-dropdown ${showDropdown ? "show" : ""}`}>
                    {user && user.permissions && user.permissions.includes("view_user") && (
                      <Link
                        to="/profile"
                        onClick={() => {
                          clearSearch();
                          setShowDropdown(false);
                        }}
                      >
                        <i className="fa fa-user" style={{ marginRight: "11px" }}></i> Profile
                      </Link>
                    )}

                    {user && user.permissions && user.permissions.includes("view_all_users") && (
                      <Link
                        to="/manage"
                        onClick={() => {
                          clearSearch();
                          setShowDropdown(false);
                        }}
                      >
                        <i className="fa fa-users" style={{ marginRight: "5px" }}></i> Manage User
                      </Link>
                    )}

                    {user && user.permissions && user.permissions.includes("view_drafts") && (
                      <Link
                        to="/manage-content"
                        onClick={() => {
                          clearSearch();
                          setShowDropdown(false);
                        }}
                      >
                        <i className="fa fa-folder" style={{ marginRight: "8px" }}></i> Manage Content
                      </Link>
                    )}

                    {user && user.permissions && user.permissions.includes("view_user_contents") && (
                      <Link
                        to="/view-status-content"
                        onClick={() => {
                          clearSearch();
                          setShowDropdown(false);
                        }}
                      >
                        <i className="fa fa-check-circle" style={{ marginRight: "5px" }}></i> View Status Content
                      </Link>
                    )}

                    {user && user.permissions && user.permissions.includes("manage_role") && (
                      <Link
                        to="/manage-role"
                        onClick={() => {
                          clearSearch();
                          setShowDropdown(false);
                        }}
                      >
                        <i className="fa fa-clipboard" style={{ marginRight: "6px" }}></i> Manage Role
                      </Link>
                    )}

                    <button
                      onClick={() => {
                        setShowDropdown(false);
                        handleLogoutConfirmation(); // Panggil konfirmasi logout
                      }}
                    >
                      <i className="fa fa-sign-out" style={{ marginRight: "11px", color: "red" }}></i> Logout
                    </button>
                  </div>
                </div>
                <div className="username-container">
                  <span className="user-name">{user.name}</span>
                  <span className="user-role">{user.role}</span> {/* Menampilkan role */}
                </div>
              </>
            ) : (
              <input
                type="button"
                value="Login"
                className="btn btn-blue"
                onClick={() => {
                  clearSearch();
                  navigate("/login");
                }}
              />
            )}
          </div>
        </nav>
      </div>

      {/* Render Sidebar2 */}
      <Sidebar2 isOpen={isSidebar2Open} onClose={() => setIsSidebar2Open(false)} />

      {/* Modal Logout */}
      <ModalLogout
        isOpen={isModalOpen}
        onClose={() => setIsModalOpen(false)} // Menutup modal
        onConfirm={handleLogout} // Logout jika konfirmasi
      />
    </main>
  );
};

export default Navbar;
