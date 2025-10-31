import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";
import { getAuthenticatedUser } from "@/lib/auth";


const SECRET_KEY = process.env.ADMIN_LOGIN_JWT_SECRET;

export async function POST(req, { params }) {
  try {
    const { id } = params;
    const authUser = await getAuthenticatedUser();
    if (!authUser) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

    if(authUser.role!=="admin") {
      // if user login as login_as_admin
      if(authUser.login_as_admin !== true) {
          return NextResponse.json({ error: "Forbidden" }, { status: 403 });
      }
    }

    if(id==authUser.id) return NextResponse.json({ error: "You cannot login as yourself" }, { status: 400 });
    
    const [rows] = await db.query("SELECT * FROM users WHERE id = ?", [id]);
    if (rows.length === 0) {
      return NextResponse.json({ error: "Invalid user id" }, { status: 401 });
    }

    const user = rows[0]; 

    // Generate JWT
    const token = jwt.sign(
      { id: user.id, username: user.username, login_as_admin: true, admin_id: authUser.id, login_session: user.password  },
      SECRET_KEY,
      { expiresIn: "6h" }
    );
        
    const response = NextResponse.json({ message: "Login successful", user: user });

    // Set cookie
    response.cookies.set({
      name: "token",
      value: token,
      httpOnly: true, // prevents JS access
      secure: process.env.NODE_ENV === "production", // only over HTTPS in prod
      maxAge: 60 * 60 * 6, // 6 hours in seconds
      path: "/", // cookie available on all routes
      sameSite: "strict",
    });

    return response;

  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: err.message || "Server error" }, { status: 500 });
  }
}
