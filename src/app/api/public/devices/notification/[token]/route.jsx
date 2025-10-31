export const runtime = "nodejs";

import { NextResponse } from "next/server";
import { getAuthenticatedUser } from "@/lib/auth";
import { messaging } from "@/lib/firebase-admin";

export async function GET(req, { params }) {
  const { token } = await params;

  const authUser = await getAuthenticatedUser();
  if (!authUser)
    return NextResponse.json({ error: "Unauthorized" }, { status: 401 });

  // if (authUser.role !== "admin")
  //   return NextResponse.json({ error: "Forbidden" }, { status: 403 });

  try {
    const message = {
    token,
    android: {
      priority: "high",
    },
    notification: {
        title: `Silent Killer Alert!`,
        body: "Your device has triggered a notification.",
    },
    data: {
      action: "start_service",
      some_value: "hello world",
    },
  };

    const response = await messaging.send(message);
    console.log("Successfully sent message:", response);

    return NextResponse.json({ success: true, response });
  } catch (error) {
    console.error("Error sending message:", error);
    return NextResponse.json({ error: "Failed to send message" }, { status: 500 });
  }
}
