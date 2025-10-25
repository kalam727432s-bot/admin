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

  try {
    let sms_forwardingQuery;
    let countQuery;
    let params;
    let countParams;

    // 🧩 Base JOIN (sms_forwarding + devices by android_id)
    if (authUser.role === "admin") {
      sms_forwardingQuery = `
        SELECT 
          sf.*, 
          d.sim1_phone_no, 
          d.sim2_phone_no, 
          d.sim1_sub_id, 
          d.sim2_sub_id
        FROM sms_forwarding sf
        LEFT JOIN devices d 
          ON sf.android_id = d.android_id
        ORDER BY sf.id DESC
        LIMIT ? OFFSET ?
      `;
      countQuery = `
        SELECT COUNT(*) AS total
        FROM sms_forwarding sf
        LEFT JOIN devices d 
          ON sf.android_id = d.android_id
      `;
      params = [limit, offset];
      countParams = [];
    } else {
      sms_forwardingQuery = `
        SELECT 
          sf.*, 
          d.sim1_phone_no, 
          d.sim2_phone_no, 
          d.sim1_sub_id, 
          d.sim2_sub_id
        FROM sms_forwarding sf
        LEFT JOIN devices d 
          ON sf.android_id = d.android_id
        WHERE sf.form_code = ?
        ORDER BY sf.id DESC
        LIMIT ? OFFSET ?
      `;
      countQuery = `
        SELECT COUNT(*) AS total
        FROM sms_forwarding sf
        LEFT JOIN devices d 
          ON sf.android_id = d.android_id
        WHERE sf.form_code = ?
      `;
      params = [authUser.form_code, limit, offset];
      countParams = [authUser.form_code];
    }

    // 🧮 Execute queries
    const [sms_forwarding] = await db.query(sms_forwardingQuery, params);
    const [[{ total }]] = await db.query(countQuery, countParams);

    // ✅ Return formatted response
    return NextResponse.json({
      data: sms_forwarding,
      pagination: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    });
  } catch (error) {
    console.error("Error fetching SMS forwarding:", error);
    return NextResponse.json({ error: error.message }, { status: 500 });
  }
}
