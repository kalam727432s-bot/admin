import { NextResponse } from "next/server";
import bcrypt from "bcryptjs";
import { getAuthenticatedUser } from "@/lib/auth";
import { loadEnvConfig } from '@next/env'
const projectDir = process.cwd()
loadEnvConfig(projectDir)

import { db } from "@/lib/db";

export async function PUT(req) {
  try {
    const user = await getAuthenticatedUser();
    if (!user) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const { password, newPassword, confirmNewPassword } = await req.json();

    if (!password || !newPassword) {
      return NextResponse.json(
        { error: "Current and new passwords are required" },
        { status: 400 }
      );
    }

    if(newPassword!=confirmNewPassword) {
      return NextResponse.json(
        { error: "New password and confirm password do not match" },
        { status: 400 }
      );
    }

    // Get current hashed password from DB
    const [rows] = await db.query("SELECT password FROM users WHERE id = ?", [
      user.id,
    ]);
    const existingUser = rows?.[0];
    if (!existingUser) {
      return NextResponse.json({ error: "User not found" }, { status: 404 });
    }

    // Verify old password
    const isMatch = await bcrypt.compare(password, existingUser.password);
    if (!isMatch) {
      return NextResponse.json({ error: "Current password is incorrect" }, { status: 400 });
    }
    const hashedPassword = await bcrypt.hash(newPassword, 10);
    await db.query("UPDATE users SET password = ? WHERE id = ?", [
      hashedPassword,
      user.id,
    ]);

    return NextResponse.json({ message: "Password updated successfully" });
  } catch (err) {
    console.error("Password update error:", err);
    return NextResponse.json({ error: "Internal Server Error" }, { status: 500 });
  }
}
