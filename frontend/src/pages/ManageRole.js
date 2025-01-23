import React, { useState, useEffect, useCallback } from "react";
import { Link } from "react-router-dom";
import 'font-awesome/css/font-awesome.min.css'; // Pastikan Font Awesome diimpor

const ManageRole = () => {
  const [permission, setPermission] = useState([]);
  const [roles, setRoles] = useState([]);
  const [openedRoleId, setOpenedRoleId] = useState(null);
  const [dropdownOpen, setDropdownOpen] = useState({});

  const fetchToken = () => {
    return localStorage.getItem("token");
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
      method,
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => {
        console.log("Permission updated:", data);
        fetchPermissions();
      })
      .catch((err) => console.error("Failed to update permission:", err));
  };

  const toggleDropdown = (roleId) => {
    setOpenedRoleId((prev) => (prev === roleId ? null : roleId));
  };

  const toggleCategoryDropdown = (category) => {
    setDropdownOpen((prev) => ({
      ...prev,
      [category]: !prev[category]
    }));
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
              {index < paths.length - 1 && " / "}
            </li>
          ))}
        </ul>
      </nav>
    );
  };

  const categorizePermissions = (permissions) => {
    const categories = {
      'View Management': [],
      'Content Management': [],
      'Search Management': [],
      'Role Management': [],
      'History Management': [],
      'Approval Management': [],
    };

    permissions.forEach((perm) => {
      if (perm.name.startsWith("view_")) {
        categories['View Management'].push(perm);
      } else if (perm.name.startsWith("create_") || perm.name.startsWith("edit_") || perm.name.startsWith("delete_")) {
        categories['Content Management'].push(perm);
      } else if (perm.name.startsWith("search_") || perm.name.startsWith("view_user_contents")) {
        categories['Search Management'].push(perm);
      } else if (perm.name.startsWith("view_roles") || perm.name.startsWith("manage_role")) {
        categories['Role Management'].push(perm);
      } else if (perm.name.startsWith("add_history") || perm.name.startsWith("view_history_user") || perm.name.startsWith("view_latest_editor")) {
        categories['History Management'].push(perm);
      } else if (perm.name.startsWith("approve_") || perm.name.startsWith("reject_")) {
        categories['Approval Management'].push(perm);
      }
    });

    return categories;
  };

  const categorizedPermissions = categorizePermissions(permission);

  return (
    <div className="main-container">
      <div className="table-container">
        <Breadcrumbs
          paths={[
            { label: "Home", link: "/" },
            { label: "Manage Role" },
          ]}
        />
        <div className="manage-content">
          <h1 className="manage-content-h1">Manage Role</h1>
          <p className='manage-content-p'>Manage, optimize, and distribute your content easily to achieve maximum results.</p>
        </div>
        {Array.isArray(roles) && (
          <div className="card">
            <div className="rolem">
            <h3>Select role</h3>
            <span>Please select a role:</span>
           
            <hr className="hrrole"></hr>
            </div>
            <table className="managerole">
              <tbody>
                {roles.map((role) => (
                  <React.Fragment key={role.id}>
                    <tr>
                      <td>
                        <div
                          className="role-header"
                          onClick={() => toggleDropdown(role.id)}
                          style={{ cursor: 'pointer', fontWeight:'bold', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}
                        >
                          <span>{role.name}</span>
                          <span style={{ display: 'flex', alignItems: 'center' }}>
                            <span style={{ marginRight: '10px' }}></span>
                            <i className={`fa ${openedRoleId === role.id ? 'fa-chevron-up' : 'fa-chevron-down'} icon-animate`} style={{ marginLeft: '10px' }}></i>
                          </span>
                        </div>
                      </td>
                    </tr>
                    {openedRoleId === role.id && (
                      <tr>
                        <td>
                          <table className="managerole" style={{ width: '100%', marginTop: '10px' }}>
                            <tbody>
                              {Object.keys(categorizedPermissions).map((category) => (
                                <React.Fragment key={category}>
                                  <tr>
                                    <td>
                                      <span onClick={() => toggleCategoryDropdown(category)} style={{ cursor: 'pointer', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
                                        <span>{category}</span>
                                        <i className={`fa ${dropdownOpen[category] ? 'fa-chevron-up' : 'fa-chevron-down'} icon-animate`} style={{ marginLeft: '10px' }}></i>
                                      </span>
                                    </td>
                                  </tr>
                                  {dropdownOpen[category] && (
                                    <tr>
                                      <td>
                                        <table className="manageuser" style={{ width: '100%', marginTop: '5px' }}>
                                          <thead>
                                            <tr>
                                              <th>Permission Name</th>
                                              <th>Action</th>
                                            </tr>
                                          </thead>
                                          <tbody>
                                            {categorizedPermissions[category].map((perm) => (
                                              <tr key={perm.id}>
                                                <td>{perm.name}</td>
                                                <td>
                                                  <label className="custom-checkbox">
                                                    <input
                                                      type="checkbox"
                                                      disabled={role.id === 5}
                                                      checked={role.id === 5 ? true : Math.random() < 0.5} // Ganti logika bila diperlukan
                                                      onChange={(e) =>
                                                        handleCheckboxChange(role.id, perm.id, e.target.checked)
                                                      }
                                                    />
                                                  </label>
                                                </td>
                                              </tr>
                                            ))}
                                          </tbody>
                                        </table>
                                      </td>
                                    </tr>
                                  )}
                                </React.Fragment>
                              ))}
                            </tbody>
                          </table>
                        </td>
                      </tr>
                    )}
                  </React.Fragment>
                ))}
              </tbody>
            </table>
          </div>
        )}
      </div>
    </div>
  );
};

export default ManageRole;

