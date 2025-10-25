import { useContext } from 'react';
import { UserContext } from '@/app/admin/layout';

// Custom hook
export default function useUser(type = 'user') {
  const { user, setUser } = useContext(UserContext);

  if (type === 'user') return user;
  if (type === 'setUser') {
    return setUser;
  }

  return null; // fallback if invalid type
}
