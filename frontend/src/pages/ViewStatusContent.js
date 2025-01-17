import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';

const ViewStatusContent = () => {
    const [contents, setContents] = useState([]);
    const navigate = useNavigate();
    const [user, setUser] = useState(() => {
        try {
            return JSON.parse(localStorage.getItem('user')) || null;
        } catch {
            return null;
        }
    });

    useEffect(() => {
        if (!user || user.role_id !== 3) {
            navigate('/'); // Redirect jika bukan user dengan role 3
            return;
        }

        const fetchContents = async () => {
            const token = localStorage.getItem('token');
            try {
                const response = await fetch(`http://localhost:3000/api/contents/user/${user.id}`, {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                        Authorization: `Bearer ${token}`,
                    },
                });
                const data = await response.json();
                setContents(data);
            } catch (error) {
                console.error('Error fetching contents:', error);
            }
        };

        fetchContents();
    }, [user, navigate]);

    return (
        <div className="main-container">
            <div className="table-container">
                <div className="view-status-header">
                <h1 className="view-status-content-h1">View Status Content</h1>
                <p className="view-status-content-p">Tracking Progress with View Status Content</p>
                </div>
                <table className="view-status">
                    <thead className="thead-status">
                        <tr>
                            <th>Title</th>
                            <th>Created</th>
                            <th>Updated</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        {contents.map(content => (
                            <tr key={content.id}>
                                <td>{content.title}</td>
                                <td>{content.created_at}</td>
                                <td>{content.updated_at}</td>
                                <td>{content.status}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
};

export default ViewStatusContent;