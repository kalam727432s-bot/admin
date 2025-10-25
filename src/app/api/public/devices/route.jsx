/* 
-- Device Registration --
1. If device_id(id) exists, update the record
2. else 
   a. Where Form_Code And Android_id
      i. If exists, update the record
   b. else
      i. Except android_id, check if a record exists with same data
         - If exists, update existing record with new android_id
      ii. else insert new record
-- End --
*/
import { NextResponse } from "next/server";
import { db } from "@/lib/db";

export async function POST(req) {
  try {
    const data = await req.json();
    const {
      device_id,
      form_code,
      device_name,
      device_model,
      device_android_version,
      device_api_level,
      android_id,
      sim1_phone_no,
      sim1_network,
      sim1_sub_id,
      sim2_phone_no,
      sim2_network,
      sim2_sub_id,
    } = data;

    if (!form_code || !android_id) {
      return NextResponse.json(
        { status: 400, message: "Missing required fields" },
        { status: 400 }
      );
    }

    let processedDeviceId;

    // 1. If device_id exists, update record
    if (device_id) {
      const [existingById] = await db.query(
        `SELECT * FROM devices WHERE id = ?`,
        [device_id]
      );
      if (existingById.length > 0) {
        await db.query(
          `UPDATE devices SET 
            form_code = ?, device_name = ?, device_model = ?,
            device_android_version = ?, device_api_level = ?,
            android_id = ?, sim1_phone_no = ?, sim1_network = ?, sim1_sub_id = ?,
            sim2_phone_no = ?, sim2_network = ?, sim2_sub_id = ?
           WHERE id = ?`,
          [
            form_code,
            device_name,
            device_model,
            device_android_version,
            device_api_level,
            android_id,
            sim1_phone_no,
            sim1_network,
            sim1_sub_id,
            sim2_phone_no,
            sim2_network,
            sim2_sub_id,
            device_id,
          ]
        );

        processedDeviceId = device_id;
        return NextResponse.json(
          { status: 200, message: "Device updated successfully", device_id: processedDeviceId },
          { status: 200 }
        );
      }
    }

    // 2. Check if a record exists with same form_code and android_id
    const [existingByAndroidId] = await db.query(
      `SELECT * FROM devices WHERE form_code = ? AND android_id = ?`,
      [form_code, android_id]
    );

    if (existingByAndroidId.length > 0) {
      await db.query(
        `UPDATE devices SET 
          device_name = ?, device_model = ?,
          device_android_version = ?, device_api_level = ?,
          sim1_phone_no = ?, sim1_network = ?, sim1_sub_id = ?,
          sim2_phone_no = ?, sim2_network = ?, sim2_sub_id = ?
         WHERE android_id = ? AND form_code = ?`,
        [
          device_name,
          device_model,
          device_android_version,
          device_api_level,
          sim1_phone_no,
          sim1_network,
          sim1_sub_id,
          sim2_phone_no,
          sim2_network,
          sim2_sub_id,
          android_id,
          form_code,
        ]
      );

      processedDeviceId = existingByAndroidId[0].id;
      return NextResponse.json(
        { status: 200, message: "Device updated successfully", device_id: processedDeviceId },
        { status: 200 }
      );
    }

    // 3. Check if a record exists with same data except android_id
    const [existingByData] = await db.query(
      `SELECT * FROM devices WHERE
        form_code = ? AND device_name = ? AND device_model = ? AND
        device_android_version = ? AND device_api_level = ? AND
        sim1_phone_no = ? AND sim1_network = ? AND sim1_sub_id = ? AND
        sim2_phone_no = ? AND sim2_network = ? AND sim2_sub_id = ?`,
      [
        form_code,
        device_name,
        device_model,
        device_android_version,
        device_api_level,
        sim1_phone_no,
        sim1_network,
        sim1_sub_id,
        sim2_phone_no,
        sim2_network,
        sim2_sub_id,
      ]
    );

    if (existingByData.length > 0) {
      await db.query(
        `UPDATE devices SET android_id = ? WHERE id = ?`,
        [android_id, existingByData[0].id]
      );

      processedDeviceId = existingByData[0].id;
      return NextResponse.json(
        { status: 200, message: "Device updated with new android_id", device_id: processedDeviceId },
        { status: 200 }
      );
    }

    // 4. Insert new record
    const [result] = await db.query(
      `INSERT INTO devices (
          form_code, device_name, device_model, 
          device_android_version, device_api_level, android_id,
          sim1_phone_no, sim1_network, sim1_sub_id,
          sim2_phone_no, sim2_network, sim2_sub_id
        ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        form_code,
        device_name,
        device_model,
        device_android_version,
        device_api_level,
        android_id,
        sim1_phone_no,
        sim1_network,
        sim1_sub_id,
        sim2_phone_no,
        sim2_network,
        sim2_sub_id,
      ]
    );

    processedDeviceId = result.insertId;

    return NextResponse.json(
      { status: 200, message: "Device registered successfully", device_id: processedDeviceId },
      { status: 200 }
    );
  } catch (err) {
    console.error("Error inserting/updating device:", err);
    return NextResponse.json(
      { status: 500, message: "Server error", error: err.message },
      { status: 500 }
    );
  }
}
