"use client";
import { useEffect, useState } from "react";
import useUser from "../useUser";

export default function AccountExpiredInfo() {
  const [expiredAt, setExpiredAt] = useState(null);
  const [timeLeft, setTimeLeft] = useState(null);
  const user = useUser();

  // Fetch expiration date from user
  useEffect(() => {
    if (user?.account_expired_at) {
      setExpiredAt(new Date(user.account_expired_at));
    }
    // console.log("User data in AccountExpiredInfo: Called");
  }, [user]);

  // Calculate time left dynamically
  const calculateTimeLeft = (expiryDate) => {
    const now = new Date();
    const difference = expiryDate - now;

    if (difference <= 0) return null; // expired already

    const days = Math.floor(difference / (1000 * 60 * 60 * 24));
    const hours = Math.floor((difference % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
    const minutes = Math.floor((difference % (1000 * 60 * 60)) / (1000 * 60));
    const seconds = Math.floor((difference % (1000 * 60)) / 1000);

    return { days, hours, minutes, seconds };
  };

  // Update countdown every second — stop when expired
  useEffect(() => {
    if (!expiredAt) return;

    const updateTimer = () => {
      const remaining = calculateTimeLeft(expiredAt);
      setTimeLeft(remaining);
      if (!remaining) {
        clearInterval(timer); // stop when expired
      }
    };

    const timer = setInterval(updateTimer, 1000);
    updateTimer(); // run immediately once

    return () => clearInterval(timer);
  }, [expiredAt]);

  if (!expiredAt) return null;

  // Expired
  if (!timeLeft)
    return (
      <div
        className="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative text-sm sm:text-base"
        role="alert"
      >
        <strong className="font-bold">Account Expired! </strong>
        <span className="block sm:inline">
          Your account expired on {expiredAt.toLocaleString()}. Please contact admin.
        </span>
      </div>
    );

  // Active countdown
  return (
    <div
      className="bg-yellow-100 border border-yellow-400 text-yellow-800 px-4 py-3 rounded relative text-sm sm:text-base"
      role="alert"
    >
      <strong>Account Expires In : </strong>
      <span className="block sm:inline">
        {timeLeft.days > 0 && `${timeLeft.days}d `}
        {timeLeft.hours > 0 && `${timeLeft.hours}h `}
        {timeLeft.minutes}m {timeLeft.seconds}s
      </span>
    </div>
  );
}
