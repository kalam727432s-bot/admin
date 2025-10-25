"use client";

import { useEffect, useState } from "react";
import { timeAgo } from "@/Helper";
import useUser from "@/components/useUser";
import toast from "react-hot-toast";
import { Loader2, Trash2, Send, Timer } from "lucide-react";

export default function Page() {
  const [formData, setFormData] = useState([]);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [loading, setLoading] = useState(false);
  const [expandedIds, setExpandedIds] = useState([]); // Track expanded cards
  const authuser = useUser();

  // Fetch form data
  const fetchFormData = async (page) => {
    setLoading(true);
    try {
      const res = await fetch(`/api/form-data?page=${page}&limit=9`);
      const json = await res.json();
      setFormData(Array.isArray(json.data) ? json.data : []);
      setTotalPages(json.pagination.totalPages);
      const allIds = json.data.map(item => `${item.form_id}-${item.android}`);
      setExpandedIds(allIds);

    } catch (err) {
      console.error("Error fetching form data:", err);
    }
    setLoading(false);
  };

  useEffect(() => {
    fetchFormData(page);
  }, [page]);

  const handleDelete = async (id) => {
    const confirmDelete = window.confirm("Are you sure you want to delete this entry?");
    if (!confirmDelete) return;

    let password = null;
    if (authuser.role !== "admin") {
      password = prompt("Enter admin password to delete this entry:");
      if (!password) return;
    }

    try {
      const res = await fetch(`/api/form-data/${id}`, {
        method: "DELETE",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ password }),
      });
      const json = await res.json();
      if (res.ok) {
        setFormData((prev) => prev.filter((item) => item.form_id !== id));
        toast.success("Entry deleted successfully");
      } else {
        toast.error(json.error || "Failed to delete");
      }
    } catch (err) {
      console.error("Error deleting entry:", err);
      toast.error("Failed to delete entry");
    }
  };

  const toggleExpand = (id) => {
    setExpandedIds((prev) =>
      prev.includes(id) ? prev.filter((e) => e !== id) : [...prev, id]
    );
  };

  // 🟢 NEW — Expand or collapse all
  const handleToggleAll = () => {
    if (expandedIds.length === formData.length) {
      setExpandedIds([]);
    } else {
      const allIds = formData.map((item) => `${item.form_id}-${item.android}`);
      setExpandedIds(allIds);
    }
  };

  return (
    <main className="flex-1 p-6 bg-gray-100 min-h-screen">
      <header className="flex flex-wrap justify-between items-center gap-3 mb-6">
        <h2 className="text-3xl font-bold text-gray-800">Form Data</h2>
        <div className="flex gap-3">
          {/* 🟢 New Toggle All Button */}
          <button
            onClick={handleToggleAll}
            disabled={formData.length === 0}
            className="flex items-center gap-2 px-4 py-2 bg-gray-700 text-white rounded-xl shadow hover:bg-gray-800 transition-all disabled:opacity-50"
          >
            {expandedIds.length === formData.length ? "Collapse All ▲" : "Expand All ▼"}
          </button>

          <button
            onClick={() => fetchFormData(page)}
            className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-xl shadow hover:bg-blue-700 transition-all"
          >
            <Send className="w-4 h-4" />
            Refresh
          </button>
        </div>
      </header>

      {loading ? (
        <div className="flex justify-center items-center h-64">
          <Loader2 className="animate-spin text-blue-600 w-8 h-8" />
        </div>
      ) : formData.length === 0 ? (
        <p className="text-gray-600 text-center">No form data available.</p>
      ) : (
        <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-2">
          {formData.map((item) => {
            const uniqueId = `${item.form_id}-${item.android}`;
            const isExpanded = expandedIds.includes(uniqueId);

            return (
              <div
                key={uniqueId}
                className="rounded-2xl shadow-md hover:shadow-xl transition-shadow duration-300 overflow-hidden bg-white"
              >
                <div className="p-6">
                  <div className="flex justify-between items-start">
                    <div>
                      <h2 className="font-bold text-xl text-gray-800 mb-1">
                        Form ID: {item.form_id}
                      </h2>
                      <p className="text-gray-600 mb-1">
                        <span className="font-medium">Device Name:</span>{" "}
                        {item.device_name}
                      </p>
                      <p className="text-gray-600">
                        <span className="font-medium">Device Model:</span>{" "}
                        {item.device_model}
                      </p>
                    </div>
                    <div className="text-end">
                      <button
                        onClick={() => handleDelete(item.form_id)}
                        className="px-3 py-1 flex gap-2 bg-red-600 text-white rounded-xl hover:bg-red-700 transition text-sm"
                      >
                        <Trash2 className="w-4 h-4" />
                        Delete
                      </button>
                      {item.created_at && (
                        <p className="mt-3 flex gap-1 justify-end text-gray-500 text-sm">
                          <Timer className="w-4 h-4" />
                          {timeAgo(item.created_at)}
                        </p>
                      )}
                      <p className=" flex gap-1 justify-end text-gray-500 text-sm">
                          {item.form_code}
                        </p>
                    </div>
                  </div>

                  {/* Collapsible Details */}
                  {item.form_data_details?.length > 0 && (
                    <div className="mt-4">
                      <button
                        onClick={() => toggleExpand(uniqueId)}
                        className="flex justify-between w-full px-4 py-2 bg-gray-200 text-gray-700 font-medium rounded-xl hover:bg-gray-300 transition"
                      >
                        <span>View Details ({item.form_data_details.length})</span>
                        <span>{isExpanded ? "▲" : "▼"}</span>
                      </button>

                      {isExpanded && (
                      <ul className="mt-2 space-y-1">
                        {item.form_data_details
                          .filter(detail => detail.input_key !== 'form_data_id')
                          .map((detail, index) => (
                            <li
                              key={detail.form_data_details_id}
                              className={`px-2 py-1 mt-2 rounded-md ${
                                index % 2 === 0 ? "bg-green-100" : "bg-blue-100"
                              }`}
                            >
                              {/* {detail.form_data_details_created_at && (
                                <p className="flex gap-1 justify-end text-gray-500 text-sm">
                                  <Timer className="w-4 h-4" />
                                  {timeAgo(detail.form_data_details_created_at)}
                                </p>
                              )}  */}
                              <div className="flex justify-between">
                                <span className="font-semibold capitalize flex ">
                                  <span className="text-gray-500 mr-1">
                                    {item.form_data_details.length - index}.
                                  </span>
                                  <span>
                                    {detail.input_key}
                                  </span>
                                </span>
                                <span>{detail.input_value}</span>
                              </div>
                                   
                            </li>
                          ))}
                      </ul>

                      )}
                    </div>
                  )}
                </div>
              </div>
            );
          })}
        </div>
      )}

      {/* Pagination */}
      <div className="flex justify-center mt-8 space-x-3">
        <button
          className="px-4 py-2 bg-gray-300 text-gray-700 rounded hover:bg-gray-400 disabled:opacity-50"
          onClick={() => setPage((p) => Math.max(p - 1, 1))}
          disabled={page === 1}
        >
          Prev
        </button>
        <span className="px-4 py-2 bg-white rounded shadow">{page}</span>
        <button
          className="px-4 py-2 bg-gray-300 text-gray-700 rounded hover:bg-gray-400 disabled:opacity-50"
          onClick={() => setPage((p) => Math.min(p + 1, totalPages))}
          disabled={page === totalPages}
        >
          Next
        </button>
      </div>
    </main>
  );
}
