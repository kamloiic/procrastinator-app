import React, { useState } from 'react';
import axios from 'axios';
import './styles.css';

const LinkForm = ({ onLinkAdded }) => {
  const [url, setUrl] = useState('');
  const [description, setDescription] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();

    try {
      const response = await axios.post(
        `${process.env.REACT_APP_BACKEND_URL}`,
        { url, description }
      );
      onLinkAdded(response.data);
      setUrl('');
      setDescription('');
    } catch (error) {
      console.error(error);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <label>
        URL:
        <input type="text" value={url} onChange={(e) => setUrl(e.target.value)} />
      </label>
      <label>
        Description:
        <input
          type="text"
          value={description}
          onChange={(e) => setDescription(e.target.value)}
        />
      </label>
      <button type="submit">Add Link</button>
    </form>
  );
};

export default LinkForm;
