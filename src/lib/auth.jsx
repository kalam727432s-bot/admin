import { cookies } from "next/headers";
import jwt from "jsonwebtoken";
import { db } from "@/lib/db";

const SECRET_KEY = process.env.ADMIN_LOGIN_JWT_SECRET;

/**
 * Verify JWT token from cookies and return the user.
 * @returns {Promise<object|null>} The user object or null if not authenticated.
 */
export async function getAuthenticatedUser() {
  // ✅ FIX: cookies() must be awaited
  const cookieStore = await cookies();
  const token = cookieStore.get("token")?.value;
  if (!token) return null;

  try {
    const decoded = jwt.verify(token, SECRET_KEY);
    // console.log(decoded.login_session,  "Paylaod ");
    const [rows] = await db.query("SELECT * FROM users WHERE id = ? AND status = ?", [decoded.id, "Enabled"]);
    if (!rows || rows.length === 0) return null;
    const user = rows[0];
    
    if(user.role!=='admin'){
        // check hasPassword changed or not as user only
      if (user.password !== decoded.login_session) {
        return null;
      }
    } 

    // login_as_admin and admin_id from token
    if(decoded?.login_as_admin){
      user.login_as_admin = decoded.login_as_admin || false;
      user.admin_id = decoded.admin_id || null;
    }
    return user;
  } catch (err) {
    console.error("JWT verification failed:", err);
    return null;
  }
}
