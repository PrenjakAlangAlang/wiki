import React, { useState, useEffect } from 'react';
import { Link, useLocation, useNavigate } from 'react-router-dom';
import logo from '../assets/logojogja.png';
import profile from '../assets/user.png';
import search from '../assets/search.png';

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

    useEffect(() => {
        const timeoutId = setTimeout(() => {
            if (searchTerm.trim()) {
                navigate(`/search/${searchTerm.trim()}`);
            }
        }, 500);

        return () => clearTimeout(timeoutId);
    }, [searchTerm, navigate]);

    const handleSearch = (e) => {
        setSearchTerm(e.target.value || '');
    };

    const handleLogoutConfirmation = () => {
        const isConfirmed = window.confirm('Apakah Anda yakin ingin keluar dari akun?');
        if (isConfirmed) handleLogout();
    };

    const handleLogout = () => {
        try {
            localStorage.removeItem('user');
            setUser(null);
            window.dispatchEvent(new Event('storage'));
            navigate(`/`);
        } catch (error) {
            console.error('Error during logout:', error);
        }
    };

    return (
        <>
            <div className="header">
                <nav>
                    <div className="navbar-left">
                        <Link to="/" className="nav-link logo-container" onClick={clearSearch}>
                            <img src={logo} alt="Logo Pemda DIY" className="logo" />
                            Wiki Pemda DIY
                        </Link>
                    </div>

                    <div className="navbar-center">
                        <div className="search-bar">
                            <input
                                type="text"
                                value={searchTerm || ''}
                                onChange={handleSearch}
                                placeholder="Search ..."
                            />
                            <button>
                                <img src={search} alt="Search" className="search-icon" />
                            </button>
                        </div>
                    </div>

                    <div className="navbar-right">
                        <a href="https://api.whatsapp.com/send/?phone=6282133576291&text=Hello&type=phone_number&app_absent=0"
                            target="_blank"
                            rel="noopener noreferrer"
                            className="nav-link">FAQ</a>

                        <a href="https://api.whatsapp.com/send/?phone=6282133576291&text=Hello&type=phone_number&app_absent=0"
                            target="_blank"
                            rel="noopener noreferrer"
                            className="nav-link">Helpdesk</a>
                        {user ? (
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
                                        handleLogoutConfirmation();
                                    }}>Logout</button>
                                </div>
                            </div>
                        ) : (
                            location.pathname !== '/login' && (
                                <input
                                    type="button"
                                    value="Login"
                                    className="btn btn-blue"
                                    onClick={() => {
                                        clearSearch();
                                        navigate('/login');
                                    }}
                                />
                            )
                        )}
                    </div>
                </nav>
            </div>
        </>
    );
};

export default Navbar;