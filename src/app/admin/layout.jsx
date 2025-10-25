'use client';
import { useState, useEffect, createContext } from 'react';
import Sidebar from '@/components/Sidebar';
import AccountExpiredInfo from '@/components/users/AccountExpiredInfo';
import LogoutButton from '@/components/LogoutButton';
import { HiOutlineMenu } from 'react-icons/hi';
import BackToAdmin from '@/components/BackToAdmin';

// Provide both user and setUser to allow updates from client components
export const UserContext = createContext({ user: null, setUser: () => {} });

export default function RootLayout({ children }) {
  const [sidebarOpen, setSidebarOpen] = useState(false);
  const [user, setUser] = useState(null);
  const toggleSidebar = () => setSidebarOpen(!sidebarOpen);

  useEffect(() => {
    fetch('/api/profile')
      .then((res) => res.json())
      .then((data) => setUser(data.data))
      .catch((err) => console.error(err));
  }, []);

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
        <div className="flex justify-center mt-3">
          <AccountExpiredInfo />
        </div>

        {/* Page content */}
        {children}

        {/* Back toAdmin */}
        <BackToAdmin />
      </div>
    </UserContext.Provider>
  );
}
