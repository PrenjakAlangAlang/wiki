import React, { useState, useEffect } from "react";
import { useParams, Link } from "react-router-dom";
import { FaEye, FaEyeSlash } from "react-icons/fa";


const DetailUser = () => {
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

  const token = localStorage.getItem("token");

  useEffect(() => {
    const storedUser = JSON.parse(localStorage.getItem("user"));
    if (storedUser) setCurrentUser(storedUser);

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

    fetch("http://localhost:3000/api/roles", {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => setRoles(data))
      .catch((err) => console.error("Failed to fetch roles:", err));

    fetch("http://localhost:3000/api/instances", {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => setInstances(data))
      .catch((err) => console.error("Failed to fetch instances:", err));

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

  const saveContentHistory = (content) => {
    if (content.created_at === content.edited_at) {
      const historyData = {
        content_id: content.id,
        edited_at: content.edited_at,
        action: "create",
      };

      fetch(`http://localhost:3000/api/content_edit_history`, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(historyData),
      })
        .then((res) => {
          if (!res.ok) {
            throw new Error("Failed to save content history");
          }
          return res.json();
        })
        .then(() => {
          console.log("Content history saved successfully");
        })
        .catch((err) => console.error("Failed to save content history:", err));
    }
  };

  useEffect(() => {
    contents.forEach(saveContentHistory);
  }, [contents]);

  const loadHistories = () => {
    fetch(`http://localhost:3000/api/history/user/${id}`, {
      headers: {
        Authorization: `Bearer ${token}`,
      },
    })
      .then((res) => res.json())
      .then((data) => setHistories(data || []))
      .catch((err) => console.error("Failed to fetch histories:", err));
  };

  const handleToggleHistory = () => {
    if (!showHistory) {
      loadHistories();
    }
    setShowHistory(!showHistory);
  };

  const formatDateTime = (dateTime) => {
    if (!dateTime) return "Invalid Date";

    const isoDateTime = dateTime.replace(" ", "T");
    const parsedDate = new Date(isoDateTime);

    if (isNaN(parsedDate)) {
      console.error("Invalid date format:", dateTime);
      return "Invalid Date";
    }

    const optionsTime = {
      hour: "2-digit",
      minute: "2-digit",
    };
    const formattedTime = new Intl.DateTimeFormat("id-ID", optionsTime).format(parsedDate);

    const optionsDate = {
      day: "numeric",
      month: "long",
      year: "numeric",
    };
    const formattedDate = new Intl.DateTimeFormat("id-ID", optionsDate).format(parsedDate);

    return `${formattedTime} - ${formattedDate}`;
  };

  const getContentTitle = (contentId) => {
    const content = contents.find((content) => content.id === contentId);
    return content ? content.title : "Unknown Title";
  };

  useEffect(() => {
    if (histories.length > 0) {
      const updatedHistories = histories.map((history) => ({
        ...history,
        title: getContentTitle(history.content_id),
      }));
      setHistories(updatedHistories);
    }
  }, [contents, histories]);

  if (!user || !contents || !histories) {
    return <div>Loading...</div>;
  }

  const Breadcrumbs = ({ paths }) => {
    return (
      <nav style={{ position: "relative", zIndex: 10 }}>
        <ul className="breadcrumbs">
          {paths.map((path, index) => (
            <li key={index}>
              {path.link ? (
                <Link to={path.link} style={{ pointerEvents: "auto" }}>
                  {path.label}
                </Link>
              ) : (
                <span>{path.label}</span>
              )}
              {index < paths.length - 1 && <span> / </span>}
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
                    type={passwordVisible ? "text" : "password"}
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
                    {passwordVisible ? <FaEyeSlash /> : <FaEye />} {" "}
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
  <table className="history-table">
    <thead className="thead">
      <tr>
        <th>Title</th>
        <th>Date</th>
        <th>Action</th>
      </tr>
    </thead>
    <tbody>
      {/* Urutkan histories berdasarkan edited_at (tanggal terbaru di atas) */}
      {histories
        .sort((a, b) => new Date(b.edited_at) - new Date(a.edited_at)) // Urutkan dari terbaru ke lama
        .map((item) => (
          <tr key={item.id}>
            {/* Jadikan title sebagai link */}
            <td>
              <a
                href={`/content/${item.content_id}`} // Ganti dengan URL yang sesuai
                target="_blank" // Membuka link di tab baru
                rel="noopener noreferrer" // Mencegah risiko keamanan
              >
                {item.title}
              </a>
            </td>
            <td>{formatDateTime(item.edited_at)}</td>
            <td>{item.action}</td>
          </tr>
        ))}
    </tbody>
  </table>
)}


      </div>
    </div>
  );
};

export default DetailUser;
