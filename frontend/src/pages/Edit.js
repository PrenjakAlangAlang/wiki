import React, { useState, useEffect } from "react";
import { useNavigate, useParams, Link } from "react-router-dom";
import ReactQuill from "react-quill";
import "react-quill/dist/quill.snow.css";
import DeleteSubheadingCard from '../component/DeleteSubheadingCard';

const Edit = () => {
  const { id } = useParams();
  const [user, setUser] = useState(null);
  const [originalContent, setOriginalContent] = useState(null);
  const [updatedContentTitle, setUpdatedContentTitle] = useState("");
  const [updatedContentDescription, setUpdatedContentDescription] = useState("");
  const [updatedInstanceID, setUpdatedInstanceID] = useState("");
  const [updatedContentTag, setUpdatedContentTag] = useState("");
  const [subheadings, setSubheadings] = useState([]);
  const [updatedSubheadings, setUpdatedSubheadings] = useState({});
  const [hasChanges, setHasChanges] = useState(false);
  const navigate = useNavigate();
  const [instances, setInstances] = useState([]);
  const [isDeleteModalOpen, setIsDeleteModalOpen] = useState(false);
  const [subheadingToDelete, setSubheadingToDelete] = useState(null);
  const [lastHistoryUpdate, setLastHistoryUpdate] = useState(null);

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
            encrypted_token: token,
          }),
        });

        if (!response.ok) throw new Error("Failed to fetch user data");

        const userData = await response.json();
        setUser(userData);
      } catch (error) {
        console.error("Error fetching user data:", error);
        setUser(storedUser);
      }
    };

    fetchUserData();
    fetchContent(id);
    fetchInstances();
  }, [id]);

  // Add change detection effect
  useEffect(() => {
    if (!originalContent) return;

    const hasContentChanges = 
      originalContent.title !== updatedContentTitle ||
      originalContent.description !== updatedContentDescription ||
      originalContent.instance_id !== updatedInstanceID ||
      originalContent.tag !== updatedContentTag;

    const hasSubheadingChanges = subheadings.some(sub => {
      const updatedSub = updatedSubheadings[sub.id];
      return updatedSub && (
        updatedSub.subheading !== sub.subheading ||
        updatedSub.subheading_description !== sub.subheading_description
      );
    });

    setHasChanges(hasContentChanges || hasSubheadingChanges);

    // Record history if changes detected and enough time has passed
    const shouldRecordHistory = hasChanges && 
      (!lastHistoryUpdate || Date.now() - lastHistoryUpdate > 30000); // 30 seconds cooldown

    if (shouldRecordHistory) {
      recordEditHistory();
    }
  }, [updatedContentTitle, updatedContentDescription, updatedInstanceID, 
      updatedContentTag, updatedSubheadings]);

  const recordEditHistory = async () => {
    try {
      const token = localStorage.getItem("token");
      const currentDate = new Date();
      const formattedDate = currentDate.toLocaleString("en-US", {
        timeZone: "Asia/Jakarta",
        hour12: false,
      });

      const [date, time] = formattedDate.split(", ");
      const [month, day, year] = date.split("/");
      const formattedMySQLDate = `${year}-${month.padStart(2, "0")}-${day.padStart(2, "0")} ${time}`;

      const historyData = {
        content_id: parseInt(id, 10),
        editor_id: user.id,
        action: "Editing",
        edited_at: formattedMySQLDate,
      };

      const historyResponse = await fetch("http://localhost:3000/api/history/add", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(historyData),
      });

      if (historyResponse.ok) {
        setLastHistoryUpdate(Date.now());
      } else {
        console.error("Failed to record edit history");
      }
    } catch (error) {
      console.error("Error recording edit history:", error);
    }
  };

  const fetchInstances = async () => {
    try {
      const token = localStorage.getItem("token");
      const response = await fetch("/api/instances", {
        headers: { Authorization: `Bearer ${token}` },
      });
      if (!response.ok) throw new Error("Failed to fetch instances");
      const data = await response.json();
      setInstances(data);
    } catch (error) {
      console.error(error);
      alert("An error occurred while fetching instances.");
    }
  };

  const fetchContent = async (id) => {
    try {
      const token = localStorage.getItem("token");
      const response = await fetch(`http://localhost:3000/api/content/${id}`, {
        headers: { Authorization: `Bearer ${token}` },
      });
      if (!response.ok) throw new Error("Failed to fetch content");
      const data = await response.json();

      // Store original content for change detection
      setOriginalContent({
        title: data.content?.title || "",
        description: data.content.description?.String || "",
        instance_id: data.content.instance_id || "",
        tag: data.content.tag || "",
      });

      setUpdatedContentTitle(data.content?.title || "");
      setUpdatedContentDescription(data.content.description?.String || "");
      setUpdatedInstanceID(data.content.instance_id || "");
      setUpdatedContentTag(data.content.tag || "");

      const initialSubheadings = {};
      if (data.subheadings && Array.isArray(data.subheadings)) {
        data.subheadings.forEach((sub) => {
          initialSubheadings[sub.id] = {
            subheading: sub.subheading,
            subheading_description: sub.subheading_description,
          };
        });
      }

      setUpdatedSubheadings(initialSubheadings);
      setSubheadings(data.subheadings || []);
    } catch (error) {
      console.error(error);
      alert("An error occurred while fetching content");
    }
  };

  const handleSubheadingChange = (subheadingId, field, value) => {
    setUpdatedSubheadings((prev) => ({
      ...prev,
      [subheadingId]: {
        ...prev[subheadingId],
        [field]: value,
      },
    }));
  };

  const deleteSubheading = async (subheadingId) => {
    if (!user?.permissions?.includes("delete_subheading")) {
      alert("Anda tidak memiliki izin untuk menghapus subheading.");
      return;
    }

    try {
      const token = localStorage.getItem("token");
      const response = await fetch(
        `http://localhost:3000/api/subheading/delete/${subheadingId}`,
        {
          method: "DELETE",
          headers: { Authorization: `Bearer ${token}` },
        }
      );

      if (response.ok) {
        //alert("Subheading berhasil dihapus");
        setSubheadings((prev) => prev.filter((sub) => sub.id !== subheadingId));
      } else {
        alert("Gagal menghapus subheading");
      }
    } catch (error) {
      console.error("Error deleting subheading:", error);
      alert("Terjadi kesalahan saat menghapus subheading");
    }
  };

  const handleDeleteSubheading = (subheadingId) => {
    setSubheadingToDelete(subheadingId);
    setIsDeleteModalOpen(true);
  };

  const handleAddSubheadingClick = async () => {
    if (!user?.permissions?.includes("create_subheading")) {
      alert("Anda tidak memiliki izin untuk menambah subjudul.");
      return;
    }
    navigate(`/addsubheading/${id}`);
  };

  const handleSave = async () => {
    if (!user?.permissions?.includes("edit_content")) {
      alert("Anda tidak memiliki izin untuk mengedit konten.");
      return;
    }
    
    const updatedSubheadingsArray = subheadings.map((subheading) => ({
      id: subheading.id,
      subheading:
        updatedSubheadings[subheading.id]?.subheading || subheading.subheading,
      subheading_description:
        updatedSubheadings[subheading.id]?.subheading_description ||
        subheading.subheading_description,
    }));
    
    const requestBody = {
      title: updatedContentTitle,
      description: updatedContentDescription,
      instance_id: parseInt(updatedInstanceID, 10),
      tag: updatedContentTag,
      subheadings: updatedSubheadingsArray,
      editor_id: user.id,
    };
    
    try {
      const token = localStorage.getItem("token");
      if (!token) {
        alert("Authorization token is missing. Please log in again.");
        navigate("/login");
        return;
      }

      const response = await fetch(`http://localhost:3000/api/content/edit/${id}`, {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify(requestBody),
      });

      if (response.ok) {
        navigate(`/informasi/${id}`);
      } else {
        alert("Gagal mengupdate konten.");
      }
    } catch (error) {
      console.error("An error occurred while saving updates:", error);
      alert("Terjadi kesalahan saat menyimpan pembaruan.");
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
              {index < paths.length - 1 && " / "}
            </li>
          ))}
        </ul>
      </nav>
    );
  };

  return (
    <div className="container-wrapper">
      <div className="container">
        <Breadcrumbs 
          paths={[
            { label: "Home", link: "/" },
            { label: "Informasi", link: `/informasi/${id}` },
            { label: "Edit Content" }
          ]} 
        />
        
        <div className="text">Edit Content</div>
        <form>
          <div className="form-row">
            <div className="input-data">
              <label>Judul</label>
              <input
                type="text"
                value={updatedContentTitle}
                onChange={(e) => setUpdatedContentTitle(e.target.value)}
                required
              />
            </div>
            <div className="input-data textarea">
              <label>Deskripsi</label>
              <ReactQuill
                value={updatedContentDescription}
                onChange={setUpdatedContentDescription}
                theme="snow"
                style={{ height: '150px' }}
              />
            </div>
            <div className="input-data">
              <label>Instansi</label>
              <select
                value={updatedInstanceID}
                onChange={(e) => setUpdatedInstanceID(e.target.value)}
                required
                disabled={user?.role_id === 3 || user?.role_id === 1 || user?.role_id === 2}
              >
                <option value="">Pilih Instansi</option>
                {instances.map((instance) => (
                  <option key={instance.id} value={instance.id}>
                    {instance.name}
                  </option>
                ))}
              </select>
            </div>
            <div className="input-data">
              <label>Tag (Berikan tanda koma sebagai pemisah antar tag)</label>
              <input
                type="text"
                value={updatedContentTag}
                onChange={(e) => setUpdatedContentTag(e.target.value)}
                required
              />
            </div>
          </div>

          <div className="form-row">
            {subheadings.map((subheading) => (
              <div className="form-row" key={subheading.id}>
                <div className="input-data">
                  <label>Sub Judul</label>
                  <input
                    type="text"
                    value={
                      updatedSubheadings[subheading.id]?.subheading ||
                      subheading.subheading
                    }
                    onChange={(e) =>
                      handleSubheadingChange(subheading.id, "subheading", e.target.value)
                    }
                    required
                  />
                </div>
                <div className="input-data textarea">
                  <label>Deskripsi</label>
                  <ReactQuill
                    value={
                      updatedSubheadings[subheading.id]?.subheading_description ||
                      subheading.subheading_description
                    }
                    onChange={(value) =>
                      handleSubheadingChange(subheading.id, "subheading_description", value)
                    }
                    theme="snow"
                    style={{ height: '100px' }}
                  />
                </div>
                <br></br>
                <br></br>
                {user?.permissions?.includes("delete_subheading") && (
                  <div className="submit-btn">
                    <input
                      type="button"
                      value={`Hapus Sub Judul ${subheading.subheading}`}
                      className="btn btn-red"
                      onClick={() => handleDeleteSubheading(subheading.id)}
                    />
                  </div>
                )}
              </div>
            ))}
          </div>
          <div className="submit-btn">
            {user?.permissions?.includes("create_subheading") && (
              <input
                type="button"
                value="Tambah Sub Judul"
                className="btn btn-blue"
                onClick={handleAddSubheadingClick}
              />
            )}
            {user?.permissions?.includes("edit_content") && (
              <input
                type="button"
                value="Simpan"
                className="btn btn-green"
                onClick={handleSave}
              />
            )}
          </div>
        </form>

        {/* Modal Konfirmasi Penghapusan Sub Judul */}
        <DeleteSubheadingCard
          isOpen={isDeleteModalOpen}
          onDelete={async () => {
            await deleteSubheading(subheadingToDelete);
            setIsDeleteModalOpen(false);
          }}
          onCancel={() => setIsDeleteModalOpen(false)}
          subheadingName={updatedSubheadings[subheadingToDelete]?.subheading || ''}
        />
      </div>
    </div>
  );
};

export default Edit;