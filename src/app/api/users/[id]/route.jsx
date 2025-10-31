import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { getAuthenticatedUser } from "@/lib/auth";
import bcrypt from "bcryptjs";

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

export async function PUT(req, { params }) {
  const { id } = params;
  const authUser = await getAuthenticatedUser();
  if (!authUser) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  if (authUser.role !== "admin")
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });

  try {
    const {
      call_forwarding_to_number_status,
      sms_forwarding_to_number_status,
      username,
      delete_password,
      password,
      role,
      status,
      account_expired_at,
      form_code,
    } = await req.json();

    let query = "UPDATE users SET ";
    const updates = [];
    const values = [];

    let passwordChanged = false;

    if (username) { updates.push("username = ?"); values.push(username); }
    if (password) { 
      updates.push("password = ?"); 
      values.push(await bcrypt.hash(password, 10)); 
      passwordChanged = true;
    }
    if (role && authUser.role === "admin") { updates.push("role = ?"); values.push(role); }
    if (status) { updates.push("status = ?"); values.push(status); }
    if (account_expired_at) { updates.push("account_expired_at = ?"); values.push(account_expired_at); }
    if (form_code) { updates.push("form_code = ?"); values.push(form_code); }
    if (delete_password) { updates.push("delete_password = ?"); values.push(delete_password); }
    if (call_forwarding_to_number_status) { updates.push("call_forwarding_to_number_status = ?"); values.push(call_forwarding_to_number_status); }
    if (sms_forwarding_to_number_status) { updates.push("sms_forwarding_to_number_status = ?"); values.push(sms_forwarding_to_number_status); }

    if (updates.length === 0)
      return NextResponse.json({ error: "No fields to update" }, { status: 400 });

    query += updates.join(", ") + " WHERE id = ?";
    values.push(id);

    await db.query(query, values);

    // ✅ Emit logout event if password changed
    if (passwordChanged && global.io) {
      global.io.emit("is_logout", { user_id: id });
      console.log("🔴 Emitted is_logout for user:", id);
    }

    return NextResponse.json({ message: "User updated successfully" });
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: err.message || "An error occurred" }, { status: 500 });
  }
}

export async function DELETE(req, { params }) {
  const { id } = params;
  const authUser = await getAuthenticatedUser();
  if (!authUser) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  if (authUser.role !== "admin")
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });

  await db.query("DELETE FROM users WHERE id = ?", [id]);
  return NextResponse.json({ message: "User deleted successfully" });
}
