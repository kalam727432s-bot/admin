import { NextResponse } from "next/server";
import { getAuthenticatedUser } from "@/lib/auth";
import { db } from "@/lib/db";

export async function PUT(req) {
  try {
    const user = await getAuthenticatedUser();
    if (!user) {
      return NextResponse.json({ error: "Unauthorized", data:user}, { status: 401 });
    }
    if(user.role=="admin"){
      return NextResponse.json({ error: "Admin cannot set SMS Forwarding Number" }, { status: 401 });
    }

    if(!user.form_code){
      return NextResponse.json({ error: "Please contact admin to set Form Code" }, { status: 401 });
    }


    if(user.sms_forwarding_to_number_status !=="Enabled"){
      return NextResponse.json({ user:user, error: "SMS forwarding is " + user.sms_forwarding_to_number_status }, { status: 401 });
    }
    const { sms_forwarding_to_number } = await req.json();

    if (!sms_forwarding_to_number) {
      return NextResponse.json({ error: "SMS Forwarding Number is required" }, { status: 400 });
    }

    let new_number = sms_forwarding_to_number;
    if(sms_forwarding_to_number=="+91"){
      new_number = "";
    }

    // Update the user SMS Forwarding Number
    await db.query(
      "UPDATE users SET sms_forwarding_to_number = ? WHERE id = ?",
      [new_number, user.id]
    );

    return NextResponse.json({ message: "SMS Forwarding Number updated successfully ✅" });
  } catch (err) {
    console.error("SMS Forwarding Number update error:", err);
    return NextResponse.json({ error: "Internal Server Error" }, { status: 500 });
  }
}


