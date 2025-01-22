import React, { useState, useEffect, useCallback } from "react";
import { Link } from "react-router-dom";
import { FaEye, FaEyeSlash } from "react-icons/fa";
// import { FaInfoCircle, FaTrash } from "react-icons/fa";
const ManageRole = () => {
  const [permission, setPermission] = useState([]);
  const [roles, setRoles] = useState([]);

  const fetchToken = () => {
    // Dapatkan token dari localStorage atau dari state aplikasi Anda
    return localStorage.getItem("token"); // Sesuaikan sesuai kebutuhan
  };

  const fetchPermissions = useCallback(() => {
    const token = fetchToken();
    fetch("http://localhost:3000/api/permissions", {
      method: "GET",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => setPermission(data))
      .catch((err) => console.error("Failed to fetch permission:", err));
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

  useEffect(() => {
    fetchPermissions();
    fetchRoles();
  }, [fetchPermissions, fetchRoles]);

  const handleCheckboxChange = (roleId, permissionId, checked) => {
    const token = fetchToken();
    const url = `http://localhost:3000/api/roles/${roleId}/permissions/${permissionId}`;
    const method = checked ? "POST" : "DELETE";

    fetch(url, {
      method: method,
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => {
        console.log("Permission updated:", data);
        fetchPermissions(); // Refresh permissions
      })
      .catch((err) => console.error("Failed to update permission:", err));
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

  // Handle page change
  //   const handlePageChange = (pageNumber) => {
  //     setCurrentPage(pageNumber);
  //   };

  // Calculate total pages
  //   const totalPages = Math.ceil(users.length / itemsPerPage);

  return (
    <div className="main-container">
      <div className="table-container">
        <Breadcrumbs
          paths={[
            { label: "Home", link: "/" },
            { label: "Manage Role" }, // Halaman saat ini tidak memiliki link
          ]}
        />
        <div className="text text-gradient">Manage Role</div>
        <table className="manageuser">
          <thead className="theaduser">
            <th>Permissions</th>
            {Array.isArray(roles) &&
              roles.map((role) => <th key={role.id}>{role.name}</th>)}
          </thead>
          <tbody>
            {Array.isArray(permission) &&
              permission.map((permission) => (
                <tr key={permission.id}>
                  <td>{permission.name}</td>
                  {roles.map((role) => (
                    <td key={role.id}>
                      <label className="custom-checkbox">
                        <input
                          type="checkbox"
                          disabled={role.id === 5}
                          checked={role.id === 5 ? true : Math.random() < 0.5}

                          onChange={(e) =>
                            handleCheckboxChange(
                              role.id,
                              permission.id,
                              e.target.checked
                            )
                          }
                        />
                        <span className="checkmark"></span>
                      </label>
                    </td>
                  ))}
                </tr>
              ))}
          </tbody>
        </table>
        {/* <div className="pagination"> */}
        {/*   <button
            onClick={() => handlePageChange(1)}
            disabled={currentPage === 1}
          >
            &lt;&lt;
          </button>
          <button
            onClick={() => handlePageChange(currentPage - 1)}
            disabled={currentPage === 1}
          >
            &lt;
          </button> */}
        {/*  {Array.from({ length: totalPages }, (_, index) => (
            <button
              key={index + 1}
              onClick={() => handlePageChange(index + 1)}
              className={currentPage === index + 1 ? "active" : ""}
            >
              {index + 1}
            </button>
          ))}
          <button
            onClick={() => handlePageChange(currentPage + 1)}
            disabled={currentPage === totalPages}
          >
            &gt;
          </button>zx
          <button
            onClick={() => handlePageChange(totalPages)}
            disabled={currentPage === totalPages}
          >
            &gt;&gt;
          </button> */}
        {/* </div> */}
      </div>
    </div>
  );
};

export default ManageRole;
