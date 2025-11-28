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
    let formDataQuery = `
      SELECT 
        fd.id AS form_data_id,
        fd.android_id,
        fd.form_code,
        fd.created_at,
        d.device_name,
        d.device_model,
        d.id as device_id
      FROM form_data fd
      LEFT JOIN devices d 
        ON fd.android_id = d.android_id 
       AND fd.form_code = d.form_code
      ORDER BY fd.id DESC
      LIMIT ? OFFSET ?;
    `;

    let countQuery = `
      SELECT COUNT(*) AS total
      FROM form_data;
    `;

    let params = [limit, offset];
    let countParams = [];

    // Apply form_code filter for non-admin users
    if (authUser.role !== "admin") {
      formDataQuery = `
        SELECT 
          fd.id AS form_data_id,
          fd.android_id,
          fd.form_code,
          fd.created_at,
          d.device_name,
          d.device_model,
          d.id AS device_id
        FROM form_data fd
        LEFT JOIN devices d
          ON fd.android_id = d.android_id
         AND fd.form_code = d.form_code
        WHERE fd.form_code = ?
        ORDER BY fd.id DESC
        LIMIT ? OFFSET ?;
      `;

      countQuery = `
        SELECT COUNT(*) AS total
        FROM form_data
        WHERE form_data.form_code = ?;
      `;

      params = [authUser.form_code, limit, offset];
      countParams = [authUser.form_code];
    }

    // --- 1️⃣ Fetch main form_data list
    const [formData] = await db.query(formDataQuery, params);

    // --- 2️⃣ Get total count for pagination
    const [[{ total }]] = await db.query(countQuery, countParams);

    // --- 3️⃣ Collect all form_data_ids
    const formIds = formData.map((row) => row.form_data_id);
    let formDataDetails = [];

    // --- 4️⃣ Fetch all details in one query
    if (formIds.length > 0) {
      const [details] = await db.query(
        `
        SELECT 
          form_data_id,
          id AS form_data_details_id,
          created_at AS form_data_details_created_at,
          input_key,
          input_value
        FROM form_data_details
        WHERE form_data_id IN (?)
        ORDER BY id DESC;
        `,
        [formIds]
      );
      formDataDetails = details;
    }

    // --- 5️⃣ Group details by form_data_id
    const detailsMap = {};
    formDataDetails.forEach((detail) => {
      if (!detailsMap[detail.form_data_id])
        detailsMap[detail.form_data_id] = [];
      detailsMap[detail.form_data_id].push({
        form_data_details_id: detail.form_data_details_id,
        form_data_details_created_at: detail.form_data_details_created_at,
        input_key: detail.input_key,
        input_value: detail.input_value,
      });
    });

    // --- 6️⃣ Combine with form_data
    const groupedData = formData.map((row) => ({
      form_id: row.form_data_id,
      android: row.android_id,
      device_name: row.device_name,
      device_model: row.device_model,
      device_id: row.device_id,
      created_at: row.created_at,
      form_code: row.form_code,
      form_data_details: detailsMap[row.form_data_id] || [],
    }));

    // --- 7️⃣ Return response
    return NextResponse.json({
      data: groupedData,
      pagination: {
        total,
        page,
        limit,
        totalPages: Math.ceil(total / limit),
      },
    });
  } catch (error) {
    console.error("DB Error:", error);
    return NextResponse.json({ error: "Database error" }, { status: 500 });
  }
}
