import React, { useState, useEffect } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import logo from '../assets/logojogja.png';
import profile from '../assets/user.png';
import search from '../assets/search.png';
import ModalLogout from './ModalLogout';
import Sidebar2 from './Sidebar2';

const Navbar = ({ searchTerm, setSearchTerm }) => {
    const location = useLocation();
    const navigate = useNavigate();
    const [showDropdown, setShowDropdown] = useState(false);
    const [user, setUser] = useState(() => {
        try {
            return JSON.parse(localStorage.getItem('user')) || null;
        } catch {
            return null;
        }
    });
    const [isModalOpen, setIsModalOpen] = useState(false);
    const [isSidebar2Open, setIsSidebar2Open] = useState(false);

    useEffect(() => {
        const handleStorageChange = () => {
            try {
                const userData = JSON.parse(localStorage.getItem('user'));
                setUser(userData);
            } catch {
                setUser(null);
            }
        };

        window.addEventListener('storage', handleStorageChange);
        return () => {
            window.removeEventListener('storage', handleStorageChange);
        };
    }, []);

    // Close dropdown when clicking outside
    useEffect(() => {
        const handleClickOutside = (event) => {
            if (!event.target.closest('.profile-container')) {
                setShowDropdown(false);
            }
        };

        document.addEventListener('click', handleClickOutside);
        return () => {
            document.removeEventListener('click', handleClickOutside);
        };
    }, []);

    const clearSearch = () => {
        if (location.pathname !== '/') {
            setSearchTerm('');
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
            localStorage.removeItem('user');
            setUser(null);
            window.dispatchEvent(new Event('storage'));
            navigate(`/`);
            setIsModalOpen(false); // Tutup modal setelah logout
        } catch (error) {
            console.error('Error during logout:', error);
        }
    };

    // Jangan render navbar di halaman login
    if (location.pathname === '/login') {
        return null; // Jangan render apa-apa jika di halaman login
    }

    return (
        <>
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
                        Wiki Pemda DIY
                    </Link>  
                </div>
            </div>

                    
                    <div className="navbar-center">
                        <div className="search-bar">
                            <input
                                type="text"
                                value={searchTerm || ''}
                                onChange={handleSearch}
                                placeholder="Search ..."
                            />
                            <button onClick={() => navigate(`/search/${searchTerm.trim()}`)}>
                                <img src={search} alt="Search" className="search-icon" />
                            </button>
                        </div>
                    </div>

                    <div className="navbar-right">

                        {user ? (
                            <>
                                <div className="profile-container">
                                    <div className="profile" onClick={() => setShowDropdown(!showDropdown)}>
                                        <img src={profile} alt="Profile" />
                                    </div>
                                    <div className={`profile-dropdown ${showDropdown ? 'show' : ''}`}>
                                        <Link to="/profile" onClick={() => {
                                            clearSearch();
                                            setShowDropdown(false);
                                        }}>Profile</Link>

                                        {user.role_id === 1 && (
                                            <Link to="/manage" onClick={() => {
                                                clearSearch();
                                                setShowDropdown(false);
                                            }}>Manage User</Link>
                                        )}

                                        <button onClick={() => {
                                            setShowDropdown(false);
                                            handleLogoutConfirmation(); // Panggil konfirmasi logout
                                        }}>Logout</button>
                                    </div>
                                </div>
                                <Link to="/profile" onClick={() => {
                                    clearSearch();
                                    setShowDropdown(false);
                                }}>
                                    <span className="user-name">{user.name}</span>
                                    <span className="user-role">{user.role_id}</span>
                                </Link>
                            </>
                        ) : (
                            <input
                                type="button"
                                value="Login"
                                className="btn btn-blue"
                                onClick={() => {
                                    clearSearch();
                                    navigate('/login');
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
        </>
    );
};

export default Navbar;