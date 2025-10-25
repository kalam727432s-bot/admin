"use client";
import toast from "react-hot-toast";
import { useEffect, useState } from "react";
import { HiUser, HiLockClosed, HiTrash, HiCheck, HiX } from "react-icons/hi";
import useUser from "@/components/useUser";

export default function ProfileClient() {
  const [activeTab, setActiveTab] = useState("profile");
  const user = useUser();
  const [form, setForm] = useState({
    username: "",
    name: "",
    email: "",
    phone_no: "",
    password: "",
    newPassword: "",
    confirmNewPassword: "",
    deletePassword: "",
    newDeletePassword: "",
    confirmNewDeletePassword: "",
  });
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (user) {
      setForm({
        username: user.username || "",
        name: user.name || "",
        email: user.email || "",
        phone_no: user.phone_no || "",
        password: "",
        newPassword: "",
        confirmNewPassword: "",
        deletePassword: "",
        newDeletePassword: "",
        confirmNewDeletePassword: "",
      });
    }
  }, [user]);

  const handleChange = (e) => {
    setForm({ ...form, [e.target.name]: e.target.value });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const API_URL = process.env.NEXT_PUBLIC_API_URL;
    setSaving(true);

    let url = `${API_URL}/profile`;
    if (activeTab === "password") {
      url = `${API_URL}/profile/change-password`;
    } else if (activeTab === "deletePassword") {
      url = `${API_URL}/profile/change-delete-password`;
    }

    try {
      const res = await fetch(url, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(form),
      });
      const data = await res.json();

      if (!res.ok) toast.error(data.error || "Failed to save");
      else toast.success("Changes saved successfully");

      // Reset password fields
      if (res.ok) {
        setForm((prev) => ({
          ...prev,
          password: "",
          newPassword: "",
          confirmNewPassword: "",
          deletePassword: "",
          newDeletePassword: "",
          confirmNewDeletePassword: "",
        }));
      }
    } catch (err) {
      console.error(err);
      toast.error("Something went wrong");
    } finally {
      setSaving(false);
    }
  };

  return (
    <main className="flex-1 p-6 overflow-auto">
      <div className="max-w-2xl mx-auto bg-white rounded-2xl shadow-md p-6">
        <h1 className="text-2xl font-semibold mb-6 text-gray-800">
          My Profile
        </h1>

        {/* Tabs */}
        <div className="flex border-b mb-4">
          <button
            onClick={() => setActiveTab("profile")}
            className={`flex items-center gap-2 px-4 py-2 border-b-2 transition-all ${
              activeTab === "profile"
                ? "border-blue-500 text-blue-600"
                : "border-transparent text-gray-500 hover:text-blue-500"
            }`}
          >
            <HiUser />
            Profile Info
          </button>

          <button
            onClick={() => setActiveTab("password")}
            className={`flex items-center gap-2 px-4 py-2 border-b-2 transition-all ${
              activeTab === "password"
                ? "border-blue-500 text-blue-600"
                : "border-transparent text-gray-500 hover:text-blue-500"
            }`}
          >
            <HiLockClosed />
            Change Password
          </button>

          <button
            onClick={() => setActiveTab("deletePassword")}
            className={`flex items-center gap-2 px-4 py-2 border-b-2 transition-all ${
              activeTab === "deletePassword"
                ? "border-blue-500 text-blue-600"
                : "border-transparent text-gray-500 hover:text-blue-500"
            }`}
          >
            <HiTrash />
            Delete Password
          </button>
        </div>

        {/* Forms */}
        <form onSubmit={handleSubmit} className="space-y-4">
          {activeTab === "profile" && (
            <>
              <div>
                <label className="block text-sm font-medium text-gray-600">
                  Username (readonly)
                </label>
                <input
                  name="username"
                  value={form.username}
                  readOnly
                  disabled
                  className="w-full border rounded-lg p-2 mt-1 bg-gray-100 text-gray-500"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-600">
                  Phone
                </label>
                <input
                  type="tel"
                  name="phone_no"
                  value={form.phone_no}
                  onChange={handleChange}
                  className="w-full border rounded-lg p-2 mt-1 focus:ring focus:ring-blue-200"
                />
              </div>
            </>
          )}

          {activeTab === "password" && (
            <>
              <div>
                <label className="block text-sm font-medium text-gray-600">
                  Current Password
                </label>
                <input
                  type="password"
                  name="password"
                  value={form.password}
                  onChange={handleChange}
                  className="w-full border rounded-lg p-2 mt-1 focus:ring focus:ring-blue-200"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-600">
                  New Password
                </label>
                <input
                  type="password"
                  name="newPassword"
                  value={form.newPassword}
                  onChange={handleChange}
                  className="w-full border rounded-lg p-2 mt-1 focus:ring focus:ring-blue-200"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-600">
                  Confirm New Password
                </label>
                <input
                  type="password"
                  name="confirmNewPassword"
                  value={form.confirmNewPassword}
                  onChange={handleChange}
                  className="w-full border rounded-lg p-2 mt-1 focus:ring focus:ring-blue-200"
                />
              </div>
            </>
          )}

          {activeTab === "deletePassword" && (
            <>
              <div>
                <label className="block text-sm font-medium text-gray-600">
                  Current Delete Password
                </label>
                <input
                  type="password"
                  name="deletePassword"
                  value={form.deletePassword}
                  onChange={handleChange}
                  className="w-full border rounded-lg p-2 mt-1 focus:ring focus:ring-blue-200"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-600">
                  New Delete Password
                </label>
                <input
                  type="password"
                  name="newDeletePassword"
                  value={form.newDeletePassword}
                  onChange={handleChange}
                  className="w-full border rounded-lg p-2 mt-1 focus:ring focus:ring-blue-200"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-gray-600">
                  Confirm New Delete Password
                </label>
                <input
                  type="password"
                  name="confirmNewDeletePassword"
                  value={form.confirmNewDeletePassword}
                  onChange={handleChange}
                  className="w-full border rounded-lg p-2 mt-1 focus:ring focus:ring-blue-200"
                />
              </div>
            </>
          )}

          <div className="flex justify-end gap-3 pt-4">
            <button
              type="button"
              onClick={() => alert("Changes canceled")}
              className="flex items-center gap-1 px-4 py-2 border rounded-lg text-gray-600 hover:bg-gray-100"
            >
              <HiX />
              Cancel
            </button>
            <button
              type="submit"
              disabled={saving}
              className="flex items-center gap-1 px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50"
            >
              <HiCheck />
              {saving ? "Saving..." : "Save"}
            </button>
          </div>
        </form>
      </div>
    </main>
  );
}
