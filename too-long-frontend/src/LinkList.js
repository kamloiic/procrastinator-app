// src/LinkList.js

import React from 'react';
import axios from 'axios';

const LinkList = ({ links, onDelete }) => {
  const handleLinkDeleted = async (id) => {
    try {
      await axios.delete(`http://localhost:8080/links/${id}`);
      onDelete(id);
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <div>
      <h2>Links</h2>
      {links.length === 0 ? (
        <p>No links to display.</p>
      ) : (
        <ul>
          {links.map((link) => (
            <li key={link.ID}>
              <a href={link.URL} target="_blank" rel="noopener noreferrer">
                {link.Description}
              </a>
              <button onClick={() => handleLinkDeleted(link.ID)}>Delete</button>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
};

export default LinkList;
