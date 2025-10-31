import { NextResponse } from "next/server";
import { db } from "@/lib/db";

export async function POST(req) {
  try {
    const data = await req.json();
    const {
      app_version = null,
      package_name = null,
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

    // 1️⃣ If device_id exists → update by ID
    if (device_id) {
      const [existingById] = await db.query(`SELECT * FROM devices WHERE id = ?`, [device_id]);

      if (existingById.length > 0) {
        const [result] = await db.query(
          `UPDATE devices SET 
            form_code=?, device_name=?, device_model=?,
            device_android_version=?, device_api_level=?,
            android_id=?, sim1_phone_no=?, sim1_network=?, sim1_sub_id=?,
            sim2_phone_no=?, sim2_network=?, sim2_sub_id=?, app_version=?, package_name=?
          WHERE id=?`,
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
            app_version,
            package_name,
            device_id,
          ]
        );

        processedDeviceId = device_id;

        const newData = {
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
          app_version,
          package_name,
        };
        const oldData = existingById[0];
        const changedFields = Object.keys(newData).filter(
          (key) => String(oldData[key]) !== String(newData[key])
        );

        console.log("🔄 Device updated by ID:", processedDeviceId);
        console.log("   🔹 Changed Columns:", changedFields);

        return NextResponse.json(
          {
            status: 200,
            message: "Device updated successfully",
            device_id: processedDeviceId,
            changed_columns: changedFields,
          },
          { status: 200 }
        );
      }
    }

    // 2️⃣ Check by form_code + android_id
    const [existingByAndroidId] = await db.query(
      `SELECT * FROM devices WHERE form_code=? AND android_id=?`,
      [form_code, android_id]
    );

    if (existingByAndroidId.length > 0) {
      const [result] = await db.query(
        `UPDATE devices SET 
          device_name=?, device_model=?,
          device_android_version=?, device_api_level=?,
          sim1_phone_no=?, sim1_network=?, sim1_sub_id=?,
          sim2_phone_no=?, sim2_network=?, sim2_sub_id=?, 
          app_version=?, package_name=?
         WHERE form_code=? AND android_id=?`,
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
          app_version,
          package_name,
          form_code,
          android_id,
        ]
      );

      processedDeviceId = existingByAndroidId[0].id;

      const newData = {
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
        app_version,
        package_name,
      };
      const oldData = existingByAndroidId[0];
      const changedFields = Object.keys(newData).filter(
        (key) => String(oldData[key]) !== String(newData[key])
      );

      console.log("🔄 Device updated by form_code & android_id:", processedDeviceId);
      console.log("   🔹 Changed Columns:", changedFields);

      return NextResponse.json(
        {
          status: 200,
          message: "Device updated successfully",
          device_id: processedDeviceId,
          changed_columns: changedFields,
        },
        { status: 200 }
      );
    }

    // 3️⃣ Insert new record
    const [result] = await db.query(
      `INSERT INTO devices (
        form_code, device_name, device_model,
        device_android_version, device_api_level, android_id,
        sim1_phone_no, sim1_network, sim1_sub_id,
        sim2_phone_no, sim2_network, sim2_sub_id,
        app_version, package_name
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
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
        app_version,
        package_name,
      ]
    );

    processedDeviceId = result.insertId;
    console.log("🆕 Inserted new device:", processedDeviceId, form_code, android_id);

    // ✅ Always send to clients and admin
    sendMessageToClients(form_code, "new_device_insert", `New device registered: ${device_name}`, true);
    sendMessageToAdmin("new_device_insert", `New device registered: ${device_name}`, true);

    return NextResponse.json(
      {
        status: 200,
        message: "Device registered successfully",
        device_id: processedDeviceId,
      },
      { status: 200 }
    );
  } catch (err) {
    console.error("❌ Error inserting/updating device:", err);
    return NextResponse.json(
      { status: 500, message: "Server error", error: err.message },
      { status: 500 }
    );
  }
}

/* ---------------- SOCKET HELPERS ---------------- */

function sendMessageToClients(form_code, event_name, message, success = false) {
  if (!global.io) {
    console.warn("⚠️ Socket.IO instance not found!");
    return;
  }

  const clientSockets = [...global.io.sockets.sockets.values()].filter(
    (s) =>
      s.handshake.query.client === "web" &&
      s.handshake.query.form_code === form_code
  );

  console.log(`📡 Sending "${event_name}" to ${clientSockets.length} web clients (form_code: ${form_code})`);
  
  clientSockets.forEach((clientSocket) => {
    clientSocket.emit(event_name, {
      success,
      message,
    });
  });
}

function sendMessageToAdmin(event_name, message, success = false) {
  if (!global.io) {
    console.warn("⚠️ Socket.IO instance not found!");
    return;
  }

  const adminSockets = [...global.io.sockets.sockets.values()].filter(
    (s) =>
      s.handshake.query.client === "web" &&
      s.handshake.query.role === "admin"
  );

  console.log(`👑 Sending "${event_name}" to ${adminSockets.length} admin clients`);
  
  adminSockets.forEach((adminSocket) => {
    adminSocket.emit(event_name, {
      success,
      message,
    });
  });
}
