import { authMiddleware } from './middleware/auth';
import { guestMiddleware } from './middleware/guest';

export function middleware(req) {
  const path = req.nextUrl.pathname;

  // console.log('Middleware path:', path);

  if (path.startsWith('/admin')) {
    return authMiddleware(req);
  }

  if (path === '/login') {
    return guestMiddleware(req);
  }
  return NextResponse.next(); // other routes
}

export const config = {
  matcher: ['/admin/:path*', '/login'], 
};
