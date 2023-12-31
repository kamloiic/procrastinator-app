import React, { useEffect, useState } from 'react';
import axios from 'axios';
import LinkForm from './LinkForm';
import LinkList from './LinkList';
import './styles.css';

function App() {
  const [links, setLinks] = useState([]);

  const fetchLinks = async () => {
    try {
      const response = await axios.get(`${process.env.REACT_APP_BACKEND_URL}`);
      setLinks(response.data);
    } catch (error) {
      console.error(error);
    }
  };

  const handleLinkAdded = (link) => {
    setLinks([...links, link]);
  };

  const handleLinkDeleted = (id) => {
    setLinks(links.filter((link) => link.ID !== id));
  };

  useEffect(() => {
    fetchLinks();
  }, []);

  return (
    <div className="App">
      <h1>Too Long</h1>
      <h3>List of TL;DR and TL;DW</h3>
      <LinkForm onLinkAdded={handleLinkAdded} />
      <LinkList links={links} onDelete={handleLinkDeleted} />
    </div>
  );
}

export default App;
