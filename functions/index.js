const functions = require("firebase-functions");
const admin = require('firebase-admin');
exports.myFunction = functions.firestore
  .document('request/{req}')
  .onCreate((change, context) => {
  console.log(change.after.data());
// return admin.messaging()
//  .sendToTopic('request',
//  {
//  notification: {
//  title: snapshot.data().name,
//   body: snapshot.data().text,
//   clickAction: 'FLUTTER_NOTIFICATION_CLICK',
//  },
//   });
   });