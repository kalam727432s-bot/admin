import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import bcrypt from "bcryptjs";
import jwt from "jsonwebtoken";

const SECRET_KEY = process.env.ADMIN_LOGIN_JWT_SECRET;

export async function POST(req) {
  try {
    const { username, password } = await req.json();
    const [rows] = await db.query("SELECT * FROM users WHERE username = ?", [username]);
    if (rows.length === 0) {
      return NextResponse.json({ error: "Invalid username" }, { status: 401 });
    }
    // ccheck status is not disabled
    if (rows[0].status === "Disabled") {
      return NextResponse.json({ error: "Account is disabled" }, { status: 403 });
    }
    // check account expiration
    if (rows[0].account_expired_at && new Date(rows[0].account_expired_at) < new Date()) {
      return NextResponse.json({ error: "Account has expired" }, { status: 403 });
    }
    const user = rows[0];
    const valid = await bcrypt.compare(password, user.password);
    if (!valid) {
      return NextResponse.json({ error: "Invalid password" }, { status: 401 });
    }

    // Generate JWT
    const token = jwt.sign(
      { id: user.id, username: user.username },
      SECRET_KEY,
      { expiresIn: "6h" }
    );
        
    const response = NextResponse.json({ message: "Login successful", user: { id: user.id, username: user.username } });

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
    return NextResponse.json({ error: err.message }, { status: 500 });
  }
}
