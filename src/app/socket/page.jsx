"use client";
import { useEffect, useState, useRef } from 'react';
import { io } from 'socket.io-client';

export default function Chat() {
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState('');
  const socketRef = useRef(null); // store the socket

  useEffect(() => {
    socketRef.current = io('https://admin.slientkiller.com');

    socketRef.current.on('connect', () => {
      console.log('Connected with id:', socketRef.current.id);
    });

    socketRef.current.on('message', (msg) => {
      setMessages((prev) => [...prev, msg]);
    });

    socketRef.current.on('connect_error', (err) => {
      console.error('Connection error:', err);
    });

    return () => {
      socketRef.current.disconnect();
    };
  }, []);

  const sendMessage = () => {
    if (input && socketRef.current) {
      socketRef.current.emit('message', input);
      setInput('');
    }
  };

  return (
    <div>
      <h1>Chat</h1>
      <div>
        {messages.map((msg, i) => (
          <p key={i}>{msg}</p>
        ))}
      </div>
      <input
        value={input}
        onChange={(e) => setInput(e.target.value)}
        placeholder="Type message"
      />
      <button onClick={sendMessage}>Send Button</button>
    </div>
  );
}
