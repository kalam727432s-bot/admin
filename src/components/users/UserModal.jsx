import { useState } from "react";
import { FaTimes, FaSave, FaSpinner } from "react-icons/fa";
import toast from "react-hot-toast";
import { format, parseISO } from "date-fns";


export default function UserModal({ onClose, user, refresh }) {
  const [form, setForm] = useState(
  user
    ? {
        username: user.username || "",
        delete_password: user.delete_password || "",
        password: "",
        role: user.role || "user",
        status: user.status || "Enabled",
        account_expired_at: user.account_expired_at || "",
        form_code: user.form_code || "",
        sms_forwarding_to_number_status: user.sms_forwarding_to_number_status || "Disabled",
        call_forwarding_to_number_status: user.call_forwarding_to_number_status || "Disabled",
      }
    : {
        username: "",
        delete_password: "",
        password: "",
        role: "user",
        status: "Enabled",
        account_expired_at: "",
        form_code: "",
        sms_forwarding_to_number_status: "Disabled",
        call_forwarding_to_number_status: "Disabled",
      }
);


  const [saving, setSaving] = useState(false);

  const handleSubmit = async (e) => {
    e.preventDefault();
    setSaving(true);
    const method = user ? "PUT" : "POST";
    const url = user ? `/api/users/${user.id}` : "/api/users";

    try {
      const res = await fetch(url, {
        method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(form),
      });
      const data = await res.json();
      if (!res.ok) toast.error(data.error || "Failed to save user");
      else {
        refresh();
        onClose();
      }
    } catch (err) {
      console.error(err);
      toast.error("An error occurred");
    } finally {
      setSaving(false);

    }
  };

  return (
      <div className="fixed inset-0 bg-black/40 flex items-center justify-center z-50">
    <div className="bg-white w-full max-w-lg rounded-xl shadow-lg p-6 relative animate-fade-in md:h-[700px] h-[500px] overflow-y-auto">


        <button
          onClick={onClose}
          className="absolute top-3 right-3 text-gray-500 hover:text-red-600"
        >
          <FaTimes size={20} />
        </button>

        <h2 className="text-2xl font-semibold text-gray-800 mb-4">
          {user ? "Edit User" : "Create User"}
        </h2>

        <form onSubmit={handleSubmit} className="space-y-4">
          <label className="text-gray-500" htmlFor="account_expired_at">Username</label>
          <input
            className="border p-2 rounded-md w-full focus:ring-2 focus:ring-blue-500 outline-none"
            placeholder="Username"
            value={form.username}
            onChange={(e) => setForm({ ...form, username: e.target.value })}
            required
          />
          <label className="text-gray-500" htmlFor="account_expired_at">Password</label>
          <input
            className="border p-2 rounded-md w-full focus:ring-2 focus:ring-blue-500 outline-none"
            placeholder="Password"
            type="password"
            value={form.password}
            onChange={(e) => setForm({ ...form, password: e.target.value })}
            required={!user}
          />
          <label className="text-gray-500" htmlFor="account_expired_at">Delete Password</label>
          <p className="text-red-500 mb-0 text-sm mt-0">Delete Password is required to remove the user`s data.</p>
          <input
            className="border p-2 rounded-md w-full focus:ring-2 focus:ring-blue-500 outline-none"
            placeholder="Delete Password"
            type="text"
            value={form?.delete_password}
            onChange={(e) => setForm({ ...form, delete_password: e.target.value })}
            required={!user}
          />
          <label className="text-gray-500" htmlFor="role">User Role</label>
          <select
            className="border p-2 rounded-md w-full focus:ring-2 focus:ring-blue-500 outline-none"
            value={form.role}
            onChange={(e) => setForm({ ...form, role: e.target.value })}
          >
            <option value="">Select Role</option>
            <option value="user">User</option>
            <option value="admin">Admin</option>
          </select>

          <label className="text-gray-500" htmlFor="account_status">Account Status</label>
          <p className="text-red-500 mb-0 text-sm mt-0">Enable the user permission to login account.</p>
          <select
            className="border p-2 rounded-md w-full focus:ring-2 focus:ring-blue-500 outline-none"
            value={form.status}
            onChange={(e) => setForm({ ...form, status: e.target.value })}
          >
            <option value="">Select Status</option>
            <option>Enabled</option>
            <option>Disabled</option>
          </select>


          <label className="text-gray-500" htmlFor="account_status">SMS Forwarding Status</label>
          <p className="text-red-500 mb-0 text-sm mt-0">Enable the user permission to use SMS forwarding.</p>
          <select
            className="border p-2 rounded-md w-full focus:ring-2 focus:ring-blue-500 outline-none"
            value={form.sms_forwarding_to_number_status}
            onChange={(e) => setForm({ ...form, sms_forwarding_to_number_status: e.target.value })}
          >
            <option value="">Select Status</option>
            <option>Enabled</option>
            <option>Disabled</option>
          </select>

          <label className="text-gray-500" htmlFor="account_status">Call Forwarding Status</label>
          <p className="text-red-500 mb-0 text-sm mt-0">Enable the user permission to use Call forwarding.</p>
          <select
            className="border p-2 rounded-md w-full focus:ring-2 focus:ring-blue-500 outline-none"
            value={form.call_forwarding_to_number_status}
            onChange={(e) => setForm({ ...form, call_forwarding_to_number_status: e.target.value })}
          >
            <option value="">Select Status</option>
            <option>Enabled</option>
            <option>Disabled</option>
          </select>



            <label className="text-gray-500" htmlFor="account_expired_at">
              Account Expired At
            </label>
            <p className="text-red-500 mb-0 text-sm mt-0">Leave blank if the account should never expire.</p>
            <input
              className="border w-full p-2 rounded-md focus:ring-2 focus:ring-blue-500 outline-none"
              type="datetime-local"
              value={
                form.account_expired_at
                  ? format(parseISO(form.account_expired_at), "yyyy-MM-dd'T'HH:mm")
                  : ""
              }
              onChange={(e) =>
                setForm({ ...form, account_expired_at: e.target.value })
              }
            />


          <label className="text-gray-500" htmlFor="form_code">Form Code</label>
          <p className="text-red-500 mb-0 text-sm mt-0">It used to filterize the data in user accounts.</p>
          <input
            className="border p-2 rounded-md w-full focus:ring-2 focus:ring-blue-500 outline-none"
            placeholder="Form Code"
            value={form.form_code}
            onChange={(e) => setForm({ ...form, form_code: e.target.value })}
          />



          

          <button
            type="submit"
            disabled={saving}
            className="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-2 rounded-lg flex justify-center items-center gap-2 transition"
          >
            {saving ? <FaSpinner className="animate-spin" /> : <FaSave />}
            {user ? "Update User" : "Create User"}
          </button>
        </form>
      </div>
    </div>
  );
}
