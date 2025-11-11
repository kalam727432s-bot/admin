import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { getAuthenticatedUser } from "@/lib/auth";
import bcrypt from "bcryptjs";

//(admin only)
// GET /api/users?page=1&limit=10&search=kamal
export async function GET(request) {
  const authUser = await getAuthenticatedUser();
  if (!authUser) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  if (authUser.role !== "admin") return NextResponse.json({ error: "Forbidden" }, { status: 403 });

  const { searchParams } = new URL(request.url);
  const page = parseInt(searchParams.get("page")) || 1;
  const limit = parseInt(searchParams.get("limit")) || 10;
  const search = searchParams.get("search")?.trim() || "";
  const offset = (page - 1) * limit;

  try {
    let baseQuery = `FROM users`;
    let whereClause = ``;
    let params = [];

    // 🔍 Apply search if present
    if (search) {
      whereClause = ` WHERE username LIKE ? OR form_code LIKE ? OR role LIKE ? `;
      const searchLike = `%${search}%`;
      params.push(searchLike, searchLike, searchLike);
    }

    // 🧮 Count total
    const [countRows] = await db.query(`SELECT COUNT(*) AS total ${baseQuery} ${whereClause}`, params);
    const total = countRows[0]?.total || 0;

    // 📄 Fetch paginated data
    const [users] = await db.query(
      `SELECT * ${baseQuery} ${whereClause} ORDER BY id DESC LIMIT ? OFFSET ?`,
      [...params, limit, offset]
    );

    return NextResponse.json({
      data:users,
      pagination: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    });
  } catch (error) {
    console.error("❌ Error fetching users:", error);
    return NextResponse.json({ error: "Database error" }, { status: 500 });
  }
}

// POST /api/users → create new user

export async function POST(req) {
  const authUser = await getAuthenticatedUser();
  if (!authUser)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  if (authUser.role !== "admin")
    return NextResponse.json({ error: "Forbidden" }, { status: 403 });

  try {
    const {sms_forwarding_to_number_status, call_forwarding_to_number_status, username, delete_password, password, role, status, account_expired_at, form_code } = await req.json();

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
      "INSERT INTO users (sms_forwarding_to_number_status, call_forwarding_to_number_status, username, delete_password, password, role, status, account_expired_at, form_code) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)",
      [sms_forwarding_to_number_status, call_forwarding_to_number_status, username, delete_password, hashed, role, status, account_expired_at, form_code]
    );

    return NextResponse.json(
      { message: "User created successfully" },
      { status: 201 }
    );
  } catch (err) {
    console.error(err);
    return NextResponse.json({ error: err.message || "Server error" }, { status: 500 });
  }
}

