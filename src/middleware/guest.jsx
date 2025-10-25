// middleware/guest.js
import { NextResponse } from 'next/server';
import jwt from 'jsonwebtoken';

const SECRET_KEY = process.env.ADMIN_LOGIN_JWT_SECRET;

if (!SECRET_KEY) {
  throw new Error("Missing ADMIN_LOGIN_JWT_SECRET environment variable");
}
const encoder = new TextEncoder();
const secretKeyUint8 = encoder.encode(SECRET_KEY);

export function guestMiddleware(req) {
  const token = req.cookies.get('token')?.value;
  const url = req.nextUrl.clone();

  if (token) {
    try {
      jwt.verify(token, secretKeyUint8);
      // Authenticated user → redirect to dashboard
      url.pathname = '/admin/dashboard';
      return NextResponse.redirect(url);
    } catch {
      return NextResponse.next(); // invalid token → allow access
    }
  }

  return NextResponse.next(); // not logged in → allow access
}
