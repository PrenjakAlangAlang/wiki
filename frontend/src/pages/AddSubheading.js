import React, { useState, useEffect } from 'react';
import { useNavigate, useParams, Link } from 'react-router-dom';
import ReactQuill from 'react-quill'; // Tambahkan ReactQuill
import 'react-quill/dist/quill.snow.css'; // Tambahkan style untuk ReactQuill

const AddSubheading = () => {
    const [subheading, setSubheading] = useState('');
    const [description, setDescription] = useState('');
    const navigate = useNavigate();
    const { id } = useParams();
    const [user, setUser] = useState(null);
    const [token, setToken] = useState(null);

    useEffect(() => {
        const storedUser = JSON.parse(localStorage.getItem('user'));
        const storedToken = localStorage.getItem('token');
        if (storedUser && storedUser.id) {
            setUser(storedUser);
        } else {
            console.warn('User ID not found in localStorage.');
        }

        if (storedToken) {
            setToken(storedToken);
        } else {
            console.warn('Token not found in localStorage.');
        }
    }, []);

    const handleAddSubheading = async (e) => {
        e.preventDefault();

        const subheadingData = {
            content_id: parseInt(id, 10),
            subheading,
            subheading_description: description, // Menggunakan konten rich text
            author_id: user?.id,
            created_at: new Date().toISOString(),
            updated_at: new Date().toISOString(),
            editor_id: user?.id, 
        };

        try {
            const response = await fetch(`http://localhost:3000/api/subheading/add/${id}`, {
                method: 'POST',
                headers: { 
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`,
                },
                body: JSON.stringify(subheadingData),
            });

            if (!response.ok) throw new Error('Failed to add subheading');
            const responseData = await response.json();
            console.log(responseData);

            const historyData = {
                content_id: parseInt(id, 10),
                editor_id: user.id, 
                edited_at: new Date().toISOString(),
            };

            const historyResponse = await fetch("http://localhost:3000/api/history/add", {
                method: "POST",
                headers: { 
                    "Content-Type": "application/json",
                    "Authorization": `Bearer ${token}`,
                },
                body: JSON.stringify(historyData),
            });

            if (!historyResponse.ok) {
                console.error("Failed to record add subheading history");
            }

            // Reset form fields after submission
            setSubheading('');
            setDescription('');
            
            navigate(`/informasi/${id}`);
        } catch (error) {
            console.error(error);
            alert('Error adding subheading');
        }
    };

    // Breadcrumbs component
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
        <div className="container-wrapper">
            <div className="container">
                <Breadcrumbs 
                    paths={[
                        { label: "Home", link: "/" },
                        { label: "Informasi", link: `/informasi/${id}` },
                        { label: "Edit Content", link: `/edit/${id}` },
                        { label: "Tambah Sub Judul" }
                    ]} 
                />
                <div className="text text-gradient">Tambah Sub Judul</div>
                <form onSubmit={handleAddSubheading}>
                    <div className="form-row">
                        <div className="input-data">
                            <input
                                type="text"
                                value={subheading}
                                onChange={(e) => setSubheading(e.target.value)}
                                required
                            />
                            <div className="underline"></div>
                            <label>Sub Judul</label>
                        </div>
                    </div>

                    <div className="form-row">
                        <div className="input-data textarea">
                            <ReactQuill
                                theme="snow" // Tema untuk react-quill
                                value={description}
                                onChange={setDescription} // Mengupdate deskripsi menggunakan state
                            />
                            <div className="underline"></div>
                            <label>Deskripsi</label>
                        </div>
                    </div>

                    <div className="form-row submit-btn">
                        <div className="input-data">
                            <div className="inner"></div>
                            <input type="submit" value="Add Subheading" />
                        </div>
                    </div>
                </form>
            </div>
        </div>
    );
};

export default AddSubheading;