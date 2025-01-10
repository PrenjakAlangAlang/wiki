import React from 'react';
 // Pastikan untuk menambahkan styling yang diinginkan

const Sidebar2 = ({ isOpen, onClose }) => {
    return (
        <div className={`sidebar2 ${isOpen ? 'open' : ''}`}>
            <button className="close-btn" onClick={onClose}>×</button>
            <h2>Wiki Pemda DIY</h2>
            <ul>
                <li><a href="/">Home</a></li>
                <li><a href="/profile">Profile</a></li>
                <li><a href="/manage">Manage User</a></li>
                <li><a href="https://api.whatsapp.com/send/?phone=6282133576291&text=Hello&type=phone_number&app_absent=0">FAQ</a></li>
                <li><a href="https://api.whatsapp.com/send/?phone=6282133576291&text=Hello&type=phone_number&app_absent=0">Helpdesk</a></li>
                {/* Tambahkan menu sidebar lainnya di sini */}
            </ul>
        </div>
    );
};

export default Sidebar2;