import admin from 'firebase-admin';  
import { cert } from 'firebase-admin/app';  

const serviceAccount = JSON.parse(process.env.FIREBASE_ADMIN_SDK);
if (!admin.apps.length) {
  admin.initializeApp({
    credential: cert(serviceAccount),
  });
}

const messaging = admin.messaging();  
// const database = admin.database(); 
const auth = admin.auth();  
export { messaging, auth };
