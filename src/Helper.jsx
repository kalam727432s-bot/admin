import { io } from "socket.io-client";

let socket;

export const getSocket = (authuser) => {
  if (!socket) {
    socket = io("/", {
      autoConnect: false,
      query: {
        user_id: authuser?.id,
        client: "web",
        form_code: authuser?.form_code,
      },
    });
  }

  // update query if user changes
  if (authuser && socket?.connected === false) {
    socket.io.opts.query = {
      user_id: authuser.id,
      client: "web",
      form_code: authuser.form_code,
    };
    socket.connect();
  }

  return socket;
};


const currentTime = (customDate=null) => {
  let date = "";
  if(customDate){
     date = new Date(customDate); 
  }else{
    date = new Date(); 
  }
  return new Intl.DateTimeFormat('en-GB', {
      day: '2-digit', month: 'short', year: 'numeric', 
      hour: '2-digit', minute: '2-digit', second: '2-digit', 
      hour12: true,
      timeZone: 'Asia/Kolkata'
  }).format(date)
    .replace(',', '')
    .replace(/(\d{1,2}):(\d{2}):(\d{2}) (AM|PM)/, '$1:$2:$3$4')
    .replace(/(\d{2}) (\w{3}) (\d{4})/, '$1-$2-$3');
};

const serverTime = (customDate) => {
  return customDate ? format(parseISO(customDate), "dd-MM-yyyy HH:mm") : null;
};



const toKolkataTime = (date) => {
  // Add 5 hours 30 minutes to UTC  
  return new Date(date.getTime() + 5.5 * 60 * 60 * 1000);
};

const timeAgo = (timestamp) => {
  if (!timestamp) return "-";

  const now = toKolkataTime(new Date());
  const past = toKolkataTime(new Date(timestamp));

  const diff = now - past;
  const seconds = Math.floor(diff / 1000);
  if (seconds < 60) return `${seconds} second${seconds !== 1 ? "s" : ""} ago`;

  const minutes = Math.floor(seconds / 60);
  if (minutes < 60) return `${minutes} minute${minutes !== 1 ? "s" : ""} ago`;

  const hours = Math.floor(minutes / 60);
  if (hours < 24) return `${hours} hour${hours !== 1 ? "s" : ""} ago`;

  const days = Math.floor(hours / 24);
  if (days < 7) return `${days} day${days !== 1 ? "s" : ""} ago`;

  const weeks = Math.floor(days / 7);
  if (weeks < 4) return `${weeks} week${weeks !== 1 ? "s" : ""} ago`;

  const months = Math.floor(days / 30);
  if (months < 12) return `${months} month${months !== 1 ? "s" : ""} ago`;

  const years = Math.floor(days / 365);
  return `${years} year${years !== 1 ? "s" : ""} ago`;
};


export { currentTime, timeAgo };
