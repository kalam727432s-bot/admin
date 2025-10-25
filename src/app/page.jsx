import { redirect } from "next/navigation";

export const metadata = {
  title: "Forwarder Home",
};

export default function HomePage() {
  redirect("/login");
  return <h1>Hello, This is the Home Page.</h1>;
}
