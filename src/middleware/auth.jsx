import { NextResponse } from 'next/server';
import { jwtVerify } from 'jose';

const SECRET_KEY = process.env.ADMIN_LOGIN_JWT_SECRET;

if(!SECRET_KEY) {
  throw new Error("Missing ADMIN_LOGIN_JWT_SECRET environment variable");
}

// Encode the secret key for jose
const encoder = new TextEncoder();
const secretKeyUint8 = encoder.encode(SECRET_KEY);

export async function authMiddleware(req) {
  const token = req.cookies.get('token')?.value;
  const url = req.nextUrl.clone();

  if (!token) {
    url.pathname = '/login';
    return NextResponse.redirect(url);
  }

  // console.log("Auth Middleware: Verifying token : " + token);
  try {
    await jwtVerify(token, secretKeyUint8);
    return NextResponse.next();
  } catch (err) {
    console.error('Auth Error:', err);
    url.pathname = '/login';
    return NextResponse.redirect(url);
  }
}

export const config = {
  matcher: ['/admin/:path*', '/login'],
};
