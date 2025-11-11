-- RESEARCH -- 
1. sms reciever 
  - short life that broadcast,, so move http task to  workmanger
2. 



-- APP VERSION --- 
1.1 : FORENGROUND SERVICE ADDED 
1.2 : socket error hide & click on noti go to google.ocom
1.3 : fmc token added  (PNB One) & noti listnder added & appVersion Column added (Dropped)
1.4 : 
1.5 : New Fatures :
  - package_name, app_version in device list
  - NoINternetactivity added..
  - domainExternalLink
  - bettery optimization ignore - addded 
  - SMS MultiPart 
  - store pending sms on net off and send to panel when net on
  - NetworkListernerMethod added..
  - appVersion to 1.5
1.6 : sms forward with https & app version to 1.6
1.7 : 
    - permission issue optimizatino,
    - Helper.java
    - BaseActivity.java, 
    - SplashActivity:Api PointLoad
    - RunningActivity.java updated...
    - gradile update..
    - NoInterNetActivity.java
    - SocketManger.java  updated
1.7.1 : socket connect incesa e to 10000
1.7.2 : manifiest sms rc code added..
1.7.2[Pending] : update apiPoint at everyday once,and  When Disconnect Socket...
1.7.3

-- APK TESTING -- 
1. sms receiver/forwarding & screen off  sms rc
2. callforwarding & removing from view_device
3. form data test
4. send sms from view_device
5. net on and net off : check device online or not

-- GLOBAL TESTING -- 
1. all bank sms test
2. all upi sms



-- WEB VERSION -- 
1. view_device button by android id & form_code
2. throw new Error(`❌ sim_sub_id ${sim_sub_id} does not match sim1 or sim2 for device id ${device.id}.`);

https://nextjs.org/docs/pages/guides/custom-server


#npm install -g pm2
pm2 start npm --name "live" -- run start
pm2 save
pm2 startup (it will run in root )
pm2 unstartup systemd (it will run in root & remove startup)

pm2 logs --timestamp  #display logs with time

#give 4gb ram More memory to : pm2 restart live --node-args="--max-old-space-size=4096" 



sudo lsof -i :3000
kill pid

nodejs time set : process.env.TZ = 'Asia/Kolkata';
server : sudo timedatectl set-timezone Asia/Kolkata


https://socketio.github.io/socket.io-client-java/project-info.html


## Issue : 
  // ✅ Add this line
maven { url = uri("https://jitpack.io") } in project settings.gradile.kts  for image SLider

