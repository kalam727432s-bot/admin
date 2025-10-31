import { FaEdit, FaTrashAlt, FaSpinner, FaUsers, FaLongArrowAltRight } from "react-icons/fa";
import toast from "react-hot-toast";
import useUser from "../useUser";
import { useRouter } from "next/navigation";
import { currentTime } from "@/Helper";
import { format, parseISO } from "date-fns";
export default function UserTable({ users, loading, onEdit, onRefresh }) {
  const setAuthUser = useUser("setUser");
  const user = useUser();
  const router = useRouter();
  const handleDelete = async (id) => {
    if (!confirm("Are you sure you want to delete this user?")) return;
    try {
      const res = await fetch(`/api/users/${id}`, { method: "DELETE" });
      if (res.ok) onRefresh(); toast.success("User deleted");
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
        if(data?.user){
           const updatedUser = {
            ...data.user,
            login_as_admin: true,
            admin_id: user.id,
          };
          setAuthUser(updatedUser);
          toast.success(`You are logged in as user ${updatedUser.username}`);
          router.push("/admin/dashboard");
        }else {
          toast.error("Failed to login as user");
        }
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
      <h2 className="text-xl font-semibold mb-4 text-gray-700 flex items-center gap-2">
        <FaUsers className="text-blue-600" /> All Users
      </h2>

      {loading ? (
        <div className="flex justify-center py-10">
          <FaSpinner className="animate-spin text-blue-600 text-3xl" />
        </div>
      ) : (
        <div className="overflow-x-auto">
          <table className="w-full border-collapse text-sm text-center">
            <thead className="bg-gray-100 text-gray-700 text-center">
              <tr>
                <th className="p-3">#</th>
                <th className="p-3">Username</th>
                <th className="p-3">Form Code</th>
                <th className="p-3">DeletePass</th>
                <th className="p-3">Role</th>
                <th className="p-3">Status</th>
                <th className="p-3">SMSF Number</th>
                <th className="p-3">Expired At</th>
                <th className="p-3 text-center">Actions</th>
              </tr>
            </thead>
            <tbody>
              {users.map((u, i) => (
                <tr key={u.id} className="border-b hover:bg-gray-50 transition">
                  <td className="p-3">{i + 1}</td>
                  <td className="p-3 font-medium">{u.username}</td>
                  <td className="p-3 font-medium">{u.form_code}</td>
                  <td className="p-3 font-medium">{u.delete_password}</td>
                  <td className="p-3 capitalize">{u.role}</td>
                  <td className="p-3 capitalize">
                    <span className={`px-2 py-1 rounded-full text-xs font-semibold ${u.status === "Enabled" ? "bg-green-100 text-green-800" : "bg-red-100 text-red-800"}`}>
                      {u.status}
                    </span>
                  </td>
                  <td className="p-3">{u.sms_forwarding_to_number || "-"}</td>
                  <td className="p-3">{u.account_expired_at ? format(parseISO(u.account_expired_at), "dd-MM-yyyy HH:mm") : "Never"}</td>
                  <td className="p-3 text-center space-x-2">
                    <button
                      title="Login as User"
                      onClick={() => handleLogin(u.id)}
                      className="inline-flex items-center justify-center w-8 h-8 rounded-md bg-blue-50 text-blue-600 hover:bg-blue-100 transition"
                    >
                      <FaLongArrowAltRight />
                    </button>
                    <button
                      title="Edit User"
                      onClick={() => onEdit(u)}
                      className="inline-flex items-center justify-center w-8 h-8 rounded-md bg-blue-50 text-blue-600 hover:bg-blue-100 transition"
                    >
                      <FaEdit />
                    </button>
                    <button
                      title="Delete User"
                      onClick={() => handleDelete(u.id)}
                      className="inline-flex items-center justify-center w-8 h-8 rounded-md bg-red-50 text-red-600 hover:bg-red-100 transition"
                    >
                      <FaTrashAlt />
                    </button>
                  </td>
                </tr>
              ))}
              {users.length === 0 && (
                <tr>
                  <td colSpan="5" className="text-center text-gray-500 py-6">
                    No users found.
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
