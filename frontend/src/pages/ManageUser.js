import React, { useState, useEffect, useCallback } from "react";
import { Link } from "react-router-dom";
import { FaEye, FaEyeSlash } from "react-icons/fa";
import { FaInfoCircle, FaTrash } from "react-icons/fa";
const ManageUser = () => {
  const [user, setUser] = useState(null);
  const [users, setUsers] = useState([]);
  const [roles, setRoles] = useState([]);
  const [instances, setInstances] = useState([]);
  const [formData, setFormData] = useState({
    name: "",
    nip: "",
    email: "",
    password: "",
    role_id: "",
    instance_id: "",
  });
  const [passwordVisible, setPasswordVisible] = useState(false);
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 10;

  const fetchToken = () => {
    // Dapatkan token dari localStorage atau dari state aplikasi Anda
    return localStorage.getItem("token"); // Sesuaikan sesuai kebutuhan
  };

  const fetchUsers = useCallback(() => {
    const token = fetchToken();
    fetch("http://localhost:3000/api/users", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => setUsers(data))
      .catch((err) => console.error("Failed to fetch users:", err));
  }, []);

  const fetchRoles = useCallback(() => {
    const token = fetchToken();
    fetch("http://localhost:3000/api/roles", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => setRoles(data))
      .catch((err) => console.error("Failed to fetch roles:", err));
  }, []);

  const fetchInstances = useCallback(() => {
    const token = fetchToken();
    fetch("http://localhost:3000/api/instances", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => setInstances(data))
      .catch((err) => console.error("Failed to fetch instances:", err));
  }, []);

  useEffect(() => {
    const storedUser = JSON.parse(localStorage.getItem("user"));
    const token = localStorage.getItem("token");

    if (token) {
      try {
        // Decode token to extract permissions
        const tokenData = JSON.parse(atob(token.split(".")[1]));
        const userWithPermissions = {
          ...storedUser,
          permissions: tokenData.permissions || [],
        };
        setUser(userWithPermissions);
        console.log("User loaded with permissions:", userWithPermissions);
      } catch (e) {
        console.error("Error parsing token:", e);
        setUser(storedUser);
      }
    } else {
      console.warn("No token found!");
      setUser(storedUser);
    }

    fetchUsers();
    fetchRoles();
    fetchInstances();
  }, [fetchUsers, fetchRoles, fetchInstances]);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevState) => ({
      ...prevState,
      [name]: value,
    }));
  };

  const handleFormSubmit = (e) => {
    e.preventDefault();

    if (!user?.permissions?.includes("create_user")) {
      alert("You don't have permission to create users.");
      return;
    }

    const token = fetchToken();
    fetch("http://localhost:3000/api/createuser", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
      body: JSON.stringify(formData),
    })
      .then((res) => res.json())
      .then(() => {
        alert("User added successfully!");
        setFormData({
          name: "",
          nip: "",
          email: "",
          password: "",
          role_id: "",
          instance_id: "",
        });
        fetchUsers(); // Refresh user list
      })
      .catch((err) => console.error("Failed to add user:", err));
  };

  const handleDelete = async (id) => {
    const isConfirmed = window.confirm("Are you sure you want to delete this user?");
    if (!isConfirmed) return;

    try {
      const token = fetchToken();
      const response = await fetch(`http://localhost:3000/api/user/${id}`, {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
      });

      if (response.ok) {
        alert("User deleted successfully!");
        fetchUsers(); // Refresh user list
      } else {
        alert("Failed to delete user.");
      }
    } catch (error) {
      console.error("Error deleting user:", error);
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

  // Calculate the current users to display based on the current page
  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentUsers = users.slice(indexOfFirstItem, indexOfLastItem);

  // Handle page change
  const handlePageChange = (pageNumber) => {
    setCurrentPage(pageNumber);
  };

  // Calculate total pages
  const totalPages = Math.ceil(users.length / itemsPerPage);

  return (
    <div className="main-container">
      <div className="table-container">
        <Breadcrumbs
          paths={[
            { label: "Home", link: "/" },
            { label: "Manage User" }, // Halaman saat ini tidak memiliki link
          ]}
        />
        <div className="text text-gradient">Manage User</div>
        <table className="manageuser">
          <thead className="theaduser">
            <th>Name</th>
            <th>Role</th>
            <th>Instance</th>
            <th colSpan={2}>Actions</th>
          </thead>
          <tbody>
            {Array.isArray(currentUsers) &&
              currentUsers.map((userItem) => (
                <tr key={userItem.id}>
                  <td>{userItem.name}</td>
                  <td>{userItem.role_name}</td>
                  <td>{userItem.instance}</td>
                  <td>
                    <Link to={`/detail/${userItem.id}`}>
                      <button className="green-button" style={{ display: "flex", alignItems: "center" }}>
                        <FaInfoCircle style={{ marginRight: "5px", paddingBottom: "3px" }} /> Detail
                      </button>
                    </Link>
                  </td>
                  {/* Validasi tombol delete berdasarkan izin pengguna yang sedang login */}
                  {user?.permissions?.includes("delete_user") && (
                    <td>
                      <button className="btn btn-red" onClick={() => handleDelete(userItem.id)} style={{ display: "flex", alignItems: "center" }}>
                        <FaTrash style={{ marginRight: "5px", paddingBottom: "3px" }} /> Delete
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

      {user?.permissions?.includes("create_user") && (
        <div className="form-container">
          <div className="text text-gradient">Add New User</div>
          <form onSubmit={handleFormSubmit}>
            <div className="form-row">
              <div className="input-data">
                <label>Name</label>
                <input type="text" name="name" value={formData.name} onChange={handleInputChange} required />
              </div>
            </div>

            <div className="form-row">
              <div className="input-data">
                <label>NIP</label>
                <input type="text" name="nip" value={formData.nip} onChange={handleInputChange} required />
              </div>
            </div>

            <div className="form-row">
              <div className="input-data">
                <label>Email</label>
                <input type="email" name="email" value={formData.email} onChange={handleInputChange} required />
              </div>
            </div>

            <div className="form-row">
              <div className="input-data">
                <label>Password</label>
                <div style={{ display: "flex", alignItems: "center" }}>
                  <input type={passwordVisible ? "text" : "password"} name="password" value={formData.password} onChange={handleInputChange} required />
                  <button type="button" onClick={() => setPasswordVisible(!passwordVisible)} style={{ marginLeft: "10px", background: "none", border: "none" }}>
                    {passwordVisible ? <FaEyeSlash /> : <FaEye />}
                  </button>
                </div>
              </div>
            </div>

            <div className="form-row">
              <div className="input-data">
                <label>Role</label>
                <select name="role_id" value={formData.role_id || ""} onChange={handleInputChange} required>
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
                <label>Instance</label>
                <select name="instance_id" value={formData.instance_id} onChange={handleInputChange} required>
                  <option value="">Select Instance</option>
                  {instances.map((instance) => (
                    <option key={instance.id} value={instance.id}>
                      {instance.name}
                    </option>
                  ))}
                </select>
              </div>
            </div>

            <input type="button" value="Add User" className="btn btn-blue" onClick={handleFormSubmit} />
          </form>
        </div>
      )}
    </div>
  );
};

export default ManageUser;
