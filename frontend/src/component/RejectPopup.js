// src/component/RejectPopup.js
import React from "react";

const RejectPopup = ({ isOpen, onConfirm, onCancel, rejectReason, setRejectReason }) => {
  if (!isOpen) return null;

  return (
    <div className="popup-overlay">
      <div className="popup-content">
        <h3>Alasan Penolakan</h3>
        <textarea
          value={rejectReason}
          onChange={(e) => setRejectReason(e.target.value)}
          placeholder="Masukkan alasan penolakan..."
          rows="4"
          required
        />
        <div className="popup-buttons">
          <button onClick={onCancel}>Cancel</button>
          <button onClick={onConfirm}>Reject Content</button>
        </div>
      </div>
    </div>
  );
};

export default RejectPopup;