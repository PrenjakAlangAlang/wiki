import React, { useEffect, useState } from "react";
import { useLocation, Link } from "react-router-dom";
import "font-awesome/css/font-awesome.min.css";
const Sidebar = ({ subheadings, tags, updatedAt, contentId, authorName }) => {
    const location = useLocation();
    const [editorName, setEditorName] = useState("Loading...");
    const isHomePage = location.pathname === "/";
    const [currentUser, setCurrentUser] = useState(null);
    const [viewCount, setViewCount] = useState(0); // State for view count

    const defaultHomeContents = [
        { id: "welcome", title: "Selamat datang di Wiki Pemda" },
        { id: "organisasi", title: "Organisasi Perangkat" },
    ];

    useEffect(() => {
        // Get user and token from localStorage
        const storedUser = JSON.parse(localStorage.getItem("user"));
        const token = localStorage.getItem("token");

        const fetchUserData = async () => {
            if (!token) {
                console.warn("No token found!");
                setCurrentUser(storedUser);
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
                        encrypted_token: token, // Kirim token dalam body
                    }),
                });

                if (!response.ok) throw new Error("Failed to fetch user data");

                const userData = await response.json();
                setCurrentUser(userData);
                console.log("User loaded with permissions:", userData);
            } catch (error) {
                console.error("Error fetching user data:", error);
                setCurrentUser(storedUser);
            }
        };

        fetchUserData();
    }, []); // Run once on component mount

    useEffect(() => {
        if (contentId && currentUser?.permissions?.includes("view_latest_editor")) {
            // Only fetch editor name if user has permission
            fetch(`http://localhost:3000/api/latest-editor-name/${contentId}`)
                .then((res) => res.json())
                .then((data) => {
                    setEditorName(data.editorName || "Unknown Editor");
                })
                .catch(() => setEditorName("Unknown Editor"));
        }
    }, [contentId, currentUser]); // Dependencies include currentUser now

    useEffect(() => {
        if (contentId) {
            const token = localStorage.getItem("token");
            fetch(`http://localhost:3000/api/content/viewcount/${contentId}`, {
                method: "GET",
                headers: {
                    "Content-Type": "application/json",
                    "Authorization": `Bearer ${token}`,
                },
            })
            .then((res) => res.json())
            .then((data) => {
                setViewCount(data.viewCount);
            })
            .catch((err) => console.error("Error fetching view count:", err));
        }
    }, [contentId]);

    return (
        <main className="main">
            <aside className="sidebar">
                <div className="sidebar-box">
                    <ul>
                    {(isHomePage || subheadings.length > 0) && (
                        <div className="small-box">
                            <h5 className="tags-title">PAGE CONTENTS</h5>
                            <ul className="link-list">
                                {isHomePage
                                    ? defaultHomeContents.map((content) => (
                                        <li key={content.id}>
                                            <i className="fa fa-angle-right"></i>
                                            <a href={`#${content.id}`}>{content.title}</a>
                                        </li>
                                    ))
                                    : subheadings.map((subheading) => (
                                        <li key={subheading.id}>
                                            <i className="fa fa-angle-right"></i> 
                                            <a href={`#${subheading.subheading}`}>
                                                {subheading.subheading}
                                            </a>
                                        </li>
                                    ))}
                            </ul>
                        </div>
                    )}
                                            
                        <div className="small-box">
                            <h5 className="tags-title">TAGS</h5>
                            <ul className="link-list">
                                {location.pathname === "/" && (
                                    <li>
                                        <Link to="/" className="tag-link">
                                            <img
                                                src={require(`../assets/tag.png`)}
                                                alt="tag"
                                                className="tag"
                                            />
                                            Home
                                        </Link>
                                    </li>
                                )}
                                {tags &&
                                    tags.length > 0 &&
                                    tags.map((tag, index) => (
                                        <li key={index}>
                                            <Link
                                                to={`/search/${tag.trim()}`}
                                                className="tag-link"
                                            >
                                                <img
                                                    src={require(`../assets/tag.png`)}
                                                    alt="tag"
                                                    className="tag"
                                                />
                                                {tag.trim()}
                                            </Link>
                                        </li>
                                    ))}
                            </ul>
                        </div>
                        
                        {!isHomePage && currentUser?.permissions?.includes("view_latest_editor") && (
                            <div className="small-box">
                                <h5 className="tags-title">LAST EDITED BY</h5>
                                <ul className="link-list">
                                    <li>{editorName === "Unknown Editor" ? authorName : editorName}</li>
                                    {updatedAt && <li>at {updatedAt}</li>}
                                </ul>
                            </div>
                        )}

                        {!isHomePage && (
                            <div className="small-box">
                                <h5 className="tags-title">VIEW COUNT</h5>
                                <ul className="link-list">
                                    <li>{viewCount} <i className="fa fa-eye" style={{ marginRight: "5px", marginLeft: "5px" }}></i>views</li>
                                </ul>
                            </div>
                        )}
                    </ul>
                </div>
            </aside>
        </main>
    );
};

export default Sidebar;