import React, { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router-dom';

function SearchContent({ setSearchTerm }) {
    const { term } = useParams();
    const [results, setResults] = useState([]);
    const [loading, setLoading] = useState(false);
    
    const timeAgo = (dateString) => {
        // Fungsi untuk memformat tanggal
    };

    useEffect(() => {
        const fetchData = async () => {
            setLoading(true);
            try {
                const response = await fetch(`http://localhost:3000/api/content?q=${term}`);
                if (!response.ok) {
                    setResults([]);
                } else {
                    const data = await response.json();
                    setResults(data.data);
                }
            } catch (error) {
                setResults([]);
            }
            setLoading(false);
        };
    
        if (term) fetchData();
    }, [term]);
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
              {index < paths.length - 1 && " > "} {/* Menambahkan separator */}
            </li>
          ))}
        </ul>
      </nav>
    );
  };
    return (
        <div className="search-content-page">
            <div className="search-content">
                {/* Breadcrumbs rendering */}
                <Breadcrumbs 
          paths={[
            { label: "Home", link: "/" },
            { label: "Pencarian" }, // Halaman saat ini tidak memiliki link
          ]} 
        />
                {loading ? (
                    <p>Loading...</p>
                ) : (
                    <div>
                        {results.length > 0 ? (
                            <div className="wiki-pemda-container">
                                {results.map((content) => (
                                    <Link
                                        to={`/informasi/${content.id}`}
                                        key={content.id}
                                        className="wiki-pemda-item-link"
                                        onClick={() => {
                                            setSearchTerm(''); // Kosongkan search term saat item ini diklik
                                        }}
                                    >
                                        <div className="wiki-pemda-item">
                                            <div className="title-container">
                                                <h4 className="search">{content.title}</h4>
                                            </div>
                                            <br />
                                            <hr className="divider" />
                                            <br />
                                            <p className="description">
                                                {content.description.String.slice(0, 86)}
                                            </p>
                                            <p className="last-updated">
                                                Last updated {content.updated_at && timeAgo(content.updated_at)}
                                            </p>
                                        </div>
                                    </Link>
                                ))}
                            </div>
                        ) : (
                            <p>No results found.</p>
                        )}
                    </div>
                )}
            </div>
        </div>
    );
}

export default SearchContent;