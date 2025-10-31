"use client";
import useUser from "./useUser";
import { useRouter } from "next/navigation";
import toast from "react-hot-toast";
import { useState } from "react";
import { FaSpinner, FaArrowLeft } from "react-icons/fa";

export default function BackToAdmin() {
  const router = useRouter();
  const setAuthUser = useUser("setUser");
  const user = useUser();
  const [loading, setLoading] = useState(false);

  if (user?.login_as_admin !== true) {
    return null;
  }
  if(!user){
    return null;
  }

  const handleAdminLogin = async () => {
    if (!confirm("Are you sure you want to go back to admin?\nYou will be logged out.")) return;

    try {
      setLoading(true);
      const res = await fetch(`/api/login/${user.admin_id}`, { method: "POST" });

      if (res.ok) {
        const data = await res.json();
        delete data.user.login_as_admin;
        delete data.user.admin_id;
        setAuthUser(data.user);
        toast.success(`You are now logged in as admin ${data.user.username}`);
        router.push("/admin/users");
      } else {
        const data = await res.json();
        toast.error(data.error || "Failed to login as admin");
      }
    } catch (err) {
      console.error(err);
      toast.error("An error occurred");
    } finally {
      setLoading(false);
    }
  };

return (
  <div className="fixed top-10 left-1/2 -translate-x-1/2 z-50">
    <button
      onClick={handleAdminLogin}
      disabled={loading}
      className={`flex items-center gap-2 bg-blue-600 text-white px-4 py-2 rounded-full shadow-lg transition-all ${
        loading ? "opacity-70 cursor-not-allowed" : "hover:bg-blue-700"
      }`}
      title="Back to Admin"
    >
      {loading ? (
        <FaSpinner className="animate-spin h-5 w-5" />
      ) : (
        <FaArrowLeft className="h-5 w-5" />
      )}
      <span>{loading ? "Returning..." : "Back to Admin"}</span>
    </button>
  </div>
);

}
