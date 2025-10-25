"use client"
import useUser from "@/components/useUser";

export default function DashboardClient() {
  const user = useUser();
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
