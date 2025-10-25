import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { getAuthenticatedUser } from "@/lib/auth";
import bcrypt from "bcryptjs";

// GET /api/users/:id → get user by id (admin only)
export async function GET(req, { params }) {
  const { id } = params;
  const authUser = await getAuthenticatedUser();

  if (!authUser) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  if (authUser.role !== "admin" && authUser.id != id)
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });

  const [rows] = await db.query("SELECT * FROM users WHERE id = ?", [id]);
  if (rows.length === 0)
    return NextResponse.json({ error: "User not found" }, { status: 404 });

  return NextResponse.json(rows[0]);
}

// PUT /api/users/:id → update user (admin only)
export async function PUT(req, { params }) {
  const { id } = params;
  const authUser = await getAuthenticatedUser();
  if (!authUser) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  if (authUser.role !== "admin")
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });

  try {
    const {username, delete_password, password, role, status, account_expired_at, form_code} = await req.json();
    let query = "UPDATE users SET ";
    const updates = [];
    const values = [];

  
    if (username) { updates.push("username = ?"); values.push(username); }
    if (password) { updates.push("password = ?"); values.push(await bcrypt.hash(password, 10)); }
    if (role && authUser.role === "admin") { updates.push("role = ?"); values.push(role); }
    if (status) { updates.push("status = ?"); values.push(status); }
    if (account_expired_at) { updates.push("account_expired_at = ?"); values.push(account_expired_at); }
    if (form_code) { updates.push("form_code = ?"); values.push(form_code); }
    if (delete_password) { updates.push("delete_password = ?"); values.push(delete_password); } 

    if (updates.length === 0)
      return NextResponse.json({ error: "No fields to update" }, { status: 400 });

    query += updates.join(", ") + " WHERE id = ?";
    values.push(id);

    await db.query(query, values);

    return NextResponse.json({ message: "User updated successfully" });
  } catch (err) {
    console.error(err);
    let displayErrors = err.message || "An error occurred";
    return NextResponse.json({ error: displayErrors }, { status: 500 });
  }
}

// DELETE /api/users/:id → delete user (admin only)
export async function DELETE(req, { params }) {
  const { id } = params;
  const authUser = await getAuthenticatedUser();
  if (!authUser) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  if (authUser.role !== "admin")
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });

  await db.query("DELETE FROM users WHERE id = ?", [id]);
  return NextResponse.json({ message: "User deleted successfully" });
}
