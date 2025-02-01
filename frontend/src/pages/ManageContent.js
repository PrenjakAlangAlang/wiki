import React, { useState, useEffect } from "react";
import { Link, useNavigate } from "react-router-dom";
import { FaInfoCircle, FaCheck, FaTimes } from "react-icons/fa";
import ApprovalCard from "../component/ApprovalCard";

const ManageContent = () => {
  const [contents, setContents] = useState([]);
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 10;
  const navigate = useNavigate();
  const [user, setUser] = useState(null);
  const [isApprovalOpen, setIsApprovalOpen] = useState(false);
  const [approvalMessage, setApprovalMessage] = useState("");
  const [pendingAction, setPendingAction] = useState(null);

  useEffect(() => {
    const storedUser = JSON.parse(localStorage.getItem("user"));
    const token = localStorage.getItem("token");

    const fetchUserData = async () => {
      if (!token) {
        console.warn("No token found!");
        setUser(storedUser);
        return;
      }

      try {
        const response = await fetch("/api/decode", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: JSON.stringify({
            encrypted_token: token, // Kirim token dalam body
          }),
        });

        if (!response.ok) throw new Error("Failed to fetch user data");

        const userData = await response.json();
        setUser(userData);
        console.log("User loaded with permissions:", userData);
      } catch (error) {
        console.error("Error fetching user data:", error);
        setUser(storedUser);
      }
    };

    fetchUserData();

    const fetchContents = async () => {
      try {
        const response = await fetch("http://localhost:3000/api/draft", {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
            Authorization: `Bearer ${token}`,
          },
        });
        const data = await response.json();
        const sortedData = data.sort((a, b) => b.id - a.id);
        setContents(sortedData);
      } catch (error) {
        console.error("Error fetching contents:", error);
      }
    };

    fetchContents();
  }, []);

  const handleApprove = async (id) => {
    if (!user?.permissions?.includes("approve_content")) {
      alert("You don't have permission to approve content.");
      return;
    }
    setApprovalMessage("Apakah Anda yakin ingin menyetujui konten ini?");
    setPendingAction(() => () => approveContent(id));
    setIsApprovalOpen(true);
  };

  const handleReject = async (id) => {
    if (!user?.permissions?.includes("reject_content")) {
      alert("You don't have permission to reject content.");
      return;
    }
    setApprovalMessage("Apakah Anda yakin ingin menolak konten ini?");
    setPendingAction(() => () => rejectContent(id));
    setIsApprovalOpen(true);
  };

  const approveContent = async (id) => {
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
        const formattedMySQLDate = `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")} ${time}`;

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

        //alert("Content approved successfully");//
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

  const rejectContent = async (id) => {
    const token = localStorage.getItem("token");
    try {
      const response = await fetch(`http://localhost:3000/api/content/reject/${id}`, {
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
        const formattedMySQLDate = `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")} ${time}`;

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

        //alert("Content rejected successfully");//
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
              {path.link ? <Link to={path.link}>{path.label}</Link> : <span>{path.label}</span>}
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
        <Breadcrumbs paths={[{ label: "Home", link: "/" }, { label: "Manage Content" }]} />
        <div className="manage-content">
          <h1 className="manage-content-h1">Manage Content</h1>
          <p className="manage-content-p">Manage, optimize, and distribute your content easily to achieve maximum results.</p>
        </div>
        <table className="table-manage">
          <thead className="thead-manage">
            <tr>
              <th style={{ width: "40%" }}>Title</th>
              <th style={{ width: "20%" }}>Author</th>
              <th style={{ width: "40%" }} colSpan={3}>
                Actions
              </th>
            </tr>
          </thead>
          <tbody>
            {currentContents.map((content) => (
              <tr key={content.id}>
                <td>{content.title}</td>
                <td>{content.author_name}</td>
                <td>
                  <Link to={`/content/${content.id}`} className="no-underline">
                    <button className="Detail Button" style={{ display: "flex", alignItems: "center" }}>
                      <FaInfoCircle style={{ marginRight: "5px" }} /> Detail
                    </button>
                  </Link>
                </td>
                {user?.permissions?.includes("approve_content") && (
                  <td>
                    <button className="Detail Approve" onClick={() => handleApprove(content.id)} style={{ display: "flex", alignItems: "center" }}>
                      <FaCheck style={{ marginRight: "5px" }} /> Approve
                    </button>
                  </td>
                )}
                {user?.permissions?.includes("reject_content") && (
                  <td>
                    <button className="Detail Reject" onClick={() => handleReject(content.id)} style={{ display: "flex", alignItems: "center" }}>
                      <FaTimes style={{ marginRight: "5px" }} /> Reject
                    </button>
                  </td>
                )}
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
            <button key={index + 1} onClick={() => handlePageChange(index + 1)} className={currentPage === index + 1 ? "active" : ""}>
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
      <ApprovalCard
        isOpen={isApprovalOpen}
        message={approvalMessage}
        onConfirm={() => {
          if (pendingAction) pendingAction();
          setIsApprovalOpen(false);
        }}
        onCancel={() => setIsApprovalOpen(false)}
      />
    </div>
  );
};

export default ManageContent;
