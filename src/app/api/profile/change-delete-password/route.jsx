import { NextResponse } from "next/server";
import bcrypt from "bcryptjs";
import { getAuthenticatedUser } from "@/lib/auth";
import { db } from "@/lib/db";

export async function PUT(req) {
  try {
    const user = await getAuthenticatedUser();
    if (!user) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const { deletePassword, newDeletePassword, confirmNewDeletePassword } = await req.json();

    if (!deletePassword || !newDeletePassword) {
      return NextResponse.json(
        { error: "Current and new passwords are required" },
        { status: 400 }
      );
    }

    if(newDeletePassword!=confirmNewDeletePassword) {
      return NextResponse.json(
        { error: "New password and confirm password do not match" },
        { status: 400 }
      );
    }

    // Get current hashed password from DB
    const [rows] = await db.query("SELECT delete_password FROM users WHERE id = ?", [
      user.id,
    ]);
    const existingUser = rows?.[0];
    if (!existingUser) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    // Verify old password
    const isMatch = deletePassword === existingUser.delete_password;
    if (!isMatch) {
      return NextResponse.json({ error: "Current password is incorrect" }, { status: 400 });
    }
    await db.query("UPDATE users SET delete_password = ? WHERE id = ?", [
      newDeletePassword,
      user.id,
    ]);

    return NextResponse.json({ message: "Delete Password updated successfully" });
  } catch (err) {
    console.error("Password update error:", err);
    return NextResponse.json({ error: "Internal Server Error" }, { status: 500 });
  }
}
