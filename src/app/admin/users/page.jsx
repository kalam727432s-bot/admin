"use client";
import { useEffect, useState } from "react";
import UserHeader from "@/components/users/UserHeader";
import UserTable from "@/components/users/UserTable";
import UserModal from "@/components/users/UserModal";
import toast from "react-hot-toast";
import useUser from "@/components/useUser";
import { getSocket } from "@/Helper";

export default function AdminUsersPage() {
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [modalOpen, setModalOpen] = useState(false);
  const [editingUser, setEditingUser] = useState(null);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [total, setTotal] = useState(0);
  const [search, setSearch] = useState("");
  const authuser = useUser();

  // Socket
  useEffect(() => {
    if (!authuser) return;
    const socket = getSocket(authuser);
    socket.on("connect", () => {});
  }, [authuser]);

  const fetchUsers = async (page = 1, searchText = "") => {
    setLoading(true);
    try {
      const res = await fetch(`/api/users?page=${page}&limit=12&search=${encodeURIComponent(searchText)}`);
      const data = await res.json();
      if (res.ok) {
        setUsers(data.data);
        setTotalPages(data.pagination.totalPages);
        setTotal(data.pagination.total);
      } else {
        toast.error(data.error || "Failed to fetch users");
      }
    } catch (err) {
      console.error(err);
      toast.error("An error occurred while fetching users");
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    fetchUsers(page, search);
  }, [page, search]);

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
        <UserHeader  der onAdd={handleCreate} />
        
        {/* 🔍 Search Bar */}
        <div className="flex justify-between mb-4">
          <input
            type="text"
            placeholder="Search by username, form code, or role..."
            className="border p-2 rounded-lg w-full max-w-md focus:ring-2 focus:ring-blue-500"
            value={search}
            onChange={(e) => {
              setPage(1);
              setSearch(e.target.value);
            }}
          />
        </div>

        <UserTable users={users} loading={loading} onEdit={handleEdit} onRefresh={() => fetchUsers(page, search)} />
        
        {/* 🔢 Pagination */}
        <div className="flex justify-center mt-6 space-x-3">
          <button
            disabled={page === 1}
            onClick={() => setPage((p) => Math.max(p - 1, 1))}
            className="px-4 py-2 bg-gray-200 rounded hover:bg-gray-300 disabled:opacity-50"
          >
            Prev
          </button>
          <span className="px-4 py-2 bg-white border rounded">Page {page} of {total}</span>
          <button
            disabled={page === totalPages}
            onClick={() => setPage((p) => Math.min(p + 1, totalPages))}
            className="px-4 py-2 bg-gray-200 rounded hover:bg-gray-300 disabled:opacity-50"
          >
            Next
          </button>
        </div>
      </div>

      {modalOpen && (
        <UserModal onClose={() => setModalOpen(false)} user={editingUser} refresh={() => fetchUsers(page, search)} />
      )}
    </main>
  );
}
