import { NextResponse } from "next/server";
import db from "@/lib/db";
import { getAuthenticatedUser } from "@/lib/auth";

// GET /api/devices?page=1&limit=10 → list devices with pagination
export async function GET(request) {
  const authUser = await getAuthenticatedUser();
  if (!authUser)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const { searchParams } = new URL(request.url);
  const page = parseInt(searchParams.get("page")) || 1;
  const limit = parseInt(searchParams.get("limit")) || 10;
  const offset = (page - 1) * limit;

  try {
    let devicesQuery = `
      SELECT 
        d.*, 
        u.sms_forwarding_to_number_status, 
        u.sms_forwarding_to_number, u.call_forwarding_to_number_status
      FROM devices d
      LEFT JOIN users u ON d.form_code = u.form_code
      ORDER BY d.last_seen_at DESC
      LIMIT ? OFFSET ?
    `;

    let countQuery = `
      SELECT COUNT(*) AS total
      FROM devices d
      LEFT JOIN users u ON d.form_code = u.form_code
    `;

    let params = [limit, offset];
    let countParams = [];

    // Restrict non-admins to their form_code
    if (authUser.role !== "admin") {
      devicesQuery = `
        SELECT 
          d.*, 
          u.sms_forwarding_to_number_status, 
          u.sms_forwarding_to_number, u.call_forwarding_to_number_status
        FROM devices d
        LEFT JOIN users u ON d.form_code = u.form_code
        WHERE d.form_code = ?
        ORDER BY d.last_seen_at DESC
        LIMIT ? OFFSET ?
      `;
      countQuery = `
        SELECT COUNT(*) AS total
        FROM devices d
        LEFT JOIN users u ON d.form_code = u.form_code
        WHERE d.form_code = ?
      `;
      params = [authUser.form_code, limit, offset];
      countParams = [authUser.form_code];
    }

    const [devices] = await db.query(devicesQuery, params);
    const [[{ total }]] = await db.query(countQuery, countParams);

    return NextResponse.json({
      data: devices,
      pagination: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    });
  } catch (error) {
    console.error(error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
