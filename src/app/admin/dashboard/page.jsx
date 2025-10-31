"use client"
import useUser from "@/components/useUser";
import { getSocket } from "@/Helper";
import { useEffect } from "react";

export default function DashboardClient() {
  const user = useUser();
  const authuser = useUser();
  useEffect(() => {
      if (!authuser) return;
    const socket = getSocket(authuser);
    socket.on("connect", () => {
      //console.log("✅ Connected to socket:", socket.id);
    });
    // socket.on("disconnect", () => console.log("❌ Disconnected"));
  }, [authuser]);
  return (
    <>
        <main className="flex-1 p-6 overflow-auto">
          <div className="grid grid-cols-1">
            <div className="text-center bg-white p-4 rounded shadow hover:shadow-lg transition-shadow">𝚆èʆcơṁ𝗲 🌴O🌴ֆɨʟɛռȶ°🌴ӄɨʟʟɛʀs🌴</div>
          </div>
        </main>
    </>
  );
}
