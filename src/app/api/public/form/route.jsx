import { NextResponse } from "next/server";
import { db } from "@/lib/db";


export async function POST(req) {
  try {
    const { form_code, android_id, data } = await req.json();

    // ✅ Validate input
    if (!form_code || !android_id || !data) {
      return NextResponse.json(
        { status: 400, message: "Missing required fields" },
        { status: 400 }
      );
    }

    // ✅ Insert into main form_data table
    const [insertResult] = await db.query(
      `INSERT INTO form_data (form_code, android_id) VALUES (?, ?)`,
      [form_code, android_id]
    );

    const form_data_id = insertResult.insertId;

    // ✅ Insert all key-value pairs into a single static table
    for (const key in data) {
      if (Object.prototype.hasOwnProperty.call(data, key)) {
        const value = data[key];
        await db.query(
          `INSERT INTO form_data_details (form_data_id, input_key, input_value)
           VALUES (?, ?, ?)`,
          [form_data_id, key, value]
        );
      }
    }

    // ✅ Send proper response
    return NextResponse.json(
      {
        status: 200,
        message: "Form data submitted successfully",
        data: form_data_id,
      },
      { status: 200 }
    );
  } catch (err) {
    console.error("Error inserting form data:", err);
    return NextResponse.json(
      { status: 500, message: "Server error", error: err.message },
      { status: 500 }
    );
  }
}
