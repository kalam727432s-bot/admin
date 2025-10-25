import { NextResponse } from "next/server";
import { db } from "@/lib/db";
import { getAuthenticatedUser } from "@/lib/auth";

// DELETE /api/sms-forwarding/:id → delete 
export async function DELETE(req, { params }) {
  const { id } = params;
  const { password } = await req.json();
  const authUser = await getAuthenticatedUser();
  if (!authUser) return NextResponse.json({ error: "Unauthorized" }, { status: 401 });
  // console.log("Authenticated user:", authUser.role, authUser.form_code);

  if(authUser.role !== "admin") {
    if(!password) {
      return NextResponse.json({ error: "Password is required" }, { status: 400 });
    }
    if(authUser.delete_password!==password){
      return NextResponse.json({ error: "Invalid password" }, { status: 403 });
    }
    
    // has permission to delete & get sms_forwarding form_code
    const [formData] = await db.query("SELECT form_code FROM sms_forwarding WHERE id = ?", [id]);
    if (formData.length === 0) {
      return NextResponse.json({ error: "Id not found" }, { status: 404 });
    }

    const server_form_data_form_code = formData[0].form_code;
    if(server_form_data_form_code !== authUser.form_code) {
      return NextResponse.json({ error: "You do not have permission to delete this data." }, { status: 403 });
    }
  }
  
  await db.query("DELETE FROM sms_forwarding WHERE id = ?", [id]);
  return NextResponse.json({ message: "SMS forwarding entry deleted successfully" });
}
