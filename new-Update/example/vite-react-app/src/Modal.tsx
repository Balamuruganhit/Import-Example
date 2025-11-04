import React from "react";
import "./Modal.css";

interface ModalProps {
  show: boolean;
  title: string;
  data: string[];
  loading?: boolean;
  error?: string | null;
  onClose: () => void;
}

const Modal: React.FC<ModalProps> = ({ show, title, data, loading, error, onClose }) => {
  if (!show) return null;

  return (
    <div className="modal-overlay">
      <div className="modal-card">
        <div className="modal-header">
          <h3>{title}</h3>
          <button className="modal-close" onClick={onClose}>
            ×
          </button>
        </div>
        <div className="modal-body">
          {loading ? (
            <p>Loading...</p>
          ) : error ? (
            <p style={{ color: "red" }}>{error}</p>
          ) : data.length > 0 ? (
            <ul className="modal-list">
              {data.map((id, idx) => (
                <li key={idx}>{id}</li>
              ))}
            </ul>
          ) : (
            <p>No orders found for this status.</p>
          )}
        </div>
        <div className="modal-footer">
          <button className="modal-btn" onClick={onClose}>
            Close
          </button>
        </div>
      </div>
    </div>
  );
};

export default Modal;
