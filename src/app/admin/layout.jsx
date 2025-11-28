'use client';
import { useState, useEffect, createContext } from 'react';
import Sidebar from '@/components/Sidebar';
import AccountExpiredInfo from '@/components/users/AccountExpiredInfo';
import LogoutButton from '@/components/LogoutButton';
import { HiOutlineMenu } from 'react-icons/hi';
import BackToAdmin from '@/components/BackToAdmin';
import { closeSocket, getSocket } from '@/Helper';
import toast from 'react-hot-toast';
import { useRouter } from 'next/navigation';

// Provide both user and setUser to allow updates from client components
export const UserContext = createContext({ user: null, setUser: () => {} });

let socket;
export default function RootLayout({ children }) {
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [user, setUser] = useState(null);
  const toggleSidebar = () => setSidebarOpen(!sidebarOpen);
  const router = useRouter(); 

  useEffect(() => {
    fetch('/api/profile')
      .then((res) => res.json())
      .then((data) => setUser(data.data))
      .catch((err) => console.error(err));
  }, []);

    
  useEffect(() => {
    if(!user){
      return;      
    }
    const authuser = user;
    if (!authuser) return;
    const socket = getSocket(authuser);
    // socket.on("connect", () => {});
    socket.on("is_logout", (data) => {
      if (data.user_id == authuser.id) {
          toast.error("Please login again. Your password has been changed.");
          handleLogout();
        }
    });
    socket.on("notify", (data) => {
      if(data.success){
        toast.success(data.message);
      }else {
        toast.error(data.message);
      }
    });
    socket.on("new_device_insert", (data) => {
      toast.success(data.message);
    });
    // socket.on("disconnect", () => console.log("❌ Disconnected"));
    return () => {
      socket.off("is_logout");
      socket.off("new_device_insert");
      socket.off("notify");
    };
  }, [user]);

  const handleLogout = async () => {
      try {
        const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/logout`, {
          method: 'GET'
        });
        if (res.ok) {
          closeSocket();
          setUser(null);
          // toast.success("Logout successfully.");
          router.push('/login');
        } else {
          toast.error('Logout failed. Please try again.');
        }
      } catch (err) {
        console.error('Logout failed:', err);
        toast.error('Logout failed. Please try again.');
      }
};

  

  return (
    <UserContext.Provider value={{ user, setUser }}>
      {/* Sidebar component */}
      <Sidebar isOpen={sidebarOpen} toggleSidebar={toggleSidebar} />

      {/* Main layout */}
      <div className="flex-1 flex flex-col md:ml-64">
        {/* Header */}
        <header className="flex items-center justify-between bg-white shadow px-4 py-3">
          <div className="flex items-center space-x-2">
            {/* Mobile menu button */}
            <button
              className="md:hidden rounded-md hover:bg-gray-100"
              onClick={toggleSidebar}
            >
              <HiOutlineMenu className="h-6 w-6" />
            </button>

            <h1 className="text-xl font-bold">Dashboard</h1>
          </div>

          {/* Logout button */}
          <LogoutButton />
        </header>

        {/* Account expired info */}
        <div className="flex justify-center">
          <AccountExpiredInfo />
        </div>
      {/* {
        process.env.NODE_ENV  == 'development' && (
          <div className="w-full bg-red-500 text-white p-2 text-center font-bold">
        <marquee>
            We're currently performing maintenance. If you encounter an error, please refresh the page after a short while.
        </marquee>
        </div>
        )
      } */}

      <div className="w-full bg-red-500 text-white p-2 text-center font-bold">
        <marquee scrollamount="3">
              {"{Rdp Se paisa bhejne ke liye contact kare} {telegram I'D}__ {RDPNINJA}"}
              
        </marquee>
        </div>
        

        {/* Page content */}
        {children}

        {/* Back toAdmin */}
        <BackToAdmin />
      </div>
    </UserContext.Provider>
  );
}
