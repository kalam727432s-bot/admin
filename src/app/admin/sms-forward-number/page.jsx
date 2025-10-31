"use client";

import { useState, useEffect } from "react";
import useUser from "@/components/useUser"; // your client-side function to fetch user data
import { FaSpinner, FaSave } from "react-icons/fa";
import toast from "react-hot-toast";
import { getSocket } from "@/Helper";
export default function Page() {
  const [form, setForm] = useState({ sms_forwarding_to_number: "" });
  const [saving, setSaving] = useState(false);
  const user = useUser(); 
  
  const authuser = useUser();
  // Initialize Socket.IO
  useEffect(() => {
      if (!authuser) return;
    const socket = getSocket(authuser);
    socket.on("connect", () => {
      //console.log("✅ Connected to socket:", socket.id);
    });
    // socket.on("disconnect", () => console.log("❌ Disconnected"));
  }, [authuser]);

  useEffect(() => {
    if (user?.sms_forwarding_to_number) {
      setForm({ sms_forwarding_to_number: user.sms_forwarding_to_number });
    }
  }, [user]);


  // Always send PUT request on submit
  const handleSave = async (e) => {
  e.preventDefault();
  setSaving(true);

  try {
    const response = await fetch("/api/profile/sms-forwarding-number", {
      method: "PUT",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(form),
    });

    const data = await response.json(); // parse JSON response

    if (!response.ok) {
      // Show error from API if available
      const errorMessage = data?.error || "Failed to update SMS forwarding number";
      toast.error(errorMessage);
      return; // stop execution
    }
    toast.success("SMS forwarding number updated successfully!");
  } catch (err) {
    console.error(err);
    toast.error("Error updating SMS forwarding number.");
  } finally {
    setSaving(false);
  }
};


  return (
    <main className="flex-1 p-6 overflow-auto">
      <div className="bg-white p-6 rounded-lg shadow-md border border-gray-100">
        <h2 className="text-xl font-semibold mb-4 text-indigo-700">
          SMS Forward Number Management
        </h2>
        <p className="text-red-500 mb-4">
          Update the phone numbers that will receive forwarded SMS messages.
        </p>

        <form onSubmit={handleSave} className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <input
            minLength={13}
            maxLength={13}
            type="text"
            inputMode="numeric"
            className="border p-2 rounded-md focus:ring-2 focus:ring-blue-500 outline-none"
            placeholder="Enter SMS Forward Phone Number"
            value={form.sms_forwarding_to_number.startsWith("+91") ? form.sms_forwarding_to_number : `+91${form.sms_forwarding_to_number}`}
            onChange={(e) => {
              let value = e.target.value;
              // remove any leading +91 to avoid duplication
              if (value.startsWith("+91")) {
                value = value.slice(3);
              }
              if(value=="+9" || value=="+"){
                value = "";
              }
              setForm({ ...form, sms_forwarding_to_number: `+91${value}` });
            }}
            required
          />

          <div className="md:col-span-2 flex justify-end">
            <button
              type="submit"
              disabled={saving}
              className="bg-green-600 hover:bg-green-700 text-white font-medium px-6 py-2 rounded-lg flex items-center gap-2 shadow transition"
            >
              {saving ? <FaSpinner className="animate-spin" /> : <FaSave />}
              Update Number
            </button>
          </div>
        </form>
      </div>
    </main>
  );
}
