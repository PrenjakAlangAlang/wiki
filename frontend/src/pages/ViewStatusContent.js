import React, { useState, useEffect } from 'react';
import { Link, useNavigate } from 'react-router-dom';

const ViewStatusContent = () => {
    const [contents, setContents] = useState([]);
    const [currentPage, setCurrentPage] = useState(1);
    const itemsPerPage = 10;
    const navigate = useNavigate();
    const [user, setUser] = useState(() => {
        try {
            return JSON.parse(localStorage.getItem('user')) || null;
        } catch {
            return null;
        }
    });

    useEffect(() => {
        // if (!user || user.role_id !== 3) {
        //     navigate('/'); // Redirect jika bukan user dengan role 3
        //     return;
        // }

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

    // Calculate the current contents to display based on the current page
    const indexOfLastItem = currentPage * itemsPerPage;
    const indexOfFirstItem = indexOfLastItem - itemsPerPage;
    const currentContents = contents.slice(indexOfFirstItem, indexOfLastItem);

    // Handle page change
    const handlePageChange = (pageNumber) => {
        setCurrentPage(pageNumber);
    };

    // Calculate total pages
    const totalPages = Math.ceil(contents.length / itemsPerPage);

    return (
        <div className="main-container">
            <div className="table-container">
                <Breadcrumbs 
                    paths={[
                        { label: "Home", link: "/" },
                        { label: "View Status Content" }, // Halaman saat ini tidak memiliki link
                    ]} 
                />
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
                        {currentContents.map(content => (
                            <tr key={content.id}>
                                <td>{content.title}</td>
                                <td>{content.created_at}</td>
                                <td>{content.updated_at}</td>
                                <td>{content.status}</td>
                            </tr>
                        ))}
                    </tbody>
                </table>
                <div className="pagination">
                    <button onClick={() => handlePageChange(1)} disabled={currentPage === 1}>
                    &lt;&lt;
                    </button>
                    <button onClick={() => handlePageChange(currentPage - 1)} disabled={currentPage === 1}>
                    &lt;
                    </button>
                    {Array.from({ length: totalPages }, (_, index) => (
                        <button
                            key={index + 1}
                            onClick={() => handlePageChange(index + 1)}
                            className={currentPage === index + 1 ? "active" : ""}
                        >
                            {index + 1}
                        </button>
                    ))}
                    <button onClick={() => handlePageChange(currentPage + 1)} disabled={currentPage === totalPages}>
                    &gt;
                    </button>
                    <button onClick={() => handlePageChange(totalPages)} disabled={currentPage === totalPages}>
                    &gt;&gt;
                    </button>
                </div>
            </div>
        </div>
    );
};

export default ViewStatusContent;