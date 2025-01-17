import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';

const ManageContent = () => {
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
        if (!user || (user.role_id !== 1 && user.role_id !== 2)) {
            navigate('/'); // Redirect jika bukan user dengan role 1 atau 2
            return;
        }

        const fetchContents = async () => {
            const token = localStorage.getItem('token');
            try {
                const response = await fetch('http://localhost:3000/api/draft', {
                    method: 'GET',
                    headers: {
                        'Content-Type': 'application/json',
                        Authorization: `Bearer ${token}`,
                    },
                });
                const data = await response.json();
                // Filter konten yang berstatus "pending"
                // const filteredContents = data.filter(content => content.status === "pending");
                setContents(data);
                console.log(data[0])
            } catch (error) {
                console.error('Error fetching contents:', error);
            }
        };

        fetchContents();
    }, [user, navigate]);

    const handleApprove = async (id) => {
        const token = localStorage.getItem('token');
        try {
            const response = await fetch(`http://localhost:3000/api/content/approve/${id}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: `Bearer ${token}`,
                },
                body: JSON.stringify({ status: 'approved' }), // Update status to "approved"
            });
            if (response.ok) {
                alert('Content approved successfully');
                setContents(contents.filter(content => content.id !== id));
            } else {
                alert('Failed to approve content');
            }
        } catch (error) {
            console.error('Error approving content:', error);
        }
    };

    const handleReject = async (id) => {
        const token = localStorage.getItem('token');
        try {
            const response = await fetch(`http://localhost:3000/api/content/reject/${id}`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json',
                    Authorization: `Bearer ${token}`,
                },
                body: JSON.stringify({ status: 'rejected' }), // Update status to "rejected"
            });
            if (response.ok) {
                alert('Content rejected successfully');
                setContents(contents.filter(content => content.id !== id));
            } else {
                alert('Failed to reject content');
            }
        } catch (error) {
            console.error('Error rejecting content:', error);
        }
    };
    
    const Breadcrumbs = ({ paths }) => {
        return (
          <nav>
            <ul className="breadcrumbs">
              {paths.map((path, index) => (
                <li key={index}>
                  {path.link ? (
                    <Link to={path.link}>{path.label}</Link>
                  ) : (
                    <span>{path.label}</span>
                  )}
                  {index < paths.length - 1 && " / "} {/* Menambahkan separator */}
                </li>
              ))}
            </ul>
          </nav>
        );
      };

    return (
        <div className="main-container">
            <div className="table-container">
            <Breadcrumbs 
          paths={[
            { label: "Home", link: "/" },
            { label: "Manage Content    " }, // Halaman saat ini tidak memiliki link
          ]} 
        />
                <div className="manage-content">
                <h1 className="manage-content-h1">Manage Content</h1>
                <p className='manage-content-p'>Manage, optimize, and distribute your content easily to achieve maximum results.</p>
                </div>
                <table className="table-manage">
                    <thead className="thead-manage">
                        <tr>
                            <th>Title</th>
                            <th>Author</th>
                            <th colSpan={3}>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {contents.map(content => (
                            <tr key={content.id}>
                                <td>{content.title}</td>
                                <td>{content.author_name}</td>
                                <td>
                                    <Link to={`/content/${content.id}`}>
                                        <button className="Detail Button">Detail</button>
                                    </Link>
                                    
                                    
                                </td>
                                <td><button className="Detail Approve" onClick={() => handleApprove(content.id)}>Approve</button></td>
                                <td><button className="Detail Reject" onClick={() => handleReject(content.id)}>Reject</button></td>
                            </tr>
                        ))}
                    </tbody>
                </table>
            </div>
        </div>
    );
};

export default ManageContent;