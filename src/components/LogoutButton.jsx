'use client';
import { useRouter } from 'next/navigation';
import { useState } from 'react';
import useUser from './useUser';
export default function LogoutButton() {
    const [loading, setLoading] = useState(false); // loading state
    const router = useRouter();
    const setAuthUser = useUser('setUser');
    const handleLogout = async () => {
    try {
      setLoading(true);
      const res = await fetch(`${process.env.NEXT_PUBLIC_API_URL}/logout`, {
        method: 'GET'
      });

      if (res.ok) {
        setAuthUser(null);
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

  return <>

 <button
    onClick={handleLogout} 
    disabled={loading} 
    className={`flex items-center gap-2  text-white px-4 py-2 rounded-lg shadow transition 
        ${ loading ? 'bg-gray-500 cursor-not-allowed' : 'bg-red-600 hover:bg-red-700'} `
    }>
    <svg
        className="w-5 h-5"
        fill="none"
        stroke="currentColor"
        viewBox="0 0 24 24"
        xmlns="http://www.w3.org/2000/svg"
    >
        <path
        strokeLinecap="round"
        strokeLinejoin="round"
        strokeWidth={2}
        d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a2 2 0 01-2 2H5a2 2 0 01-2-2V7a2 2 0 012-2h6a2 2 0 012 2v1"
        />  
    </svg>
    <span>{loading ? 'Logging out...' : 'Logout'}</span>
</button>
  
  </>

}