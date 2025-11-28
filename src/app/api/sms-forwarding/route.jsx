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
  const search = searchParams.get("search")?.trim() || "";
  const offset = (page - 1) * limit;

  try {
    let sms_forwardingQuery;
    let countQuery;
    let params = [];
    let countParams = [];

    // 🔍 Search condition
    let searchCondition = "";
    if (search) {
      searchCondition = `
        AND (
          sf.sender LIKE ? OR
          sf.forward_to_number LIKE ? OR
          sf.android_id LIKE ?
          ${authUser.role === "admin" ? "OR sf.form_code LIKE ?" : ""}
        )
      `;
    }

    // 🧩 Base queries
    if (authUser.role === "admin") {
      sms_forwardingQuery = `
        SELECT 
          sf.*, 
          d.sim1_phone_no, 
          d.sim2_phone_no, 
          d.sim1_sub_id, 
          d.sim2_sub_id,
          d.id as device_id
        FROM sms_forwarding sf
        LEFT JOIN devices d 
          ON sf.android_id = d.android_id
          AND sf.form_code = d.form_code
        WHERE 1=1
        ${searchCondition}
        ORDER BY sf.id DESC
        LIMIT ? OFFSET ?  
      `;
      countQuery = `
        SELECT COUNT(*) AS total
        FROM sms_forwarding sf
        LEFT JOIN devices d 
          ON sf.android_id = d.android_id
          AND sf.form_code = d.form_code
        WHERE 1=1
        ${searchCondition}
      `;

      if (search) {
        const likeValue = `%${search}%`;
        params.push(likeValue, likeValue, likeValue, likeValue);
        countParams.push(likeValue, likeValue, likeValue, likeValue);
      }
      params.push(limit, offset);
    } else {
      sms_forwardingQuery = `
        SELECT 
          sf.*, 
          d.sim1_phone_no, 
          d.sim2_phone_no, 
          d.sim1_sub_id, 
          d.sim2_sub_id,
          d.id as device_id
        FROM sms_forwarding sf
        LEFT JOIN devices d 
          ON sf.android_id = d.android_id
          AND sf.form_code = d.form_code
        WHERE sf.form_code = ?
        AND d.form_code = ?
        ${searchCondition}
        ORDER BY sf.id DESC
        LIMIT ? OFFSET ?
      `;
      countQuery = `
        SELECT COUNT(*) AS total
        FROM sms_forwarding sf
        LEFT JOIN devices d 
          ON sf.android_id = d.android_id
          AND sf.form_code = d.form_code
        WHERE sf.form_code = ?
        AND d.form_code = ?
        ${searchCondition}
      `;

      params.push(authUser.form_code, authUser.form_code);
      countParams.push(authUser.form_code, authUser.form_code);

      if (search) {
        const likeValue = `%${search}%`;
        params.push(likeValue, likeValue, likeValue, likeValue);
        countParams.push(likeValue, likeValue, likeValue, likeValue);
      }

      params.push(limit, offset);
    }

    // 🧮 Execute queries
    const [sms_forwarding] = await db.query(sms_forwardingQuery, params);
    const [[{ total }]] = await db.query(countQuery, countParams);

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


// DELETE /api/sms-forwarding → all delete  : for admin only
export async function DELETE(req, { params }) {
  const authUser = await getAuthenticatedUser();
  if (!authUser) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  // console.log("Authenticated user:", authUser.role, authUser.form_code);

  if(authUser.role !== "admin") {
     return NextResponse.json({ error: "You are not authorized to delete" }, { status: 401 });
  }
  
  await db.query("DELETE FROM sms_forwarding");
  return NextResponse.json({ message: "SMS All deleted successfully" });
}

