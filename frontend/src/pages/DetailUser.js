import React, { useState, useEffect } from "react";
import { useParams, Link } from "react-router-dom";
import { FaEye, FaEyeSlash } from "react-icons/fa";

const DetailUser = () => {
  const [mergedData, setMergedData] = useState([]);
  const [user, setUser] = useState(null);
  const [roles, setRoles] = useState([]);
  const [instances, setInstances] = useState([]);
  const [isEditing, setIsEditing] = useState(false);
  const [formData, setFormData] = useState({
    id: "",
    name: "",
    nip: "",
    email: "",
    password: "",
    role_id: "",
    instance_id: "",
  });
  const [histories, setHistories] = useState([]);
  const [showHistory, setShowHistory] = useState(false);
  const [contents, setContents] = useState([]);
  const { id } = useParams();
  const [passwordVisible, setPasswordVisible] = useState(false);
  const [currentUser, setCurrentUser] = useState(null);
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 10;

  // Retrieve token from localStorage (or sessionStorage)
  const token = localStorage.getItem("token");

  useEffect(() => {
    const storedUser = JSON.parse(localStorage.getItem("user"));
    if (storedUser) setCurrentUser(storedUser);

    // Fetch user details with token in Authorization header
    fetch(`http://localhost:3000/api/user/${id}`, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => {
        setUser(data);
        setFormData({
          id: data.id,
          name: data.name,
          nip: data.nip,
          email: data.email,
          password: data.password,
          role_id: data.role_id,
          instance_id: data.instance_id,
        });
      })
      .catch((err) => console.error("Failed to fetch user:", err));

    // Fetch roles with token
    fetch("http://localhost:3000/api/roles", {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => setRoles(data))
      .catch((err) => console.error("Failed to fetch roles:", err));

    // Fetch instances with token
    fetch("http://localhost:3000/api/instances", {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => setInstances(data))
      .catch((err) => console.error("Failed to fetch instances:", err));

    // Fetch contents with token
    fetch("http://localhost:3000/api", {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => setContents(data || []))
      .catch((err) => console.error("Failed to fetch contents:", err));
  }, [id, token]);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevState) => ({
      ...prevState,
      [name]: value,
    }));
  };

  const handleFormSubmit = (e) => {
    e.preventDefault();

    const formattedData = {
      ...formData,
      nip: parseInt(formData.nip, 10),
      role_id: parseInt(formData.role_id, 10),
      instance_id: parseInt(formData.instance_id, 10),
    };

    // Submit form with token in Authorization header
    fetch(`http://localhost:3000/api/user/edit/${formData.id}`, {
      method: "PUT",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
      body: JSON.stringify(formattedData),
    })
      .then((res) => {
        if (!res.ok) {
          throw new Error("Failed to update user");
        }
        return res.json();
      })
      .then(() => {
        alert("User updated successfully!");
        setIsEditing(false);
        fetch(`http://localhost:3000/api/user/${id}`, {
          headers: {
            Authorization: `Bearer ${token}`,
          },
        })
          .then((res) => res.json())
          .then((data) => setUser(data))
          .catch((err) => console.error("Failed to fetch updated user:", err));
      })
      .catch((err) => console.error("Failed to update user:", err));
  };

  const loadHistories = () => {
    // Fetch history with token
    fetch(`http://localhost:3000/api/history/user/${id}`, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => setHistories(data || []))
      .catch((err) => console.error("Failed to fetch histories:", err));

    // Fetch contents with token
    fetch(`http://localhost:3000/api/contents/user/${id}`, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => setContents(data || []))
      .catch((err) => console.error("Failed to fetch contents:", err));
  };

  const handleToggleHistory = () => {
    if (!showHistory) {
      loadHistories();
    }
    setShowHistory(!showHistory);
  };

  const formatDateTime = (dateTime) => {
    if (!dateTime) return "Invalid Date";

    const parsedDate = new Date(dateTime.replace(" ", "T"));
    if (isNaN(parsedDate)) return "Invalid Date"; // Cek apakah parsing valid

    // Format waktu (jam:menit)
    const optionsTime = {
      hour: "2-digit",
      minute: "2-digit",
    };
    const formattedTime = new Intl.DateTimeFormat("id-ID", optionsTime).format(
      parsedDate
    );

    // Format tanggal (tanggal bulan tahun dalam bahasa Indonesia)
    const optionsDate = {
      day: "numeric",
      month: "long", // Menggunakan bulan lengkap (Desember)
      year: "numeric",
    };
    const formattedDate = new Intl.DateTimeFormat("id-ID", optionsDate).format(
      parsedDate
    );

    // Gabungkan jam dan tanggal dengan pemisah "-"
    return `${formattedTime} - ${formattedDate}`;
  };

  // Fungsi untuk mendapatkan title konten berdasarkan ID
  const getContentTitle = (contentId) => {
    // Mencari content berdasarkan contentId yang ada di tabel contents
    const content = contents.find((content) => content.id === contentId);
    return content ? content.title : "Unknown Title";  // Jika ditemukan, tampilkan title, jika tidak tampilkan Unknown Title
  };

  useEffect(() => {
    if (contents && histories) {
      // Buat objek lookup untuk mempercepat pencarian title berdasarkan id
      const contentMap = contents.reduce((map, content) => {
        map[content.id] = content.title; // key: content.id, value: content.title
        return map;
      }, {});

      const newMergedData = [
        // Data dari histories
        ...histories.map((history) => {
          const title = contentMap[history.content_id] || "Unknown Content"; // Ambil title dari contentMap
          return {
            type: "history",
            id: history.id,
            title, // Gunakan title dari contentMap
            created_at: history.edited_at,
            action: history.action || "Edit", // Use the action directly from the database
          };
        }),

        // Data dari contents
        ...contents.map((content) => ({
          type: "content",
          id: content.id,
          title: content.title,
          created_at: content.created_at,
          action: "Create",
        })),
      ];

      // Urutkan berdasarkan tanggal terbaru
      newMergedData.sort((a, b) => new Date(b.created_at) - new Date(a.created_at));

      // Update state mergedData
      setMergedData(newMergedData);
    }
  }, [contents, histories]);

  // Calculate the current items to display based on the current page
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentMergedData = mergedData.slice(indexOfFirstItem, indexOfLastItem);

  // Handle page change
  const handlePageChange = (pageNumber) => {
    setCurrentPage(pageNumber);
  };

  // Calculate total pages
  const totalPages = Math.ceil(mergedData.length / itemsPerPage);

  // Menangani loading state
  if (!user || !contents || !histories) {
    return <div>Loading...</div>;
  }

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
    <div className="container-wrapper profile-wrapper">
      <div className="container">
        <Breadcrumbs
          paths={[
            { label: "Home", link: "/" },
            { label: "Manage User", link: `/manage` },
            { label: "Detail User" },
          ]}
        />
        <div className="text text-gradient">Detail User</div>
        {!isEditing ? (
          <>
            <table className="profile-table">
              <tbody>
                <tr>
                  <td>
                    <strong>Name</strong>
                  </td>
                  <td>{user.name}</td>
                </tr>
                <tr>
                  <td>
                    <strong>NIP</strong>
                  </td>
                  <td>{user.nip}</td>
                </tr>
                <tr>
                  <td>
                    <strong>Email</strong>
                  </td>
                  <td>{user.email}</td>
                </tr>
                <tr>
                  <td>
                    <strong>Role</strong>
                  </td>
                  <td>{user.role_name}</td>
                </tr>
                <tr>
                  <td>
                    <strong>Instance</strong>
                  </td>
                  <td>{user.instance}</td>
                </tr>
              </tbody>
            </table>
            <input
              type="button"
              value="Edit"
              className="btn btn-blue"
              onClick={() => setIsEditing(true)}
            />
          </>
        ) : (
          <form onSubmit={handleFormSubmit}>
            <div className="form-row">
              <div className="input-data">
                <label>Name</label>
                <input
                  type="text"
                  name="name"
                  value={formData.name}
                  onChange={handleInputChange}
                  required
                />
              </div>
            </div>
            <div className="form-row">
              <div className="input-data">
                <label>NIP:</label>
                <input
                  type="text"
                  name="nip"
                  value={formData.nip}
                  onChange={handleInputChange}
                  required
                />
              </div>
            </div>
            <div className="form-row">
              <div className="input-data">
                <label>Email:</label>
                <input
                  type="email"
                  name="email"
                  value={formData.email}
                  onChange={handleInputChange}
                  required
                />
              </div>
            </div>
            <div className="form-row">
              <div className="input-data">
                <label>Password</label>
                <div style={{ display: "flex", alignItems: "center" }}>
                  <input
                    type={passwordVisible ? "text" : "password"} // Toggle password visibility
                    name="password"
                    value={formData.password}
                    onChange={handleInputChange}
                    required
                  />
                  <button
                    type="button"
                    onClick={() => setPasswordVisible(!passwordVisible)}
                    style={{
                      marginLeft: "10px",
                      background: "none",
                      border: "none",
                    }}
                  >
                    {passwordVisible ? <FaEyeSlash /> : <FaEye />}{" "}
                    {/* Icon to toggle visibility */}
                  </button>
                </div>
              </div>
            </div>
            <div className="form-row">
              <div className="input-data">
                <label>Role:</label>
                <select
                  style={{
                    backgroundColor:
                      formData.id === currentUser.id ? "#e0e0e0" : "white",
                  }}
                  disabled={formData.id === currentUser.id}
                  name="role_id"
                  value={formData.role_id}
                  onChange={handleInputChange}
                  required
                >
                  <option value="">Select Role</option>
                  {roles.map((role) => (
                    <option key={role.id} value={role.id}>
                      {role.name}
                    </option>
                  ))}
                </select>
              </div>
            </div>
            <div className="form-row">
              <div className="input-data">
                <label>Instance:</label>
                <select
                  name="instance_id"
                  value={formData.instance_id}
                  onChange={handleInputChange}
                  required
                >
                  <option value="">Select Instance</option>
                  {instances.map((instance) => (
                    <option key={instance.id} value={instance.id}>
                      {instance.name}
                    </option>
                  ))}
                </select>
              </div>
            </div>
            <div className="form-row submit-btn">
              <div className="input-data">
                <div className="inner"></div>
                {/* <input type="submit" value="Save Changes" /> */}
                <input
                  type="submit"
                  value="Save Changes"
                  className="btn btn-blue"
                />
              </div>
            </div>

            <input
              type="button"
              value="Cancel"
              className="btn btn-gray"
              onClick={() => setIsEditing(false)}
            />
          </form>
        )}

        <input
          type="button"
          value={showHistory ? "Hide History" : "Show History"}
          className="btn btn-gray"
          onClick={handleToggleHistory}
        />

        {showHistory && (
          <>
            <table className="history-table">
              <thead className="thead">
                <tr>
                  <th>Title</th>
                  <th>Date</th>
                  <th>Action</th>
                </tr>
              </thead>
              <tbody>
                {currentMergedData.map((item) => (
                  <tr key={item.id}>
                    <td>{item.title}</td>
                    <td>{formatDateTime(item.created_at)}</td>
                    <td>{item.action}</td>
                  </tr>
                ))}
              </tbody>
            </table>
            <div className="pagination">
              <button onClick={() => handlePageChange(1)} disabled={currentPage === 1}>
                ««
              </button>
              <button onClick={() => handlePageChange(currentPage - 1)} disabled={currentPage === 1}>
                «
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
                »
              </button>
              <button onClick={() => handlePageChange(totalPages)} disabled={currentPage === totalPages}>
                »»
              </button>
            </div>
          </>
        )}
      </div>
    </div>
  );
};

export default DetailUser;