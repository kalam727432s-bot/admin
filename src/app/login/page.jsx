"use client";
import { useState } from "react";
import Link from "next/link";
import { FaUser, FaLock } from "react-icons/fa"; // User & lock icons
import { useRouter } from "next/navigation"; // in client component
import toast from "react-hot-toast";
import { FaUserShield, FaUserCog, FaUserTie } from 'react-icons/fa';

export default function LoginPage() {
  const [form, setForm] = useState({ username: "", password: "" });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const API_URL = process.env.NEXT_PUBLIC_API_URL + "/login";
  const router = useRouter();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setLoading(true);
    setError("");

    try {
      const response = await fetch(API_URL, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(form),
      });

      const data = await response.json();

      if (response.ok) {
        toast.success("Login successful");
        setForm({ username: "", password: "" });
        router.push("/admin/dashboard");
      } else {
        setError(data.error || "Login failed");
        toast.error(data.error || "Login failed");
      }
    } catch (err) {
      console.error(err);
      setError("An unexpected error occurred");
      toast.error("An unexpected error occurred");  
    } finally {
      setLoading(false);
    }
  };

  return (
    <div 
      className="min-h-screen flex items-center justify-center px-4 bg-[url('/images/Thumb.jpg')] bg-cover bg-center bg-no-repeat"

    >
      <div className="w-full max-w-md bg-white rounded-3xl shadow-xl p-8 transform transition-all duration-500 hover:scale-105">
        <img src="/images/logo.jpg" width={100} height={100} alt="Logo" className="mx-auto mb-2 rounded-full w-[120px] h-[120px] border-4 border-red-800" />
        <div className="text-center flex justify-center items-center gap-3 mb-6">
          {/* <FaUserShield className="text-center text-red-800" size={30} />  */}
          <h1 className="text-3xl text-red-800 font-bold text-center mt-0">
            {process.env.NEXT_PUBLIC_SITE_NAME2}
          </h1>
          {/* <FaUserShield className="text-center text-red-800" size={30} />  */}
        </div>

        <form onSubmit={handleSubmit} className="space-y-5">
          {/* Username / Email */}
          <div className="relative">
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Username or Email
            </label>
            <FaUser className="absolute left-3 top-10 text-gray-400 pointer-events-none" />
            <input
              type="text"
              required
              value={form.username}
              onChange={(e) => setForm({ ...form, username: e.target.value })}
              className="mt-1 w-full pl-10 px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 transition"
              placeholder="Enter your username"
            />
          </div>

          {/* Password */}
          <div className="relative">
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Password
            </label>
            <FaLock className="absolute left-3 top-10 text-gray-400 pointer-events-none" />
            <input
              type="password"
              required
              value={form.password}
              onChange={(e) => setForm({ ...form, password: e.target.value })}
              className="mt-1 w-full pl-10 px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-indigo-500 transition"
              placeholder="Enter your password"
            />
          </div>

          {/* Submit Button */}
          <button
            type="submit"
            disabled={loading}
            className={`w-full py-2 rounded-lg text-white font-semibold transition flex justify-center items-center ${
              loading ? "bg-indigo-400 cursor-not-allowed" : "bg-indigo-600 hover:bg-indigo-700"
            }`}
          >
            {loading && (
              <svg
                className="animate-spin h-5 w-5 text-white mr-2"
                xmlns="http://www.w3.org/2000/svg"
                fill="none"
                viewBox="0 0 24 24"
              >
                <circle
                  className="opacity-25"
                  cx="12"
                  cy="12"
                  r="10"
                  stroke="currentColor"
                  strokeWidth="4"
                ></circle>
                <path
                  className="opacity-75"
                  fill="currentColor"
                  d="M4 12a8 8 0 018-8v4l3-3-3-3v4a8 8 0 00-8 8h4l-3 3 3 3h-4z"
                ></path>
              </svg>
            )}
            {loading ? "Signing In..." : "Sign In"}
          </button>
        </form>

        <p className="text-center text-sm text-gray-600 mt-5">
          Contact Admin : <Link href="https://wa.me/919007737065" className="text-indigo-600 hover:underline font-medium">
            +91 9007737065
          </Link>
        </p>
      </div>
    </div>
  );
}
