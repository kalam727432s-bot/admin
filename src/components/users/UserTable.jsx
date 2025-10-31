import {
  FaEdit,
  FaTrashAlt,
  FaSpinner,
  FaUsers,
  FaLongArrowAltRight,
  FaCircle,
} from "react-icons/fa";
import toast from "react-hot-toast";
import useUser from "../useUser";
import { useRouter } from "next/navigation";
import { format, parseISO } from "date-fns";
import { timeAgo } from "@/Helper";

export default function UserTable({ users, loading, onEdit, onRefresh }) {
  const setAuthUser = useUser("setUser");
  const user = useUser();
  const router = useRouter();

  const handleDelete = async (id) => {
    if (!confirm("Are you sure you want to delete this user?")) return;
    try {
      const res = await fetch(`/api/users/${id}`, { method: "DELETE" });
      if (res.ok) {
        onRefresh();
        toast.success("User deleted");
      }
    } catch (err) {
      console.error(err);
      toast.error("An error occurred");
    }
  };

  const handleLogin = async (id) => {
    if (!confirm("Are you sure you want to login this user?\nYou will logout")) return;
    try {
      const res = await fetch(`/api/login/${id}`, { method: "POST" });
      if (res.ok) {
        const data = await res.json();
        if (data?.user) {
          const updatedUser = {
            ...data.user,
            login_as_admin: true,
            admin_id: user.id,
          };
          setAuthUser(updatedUser);
          toast.success(`You are logged in as ${updatedUser.username}`);
          router.push("/admin/dashboard");
        } else toast.error("Failed to login as user");
      } else {
        const data = await res.json();
        toast.error(data.error || "Failed to login as user");
      }
    } catch (err) {
      console.error(err);
      toast.error("An error occurred");
    }
  };

  return (
    <div className="bg-white p-6 rounded-lg shadow-md border border-gray-100">
      <h2 className="text-xl font-semibold mb-5 text-gray-800 flex items-center gap-2">
        <FaUsers className="text-blue-600" />
        All Users ({users.length})
      </h2>

      {loading ? (
        <div className="flex justify-center py-10">
          <FaSpinner className="animate-spin text-blue-600 text-3xl" />
        </div>
      ) : users.length === 0 ? (
        <p className="text-center text-gray-500 py-6">No users found.</p>
      ) : (
        <div className="grid gap-5 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4">
          {users.map((u, i) => (
            <div
              key={u.id}
              className="relative border border-gray-200 rounded-xl px-4 py-2 shadow-sm hover:shadow-md transition bg-white"
            >
              <span className="text-gray-400">#{u.id}</span>
              {/* Status Badge (Enabled/Disabled) */}
              <span
                className={`absolute top-2 right-2 px-3 py-1 rounded-full text-xs font-bold ${
                  u.status === "Enabled"
                    ? "bg-green-100 text-green-700"
                    : "bg-red-100 text-red-700"
                }`}
              >
                {u.status}
              </span>

              {/* Username */}
              <h3 className="font-bold text-blue-800 text-base mb-1">
                {u.username} 
              </h3>

              {/* Online/Offline */}
              <div className="flex items-center gap-1 mb-2">
                <FaCircle
                  className={`text-${
                    u.user_status=="online" ? "green" : "red"
                  }-600 text-[10px]`}
                />
                <span
                  className={`font-bold text-sm ${
                    u.user_status=="online" ? "text-green-600" : "text-red-600"
                  }`}
                >
                  {u.user_status=="online" ? "Online" : "Offline("+timeAgo(u.last_seen_at)+")"}
                </span>
              </div>

              {/* User Details */}
              <div className="text-sm text-gray-600 space-y-1">
                <p>
                  <span className="font-medium text-gray-700">Form Code:</span>{" "}
                  {u.form_code || "-"}
                </p>
                <p>
                  <span className="font-medium text-gray-700">Delete Pass:</span>{" "}
                  {u.delete_password || "-"}
                </p>
                <p>
                  <span className="font-medium text-gray-700">Role:</span>{" "}
                  {u.role || "-"}
                </p>
                <p>
                  <span className="font-medium text-gray-700">
                    SMS Forward To:
                  </span>{" "}
                  {u.sms_forwarding_to_number || "-"}
                </p>
                <p>
                  <span className="font-medium text-gray-700">Expires:</span>{" "}
                  {u.account_expired_at
                    ? format(parseISO(u.account_expired_at), "dd-MM-yyyy HH:mm")
                    : "Never"}
                </p>
              </div>

              {/* Actions */}
              <div className="flex justify-between items-center mt-4">
                <div className="text-xs text-gray-400">#{i + 1}</div>
                <div className="flex space-x-2">
                  <button
                    onClick={() => handleLogin(u.id)}
                    title="Login as User"
                    className="p-2 rounded-md bg-blue-50 text-blue-600 hover:bg-blue-100 transition"
                  >
                    <FaLongArrowAltRight />
                  </button>
                  <button
                    onClick={() => onEdit(u)}
                    title="Edit"
                    className="p-2 rounded-md bg-yellow-50 text-yellow-600 hover:bg-yellow-100 transition"
                  >
                    <FaEdit />
                  </button>
                  <button
                    onClick={() => handleDelete(u.id)}
                    title="Delete"
                    className="p-2 rounded-md bg-red-50 text-red-600 hover:bg-red-100 transition"
                  >
                    <FaTrashAlt />
                  </button>
                </div>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
