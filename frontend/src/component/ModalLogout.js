import React from 'react';

const ModalLogout = ({ isOpen, onClose }) => {
    if (!isOpen) return null; // Tidak menampilkan modal jika tidak terbuka

    const handleConfirmLogout = () => {
        // Hapus token dan user dari localStorage
        localStorage.removeItem('token');
        localStorage.removeItem('user');
        
        // (Opsional) Redirect ke halaman login
        window.location.href = '/';
    };

    return (
        <div className="modal-overlay">
            <div className="modal-card">
                <h2>Konfirmasi Logout</h2>
                <p>Apakah Anda yakin ingin keluar dari akun?</p>
                <div className="modal-actions">
                    <button className="btn btn-confirm" onClick={handleConfirmLogout}>
                        Logout
                    </button>
                </div>
                <div className="modal-actions">
                    <button className="btn btn-cancel" onClick={onClose}>
                        Batal
                    </button>
                </div>
            </div>
        </div>
    );
};

export default ModalLogout;