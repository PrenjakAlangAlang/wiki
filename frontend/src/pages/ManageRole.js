import React, { useState, useEffect, useCallback } from "react";
import { Link } from "react-router-dom";
import 'font-awesome/css/font-awesome.min.css';

const ManageRole = () => {
  const [permissions, setPermissions] = useState([]);
  const [roles, setRoles] = useState([]);
  const [currentPermissions, setCurrentPermissions] = useState({});
  const [pendingChanges, setPendingChanges] = useState({});
  const [openedRoleId, setOpenedRoleId] = useState(null);
  const [dropdownOpen, setDropdownOpen] = useState({});

  const fetchToken = () => localStorage.getItem("token");

  const fetchPermissions = useCallback(() => {
    const token = fetchToken();
    fetch("http://localhost:3000/api/permissions", {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then(setPermissions)
      .catch((err) => console.error("Failed to fetch permissions:", err));
  }, []);

  const fetchRolePermissions = useCallback((roleId) => {
    const token = fetchToken();
    fetch(`http://localhost:3001/api/roles/${roleId}/permissions`, {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => {
        setCurrentPermissions((prev) => ({
          ...prev,
          [roleId]: new Set(data.map((p) => p.permission_id)),
        }));
      })
      .catch((err) => console.error("Failed to fetch role permissions:", err));
  }, []);

  const fetchRoles = useCallback(() => {
    const token = fetchToken();
    fetch("http://localhost:3000/api/roles", {
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => {
        setRoles(data);
        data.forEach((role) => fetchRolePermissions(role.id));
      })
      .catch((err) => console.error("Failed to fetch roles:", err));
  }, [fetchRolePermissions]);

  useEffect(() => {
    fetchPermissions();
    fetchRoles();
  }, [fetchPermissions, fetchRoles]);

  const handleCheckboxChange = (roleId, permissionId, checked) => {
    setPendingChanges((prev) => {
      const roleChanges = prev[roleId] || { add: new Set(), remove: new Set() };
      const currentHasPermission = currentPermissions[roleId]?.has(permissionId);

      if (checked !== currentHasPermission) {
        if (checked) {
          roleChanges.add.add(permissionId);
          roleChanges.remove.delete(permissionId);
        } else {
          roleChanges.remove.add(permissionId);
          roleChanges.add.delete(permissionId);
        }
      } else {
        roleChanges.add.delete(permissionId);
        roleChanges.remove.delete(permissionId);
      }

      return { ...prev, [roleId]: roleChanges };
    });
  };

  const isPermissionChecked = (roleId, permissionId) => {
    const currentHasPermission = currentPermissions[roleId]?.has(permissionId) || false;
    const pending = pendingChanges[roleId];

    if (!pending) return currentHasPermission;

    if (pending.add.has(permissionId)) return true;
    if (pending.remove.has(permissionId)) return false;

    return currentHasPermission;
  };

  const savePermissions = async () => {
    const token = fetchToken();
    const savePromises = [];

    console.log("Pending changes: ", pendingChanges); // Debug log untuk memeriksa data

    Object.entries(pendingChanges).forEach(([roleId, changes]) => {
      // Handle additions
      changes.add.forEach((permissionId) => {
        const promise = fetch(
          `http://localhost:3001/api/roles/${roleId}/permissions/add/${permissionId}`,
          {
            method: "POST",
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${token}`,
            },
          }
        )
          .then((res) => res.json())
          .then((data) => {
            if (!data.success) {
              throw new Error("Failed to add permission");
            }
          })
          .catch((err) => {
            console.error("Error adding permission:", err);
          });
        savePromises.push(promise);
      });

      // Handle removals
      changes.remove.forEach((permissionId) => {
        const promise = fetch(
          `http://localhost:3001/api/roles/${roleId}/permissions/delete/${permissionId}`,
          {
            method: "DELETE",
            headers: {
              "Content-Type": "application/json",
              Authorization: `Bearer ${token}`,
            },
          }
        )
          .then((res) => res.json())
          .then((data) => {
            if (!data.success) {
              throw new Error("Failed to remove permission");
            }
          })
          .catch((err) => {
            console.error("Error removing permission:", err);
          });
        savePromises.push(promise);
      });
    });

    try {
      // Wait for all save promises to complete
      await Promise.all(savePromises);

      // Refresh permissions after save
      roles.forEach((role) => fetchRolePermissions(role.id));

      // Clear pending changes and show success message
      setPendingChanges({});
      alert("Permissions saved successfully!");
    } catch (error) {
      console.error("Error saving permissions:", error);
      alert("Error saving permissions. Please try again.");
    }
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

  const categorizedPermissions = categorizePermissions(permissions);

  const hasUnsavedChanges = Object.values(pendingChanges).some(
    (changes) => changes.add.size > 0 || changes.remove.size > 0
  );

  const toggleDropdown = (roleId) => {
    setOpenedRoleId((prevId) => (prevId === roleId ? null : roleId));
  };

  const toggleCategoryDropdown = (category) => {
    setDropdownOpen((prevState) => ({ ...prevState, [category]: !prevState[category] }));
  };

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
          <p className="manage-content-p">
            Manage, optimize, and distribute your content easily to achieve maximum results.
          </p>
        </div>
        {Array.isArray(roles) && (
          <div className="card">
            <div className="rolem">
              <h3>Select role</h3>
              <span>Please select a role:</span>
              <hr className="hrrole" />
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
                          style={{
                            cursor: 'pointer',
                            fontWeight: 'bold',
                            display: 'flex',
                            justifyContent: 'space-between',
                            alignItems: 'center',
                          }}
                        >
                          <span>{role.name}</span>
                          <span style={{ display: 'flex', alignItems: 'center' }}>
                            <i
                              className={`fa ${openedRoleId === role.id ? 'fa-chevron-up' : 'fa-chevron-down'} icon-animate`}
                              style={{ marginLeft: '10px' }}
                            />
                          </span>
                        </div>
                      </td>
                    </tr>
                    {openedRoleId === role.id && (
                      <tr>
                        <td>
                          <table
                            className="managerole"
                            style={{ width: '100%', marginTop: '10px' }}
                          >
                            <thead>
                              <tr>
                                <th>Category</th>
                                <th>Permission</th>
                                <th>Action</th>
                              </tr>
                            </thead>
                            <tbody>
                              {Object.keys(categorizedPermissions).map((category) => (
                                <React.Fragment key={category}>
                                  <tr>
                                    <td colSpan="3">
                                      <div
                                        style={{ cursor: 'pointer', marginBottom: '10px' }}
                                        onClick={() => toggleCategoryDropdown(category)}
                                      >
                                        <b>{category}</b>
                                        <i
                                          className={`fa ${dropdownOpen[category] ? 'fa-chevron-up' : 'fa-chevron-down'} icon-animate`}
                                          style={{ marginLeft: '10px' }}
                                        />
                                      </div>
                                    </td>
                                  </tr>
                                  {dropdownOpen[category] && categorizedPermissions[category].map((permission) => (
                                    <tr key={permission.id}>
                                      <td></td>
                                      <td>{permission.name}</td>
                                      <td>
                                        <input
                                          type="checkbox"
                                          checked={isPermissionChecked(role.id, permission.id)}
                                          onChange={(e) =>
                                            handleCheckboxChange(
                                              role.id,
                                              permission.id,
                                              e.target.checked
                                            )
                                          }
                                        />
                                      </td>
                                    </tr>
                                  ))}
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
        <div className="btn-apply-container">
          <button
            className={`btn-apply ${hasUnsavedChanges ? '' : 'disabled'}`}
            disabled={!hasUnsavedChanges}
            onClick={savePermissions}
          >
            Save Permissions
          </button>
        </div>
      </div>
    </div>
  );
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

export default ManageRole;
