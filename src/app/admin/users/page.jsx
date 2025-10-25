"use client";

import { useEffect, useState } from "react";
import UserHeader from "@/components/users/UserHeader";
import UserTable from "@/components/users/UserTable";
import UserModal from "@/components/users/UserModal";
import toast from "react-hot-toast";

export default function AdminUsersPage() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [modalOpen, setModalOpen] = useState(false);
  const [editingUser, setEditingUser] = useState(null);


  const fetchUsers = async () => {
    setLoading(true);
    try {
      const res = await fetch("/api/users");
      const data = await res.json();
      if (res.ok) setUsers(data.users); 
      else toast.error(data.error || "Failed to fetch users");
    } catch (err) {
      console.error(err);
      toast.error("An error occurred while fetching users");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUsers();
  }, []);

  const handleEdit = (user) => {
    setEditingUser(user);
    setModalOpen(true);
  };

  const handleCreate = () => {
    setEditingUser(null);
    setModalOpen(true);
  };

  return (
    <main className="p-6 bg-gray-50 min-h-screen">
      <div className="max-w-6xl mx-auto space-y-6">
        <UserHeader onAdd={handleCreate} />
        <UserTable users={users} loading={loading} onEdit={handleEdit} onRefresh={fetchUsers} />
      </div>

      <div className="mt-4">
        {/* Popup modal for create/edit */}
      {modalOpen && (
        <UserModal
          onClose={() => setModalOpen(false)}
          user={editingUser}
          refresh={fetchUsers}
        />
      )}
      </div>
    </main>
  );
}
