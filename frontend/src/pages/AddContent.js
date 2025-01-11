import React, { useState, useEffect } from "react";
import { useNavigate, Link } from "react-router-dom";
import ReactQuill from "react-quill"; // Import ReactQuill
import "react-quill/dist/quill.snow.css"; // Import stylesheet

const AddContent = () => {
    const [title, setTitle] = useState("");
    const [description, setDescription] = useState(""); // State untuk deskripsi
    const [tag, setTag] = useState("");
    const [instanceId, setInstanceId] = useState("");
    const [instances, setInstances] = useState([]); // To store instance data
    const [user, setUser] = useState(null);
    const navigate = useNavigate();

    useEffect(() => {
        const storedUser = JSON.parse(localStorage.getItem("user"));
        if (storedUser && storedUser.id) {
            setUser(storedUser);
            console.log("User Instance ID:", storedUser.user_instance_id);
            if (storedUser.role_id === 3 && storedUser.user_instance_id) {
                const selectedInstance = instances.find(
                    (instance) => instance.id === parseInt(storedUser.user_instance_id, 10)
                );
                if (selectedInstance) {
                    setInstanceId(selectedInstance.id); // Set instanceId for role 3 user
                }
            }
        } else {
            console.warn("User ID not found in localStorage.");
        }
    }, [instances]); 

    useEffect(() => {
        const fetchInstances = async () => {
            try {
                const response = await fetch("/api/instances");
                if (response.ok) {
                    const data = await response.json();
                    setInstances(data); 
                    console.log("Fetched Instances:", data);
                } else {
                    console.error("Failed to fetch instances.");
                }
            } catch (error) {
                console.error("Error fetching instances:", error);
            }
        };

        fetchInstances();
    }, []); 

    const handleSubmit = async (e) => {
        e.preventDefault();

        if (!user) {
            alert("Please log in to create content.");
            navigate("/login");
            return;
        }

        const contentData = {
            title,
            description: {
                String: description || "",
                Valid: description !== "",
            },
            tag,
            author_id: user?.id,
            instance_id: parseInt(instanceId, 10), 
            created_at: new Date().toISOString(),
            updated_at: new Date().toISOString(),
        };

        console.log("Content Data to Send:", JSON.stringify(contentData, null, 2));

        try {
            const response = await fetch(`/api/content/add`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(contentData),
            });

            if (response.ok) {
                const result = await response.json();
                const contentId = result.content_id;
                navigate(`/informasi/${contentId}`);
            } else {
                const errorText = await response.text();
                alert("Can't access the backend: " + errorText);
                console.error("Error creating content:", errorText);
            }
        } catch (error) {
            console.error("Error creating content:", error);
            alert("There was an error creating the content.");
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

    return (
        <div className="container-wrapper profile-wrapper">
            <div className="container">
                <Breadcrumbs 
                    paths={[
                        { label: "Home", link: "/" },
                        { label: "Add Content" }  // Halaman saat ini tidak memiliki link
                    ]} 
                />

                <div className="text text-gradient">Tambah Konten</div>
                <form onSubmit={handleSubmit}>
                    <div className="form-row">
                        <div className="input-data">
                            <input
                                type="text"
                                value={title}
                                onChange={(e) => setTitle(e.target.value)}
                                required
                            />
                            <div className="underline"></div>
                            <label>Judul</label>
                        </div>
                    </div>

                    <div className="form-row">
                        <div className="input-data textarea">
                            <label>Deskripsi (Opsional)</label>
                            <ReactQuill
                                value={description}
                                onChange={setDescription} // Update state on change
                                theme="snow" // Theme untuk ReactQuill
                                style={{ height: '150px' }} // Mengatur tinggi editor
                            />
                        </div>
                    </div>

                    <div className="form-row">
                        <div className="input-data">
                            <input
                                type="text"
                                value={tag}
                                onChange={(e) => setTag(e.target.value)}
                                required
                            />
                            <div className="underline"></div>
                            <label>Tag (Berikan tanda koma sebagai pemisah antar tag, apabila tag lebih dari satu)</label>
                        </div>
                    </div>

                    <div className="form-row">
                        <div className="input-data">
                            <select
                                value={instanceId}
                                onChange={(e) => setInstanceId(e.target.value)}
                                required
                                disabled={user?.role_id === 3}
                            >
                                <option value="">Pilih Instansi</option>
                                {instances.map((instance) => (
                                    <option key={instance.id} value={instance.id}>
                                        {instance.name}
                                    </option>
                                ))}
                            </select>
                            <div className="underline"></div>
                            <label>Instansi</label>
                        </div>
                    </div>

                    <div className="form-row submit-btn">
                        <div className="input-data">
                            <div className="inner"></div>
                            <input type="submit" value="Submit" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
    );
};

export default AddContent;