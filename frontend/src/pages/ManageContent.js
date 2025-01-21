import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";
import { FaInfoCircle, FaCheck, FaTimes } from 'react-icons/fa';

const ManageContent = () => {
  const [contents, setContents] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 10;
  const navigate = useNavigate();
  const [user, setUser] = useState(() => {
    try {
      return JSON.parse(localStorage.getItem("user")) || null;
    } catch {
      return null;
    }
  });

  useEffect(() => {
    if (!user || (user.role_id !== 1 && user.role_id !== 2)) {
      navigate("/"); // Redirect jika bukan user dengan role 1 atau 2
      return;
    }

    const fetchContents = async () => {
      const token = localStorage.getItem("token");
      try {
        const response = await fetch("http://localhost:3000/api/draft", {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
        });
        const data = await response.json();
        setContents(data);
      } catch (error) {
        console.error("Error fetching contents:", error);
      }
    };

    fetchContents();
  }, [user, navigate]);

  const handleApprove = async (id) => {
    const token = localStorage.getItem("token");
    try {
        const response = await fetch(`http://localhost:3000/api/content/approve/${id}`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                Authorization: `Bearer ${token}`,
            },
            body: JSON.stringify({ status: "Approving" }), // Update status to "approved"
        });

        if (response.ok) {
            // Mendapatkan waktu lokal dalam zona waktu WIB
            const currentDate = new Date();
            const formattedDate = currentDate.toLocaleString("en-US", {
                timeZone: "Asia/Jakarta",
                hour12: false,
            });

            // Mengonversi waktu ke format yang sesuai MySQL (YYYY-MM-DD HH:MM:SS)
            const [date, time] = formattedDate.split(", ");
            const [month, day, year] = date.split("/");
            const formattedMySQLDate = `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')} ${time}`;

            const historyData = {
                content_id: id, // content_id digunakan di tabel history
                editor_id: user.id, // ID user yang sedang login
                action: "Approving", // Tindakan yang dilakukan
                edited_at: formattedMySQLDate, // Waktu perubahan dengan format yang sesuai MySQL
            };

            const historyResponse = await fetch(`http://localhost:3000/api/history/add`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    Authorization: `Bearer ${token}`,
                },
                body: JSON.stringify(historyData),
            });

            const historyResponseText = await historyResponse.text();
            if (!historyResponse.ok) {
                console.error("Failed to record edit history:", historyResponseText);
                alert("Something went wrong while saving history. Please try again."); // Warning alert if history insertion fails
                return; // Prevent further actions if history is not recorded
            }

            alert("Content approved successfully");
            setContents((prevContents) => prevContents.filter((content) => content.id !== id)); // Remove the content from the list
            setCurrentPage(1); // Reset to the first page
        } else {
            alert("Failed to approve content");
            console.error("Failed to approve content:", response.statusText);
        }
    } catch (error) {
        console.error("Error approving content:", error);
        alert("An error occurred while approving the content. Please check the console for more details.");
    }
  };

  const handleReject = async (id) => {
    const token = localStorage.getItem("token");
    try {
        const response = await fetch(`http://localhost:3000/api/content/approve/${id}`, {
            method: "PUT",
            headers: {
                "Content-Type": "application/json",
                Authorization: `Bearer ${token}`,
            },
            body: JSON.stringify({ status: "Rejecting" }), // Update status to "approved"
        });

        if (response.ok) {
            // Mendapatkan waktu lokal dalam zona waktu WIB
            const currentDate = new Date();
            const formattedDate = currentDate.toLocaleString("en-US", {
                timeZone: "Asia/Jakarta",
                hour12: false,
            });

            // Mengonversi waktu ke format yang sesuai MySQL (YYYY-MM-DD HH:MM:SS)
            const [date, time] = formattedDate.split(", ");
            const [month, day, year] = date.split("/");
            const formattedMySQLDate = `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')} ${time}`;

            const historyData = {
                content_id: id, // content_id digunakan di tabel history
                editor_id: user.id, // ID user yang sedang login
                action: "Rejecting", // Tindakan yang dilakukan
                edited_at: formattedMySQLDate, // Waktu perubahan dengan format yang sesuai MySQL
            };

            const historyResponse = await fetch(`http://localhost:3000/api/history/add`, {
                method: "POST",
                headers: {
                    "Content-Type": "application/json",
                    Authorization: `Bearer ${token}`,
                },
                body: JSON.stringify(historyData),
            });

            const historyResponseText = await historyResponse.text();
            if (!historyResponse.ok) {
                console.error("Failed to record edit history:", historyResponseText);
                alert("Something went wrong while saving history. Please try again."); // Warning alert if history insertion fails
                return; // Prevent further actions if history is not recorded
            }

            alert("Content rejected successfully");
            setContents((prevContents) => prevContents.filter((content) => content.id !== id)); // Remove the content from the list
            setCurrentPage(1); // Reset to the first page
        } else {
            alert("Failed to reject content");
            console.error("Failed to reject content:", response.statusText);
        }
    } catch (error) {
        console.error("Error rejecting content:", error);
        alert("An error occurred while rejecting the content. Please check the console for more details.");
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
            { label: "Manage Content" }, // Halaman saat ini tidak memiliki link
          ]} 
        />
        <div className="manage-content">
          <h1 className="manage-content-h1">Manage Content</h1>
          <p className='manage-content-p'>Manage, optimize, and distribute your content easily to achieve maximum results.</p>
        </div>
        <table className="table-manage">
          <thead className="thead-manage">
            <tr>
              <th style={{ width: '40%' }}>Title</th>
              <th style={{ width: '20%' }}>Author</th>
              <th style={{ width: '40%' }} colSpan={3}>Actions</th>
            </tr>
          </thead>
          <tbody>
            {currentContents
              .sort((a, b) => b.id - a.id) // Mengurutkan berdasarkan id terbesar ke terkecil
              .map((content) => (
                <tr key={content.id}>
                  <td>{content.title}</td>
                  <td>{content.author_name}</td>
                  <td>
                    <Link to={`/content/${content.id}`} className="no-underline">
                      <button className="Detail Button" style={{ display: 'flex', alignItems: 'center' }}>
                        <FaInfoCircle style={{ marginRight: '5px' }} /> Detail
                      </button>
                    </Link>
                  </td>
                  <td>
                    <button className="Detail Approve" onClick={() => handleApprove(content.id)} style={{ display: 'flex', alignItems: 'center' }}>
                      <FaCheck style={{ marginRight: '5px' }} /> Approve
                    </button>
                  </td>
                  <td>
                    <button className="Detail Reject" onClick={() => handleReject(content.id)} style={{ display: 'flex', alignItems: 'center' }}>
                      <FaTimes style={{ marginRight: '5px' }} /> Reject
                    </button>
                  </td>
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

export default ManageContent;