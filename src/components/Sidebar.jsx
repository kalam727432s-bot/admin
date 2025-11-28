'use client';
import { useRouter } from 'next/navigation';
import { useState } from 'react';
import { usePathname } from 'next/navigation';
import {
  HiChevronLeft,
  HiOutlineHome,
  HiOutlineUserGroup,
  HiOutlineUser,
  HiOutlineDocumentText,
  HiX,
} from 'react-icons/hi';
import Link from 'next/link';
import useUser from './useUser';


export default function Sidebar({ isOpen, toggleSidebar }) {
  const [collapsed, setCollapsed] = useState(false);
  const [loading, setLoading] = useState(false); // loading state
  const pathname = usePathname(); 
  const user = useUser();

  const handleCollapse = () => setCollapsed(!collapsed);

  const handleToggleMobileSidebar = () => {
    if (window.innerWidth < 768) {
       toggleSidebar();
    }
  };

  const menuItems = [
    { name: 'Device List', icon: HiOutlineDocumentText, href: '/admin/devices' },
    // { name: 'Dashboard', icon: HiOutlineHome, href: '/admin/dashboard' },
    { name: 'Form Data List', icon: HiOutlineDocumentText, href: '/admin/form-data' },
    { name: 'SMS List', icon: HiOutlineDocumentText, href: '/admin/sms-forwarding' },
    // { name: 'Email List', icon: HiOutlineDocumentText, href: '/admin/email' },
    { name: 'SMS Forward Number', icon: HiOutlineDocumentText, href: '/admin/sms-forward-number' },
    { name: 'User List', icon: HiOutlineUserGroup, href: '/admin/users' },
    { name: 'My Profile', icon: HiOutlineUser, href: '/admin/profile' },
    
  ];
  // remove user list if user.role!==admin
  if (user?.role !== 'admin') {
    const index = menuItems.findIndex(item => item.name === 'User List');
    if (index !== -1) {
      menuItems.splice(index, 1);
    }
  }

  // remove sms forwarding number if admin
  if (user?.role === 'admin') {
    const index = menuItems.findIndex(item => item.name === 'SMS Forward Number');
    if (index !== -1) {
      menuItems.splice(index, 1);
    }
  }

  // Logout function


  const router = useRouter();
  const handleLogout = async () => {
    try {
      setLoading(true);
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/logout`, {
        method: 'GET'
      });

      if (res.ok) {
        router.push('/login');
      } else {
        alert('Logout failed. Please try again.');
      }
    } catch (err) {
      console.error('Logout failed:', err);
      alert('Logout failed. Please try again.');
    } finally {
      setLoading(false);
    }
  };

  return (
    <>
      {/* Sidebar */}
      <div
        className={`fixed inset-y-0 left-0 z-30 bg-gray-800 text-white transform ${
          isOpen ? 'translate-x-0' : '-translate-x-full'
        } md:translate-x-0 transition-all duration-300 ease-in-out ${
          collapsed ? 'w-[91px]' : 'w-64'
        }`}
      >
        <div className="p-5 font-bold text-xl border-b border-gray-700 flex justify-between items-center">
          <div className="flex items-center gap-2">
          {/* {!collapsed && (
            <img
              src="/images/adminLogo.jpg"
              alt="Admin Logo"
              className="w-[30px] h-[30px]"
            />
          )} */}
          <span className="truncate text-red-400">
            {collapsed ? 'SK' : process.env.NEXT_PUBLIC_SITE_NAME2}
          </span>
        </div>

          <button
            onClick={handleCollapse}
            className="hidden md:block text-white hover:text-white focus:outline-none"
          >
            <HiChevronLeft
              className={`w-5 h-5  transform transition-transform duration-300 ${
                collapsed ? 'rotate-180' : ''
              }`}
            />
          </button>
          {/* close button */}
            <button
              onClick={toggleSidebar}
              className="md:hidden text-white hover:text-white focus:outline-none"
            >
              <HiX className="w-5 h-5" />
            </button>
        </div>

        <nav className="mt-5">
          {menuItems.map((item) => {
            const isActive = pathname === item.href;
            return (
              <Link
                onClick={handleToggleMobileSidebar}
                key={item.name}
                href={item.href}
                className={`flex items-center px-4 py-2 rounded transition-colors my-4 ${
                  isActive ? 'bg-blue-600 text-white' : 'hover:bg-gray-700'
                } ${collapsed ? 'justify-center' : ''} `}
              >
                <item.icon className="w-5 h-5 mr-3" />
                {!collapsed && <span>{item.name}</span>}
              </Link>
            );
          })}
          {/* logout button */}
        
        </nav>
      </div>

      {/* Overlay for mobile */}
      {isOpen && (
        <div
          onClick={toggleSidebar}
          className="fixed inset-0 bg-[#0000006e] bg-opacity-50 z-20 md:hidden"
        ></div>
      )}
    </>
  );
}
