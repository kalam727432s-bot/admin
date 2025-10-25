import { NextResponse } from "next/server";
import { getAuthenticatedUser } from "@/lib/auth";
import { db } from "@/lib/db";


export async function GET() {
  const user = await getAuthenticatedUser();
  if (!user) {
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  }


  return NextResponse.json({ data:user});
}


export async function PUT(req) {
  try {
    const user = await getAuthenticatedUser();
    if (!user) {
      return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
    }

    const { name, phone } = await req.json();

    if (!name) {
      return NextResponse.json({ error: "Name is required" }, { status: 400 });
    }

    // Update the user profile
    await db.query(
      "UPDATE users SET name = ?, phone_no = ? WHERE id = ?",
      [name, phone || null, user.id]
    );

    return NextResponse.json({ message: "Profile updated successfully ✅" });
  } catch (err) {
    console.error("Profile update error:", err);
    return NextResponse.json({ error: "Internal Server Error" }, { status: 500 });
  }
}


