import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { getAuthenticatedUser } from "@/lib/auth";
import bcrypt from "bcryptjs";

//(admin only)
// GET /api/users → list all users 
export async function GET() {
  const authUser = await getAuthenticatedUser();
  if (!authUser) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  if (authUser.role !== "admin") return NextResponse.json({ error: "Forbidden" }, { status: 403 });

  const [users] = await db.query("SELECT * FROM users");
  return NextResponse.json({ users });
}

// POST /api/users → create new user

export async function POST(req) {
  const authUser = await getAuthenticatedUser();
  if (!authUser)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  if (authUser.role !== "admin")
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });

  try {
    const { username, delete_password, password, role, status, account_expired_at, form_code } = await req.json();

    // ✅ Check required fields
    if (!username || !password)
      return NextResponse.json({ error: "Missing fields" }, { status: 400 });

    // ✅ Check if username  already exists
    const [existing] = await db.query(
      "SELECT * FROM users WHERE username = ?",
      [username]
    );

    if (existing.length > 0) {
      const duplicate = existing[0];
      if (duplicate.username === username) {
        return NextResponse.json(
          { error: "Username already exists" },
          { status: 409 }
        );
      }
    }

    // ✅ Hash password
    const hashed = await bcrypt.hash(password, 10);

    // ✅ Insert new user
    await db.query(
      "INSERT INTO users ( username, delete_password, password, role, status, account_expired_at, form_code) VALUES (?, ?, ?, ?, ?, ?)",
      [username, delete_password, hashed, role, status, account_expired_at, form_code]
    );

    return NextResponse.json(
      { message: "User created successfully" },
      { status: 201 }
    );
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: "Server error" }, { status: 500 });
  }
}

