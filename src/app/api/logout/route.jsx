// app/api/auth/logout/route.js
import { cookies } from 'next/headers';

export async function GET() {
  const cookieStore = await cookies();
  cookieStore.set({
    name: 'token',
    value: '',
    path: '/',
    maxAge: 0, 
    httpOnly: true,
    secure: process.env.NODE_ENV === 'production',
    sameSite: 'strict',
  });
  return new Response(JSON.stringify({ message: 'Logged out successfully' }), {
    status: 200,
    headers: { 'Content-Type': 'application/json' },
  });
}
