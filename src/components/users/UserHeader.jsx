import { FaUserShield, FaUserPlus } from "react-icons/fa";

export default function UserHeader({ onAdd }) {
  return (
    <div className="flex justify-between items-center">
      <h1 className=" text-2xl font-bold text-gray-800 flex items-center gap-2">
        <FaUserShield className="text-blue-600" /> User Management
      </h1> 
      <button
        onClick={onAdd}
        className="flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white px-4 py-2 rounded-lg shadow transition"
      >
        <FaUserPlus /> New User
      </button>
    </div>
  );
}
