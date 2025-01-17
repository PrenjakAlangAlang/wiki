import React, { useEffect, useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { FaPlus } from 'react-icons/fa';

function Home() {
  const [contents, setContents] = useState([]);
  const [user, setUser] = useState(null);
  const navigate = useNavigate();

  useEffect(() => {
    const storedUser = JSON.parse(localStorage.getItem('user'));
    if (storedUser) setUser(storedUser);

    const fetchData = async () => {
      try {
        // Ambil token dari localStorage
        const token = localStorage.getItem('token');

        // Pastikan token ada sebelum membuat permintaan
        // if (!token) {
        //   alert('You need to login to access this content.');
        //   navigate('/login');
        //   return;
        // }

        // Fetch data dengan menambahkan Authorization header
        const response = await fetch('/api', {
          method: 'GET',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${token}`, // Menambahkan token di header
          },
        });

        if (!response.ok) {
          throw new Error('Failed to fetch content data');
        }

        const data = await response.json();
        setContents(data);
      } catch (error) {
        console.error('Error fetching content:', error);
      }
    };

    fetchData();
  }, [navigate]);

  const handleAddClick = () => {
    if (!user) {
      alert("Please log in to edit content.");
      navigate('/login');
    } else if (user.role_id === 1 || user.role_id === 2 || (user.role_id === 3)) {
      navigate(`/addcontent`);
    } else {
      alert("You are not authorized to edit this content.");
    }
  };

  return (
    <div className="main">
      <div className="content">
        <div className="welcome-box">
          <h2>Wiki Pemda DIY</h2>
          <p>Knowledge Management system Pemda DIY untuk berbagi pengetahuan</p>
          <hr></hr>
        </div>
        <div className="welcome-side">
        <h1 id="welcome" className="content-title">Selamat datang di Wiki Pemda DIY</h1>
        <p className='content-p'>Selamat datang di wiki Pemda DIY. Disini anda akan menemukan banyak informasi, panduan dan petunjuk terkait SPBE
          (Sistem Pemerintahan Berbasis Elektronik) di lingkungan Pemerintah Daerah DIY.</p>
          <hr></hr>
        </div>
        <h2 id="organisasi" className='content-h2'>Organisasi Perangkat Daerah Pemda DIY</h2>
        <ul className="numbered">
          {(contents || []).map(content => (
            <li key={content.id}>
              <Link to={`/informasi/${content.id}`}>{content.title}</Link>
            </li>
          ))}
        </ul>

        {user && (user.role_id === 1 ||  user.role_id === 3) && (
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