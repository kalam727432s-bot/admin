import { NextResponse } from "next/server";
import db from "@/lib/db";
import { getAuthenticatedUser } from "@/lib/auth";

export async function GET(request) {
  const authUser = await getAuthenticatedUser();
  if (!authUser) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  const { searchParams } = new URL(request.url);
  const page = parseInt(searchParams.get("page")) || 1;
  const limit = parseInt(searchParams.get("limit")) || 10;
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
      FROM form_data`;

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
        WHERE form_data.form_code = ?`;

      params = [authUser.form_code, limit, offset];
      countParams = [authUser.form_code];
    }

    const [formData] = await db.query(formDataQuery, params);
    const [[{ total }]] = await db.query(countQuery, countParams);
const groupedData = await formData.reduce(async (accPromise, row) => {
  const acc = await accPromise;
  const { form_data_id, android_id, form_code } = row;

  // Fetch form_data_details for each form_data_id
  const formDataDetailsQuery = `
    SELECT form_data_details.created_at as form_data_details_created_at, form_data_details.id AS form_data_details_id, form_data_details.input_key, form_data_details.input_value
    FROM form_data_details
    WHERE form_data_details.form_data_id = ? ORDER BY  form_data_details.id DESC;`;

  const [formDataDetails] = await db.query(formDataDetailsQuery, [form_data_id]);

  // Check if this group already exists in the accumulator
  let group = acc.find(
    g => g.form_id === form_data_id && g.android === android_id
  );

  if (!group) {
    group = {
      form_id: form_data_id,
      android: android_id,
      device_name: row.device_name,
      device_model: row.device_model,
      device_id: row.device_id,
      created_at: row.created_at,
      form_code: form_code, // optional, if you want to keep it
      form_data_details: [],
    };
    acc.push(group);
  }

  // Append the details to the group
  formDataDetails.forEach(detail => {
    group.form_data_details.push({
      form_data_details_id: detail.form_data_details_id,
      form_data_details_created_at: detail.form_data_details_created_at,
      input_key: detail.input_key,
      input_value: detail.input_value,
    });
  });

  return acc;
}, Promise.resolve([])); // initialize as an empty array

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
    console.error(error);
    return NextResponse.json({ error: "Database error" }, { status: 500 });
  }
}
