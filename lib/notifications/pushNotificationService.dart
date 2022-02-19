import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_chatapp/main.dart';
import 'package:flutter_chatapp/widgets/new-request.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_chatapp/widgets/requests.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../screens/admin_home.dart';

class PushNotifcationService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  static BuildContext context;

  get flutterLocalNotificationsPlugin => null;

  goToRequestAceeptingScreen(BuildContext context, String reqId,){
    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
       // ReqScreen(reqId)
    OfficeHelper(),
    ));
  }
  Future initialize() async {
    //final sound =  'alert.mp3';
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // RemoteNotification notification = message.notification;
      // AndroidNotification android = message.notification?.android;
      // if(notification != null && android != null) {
      //
      //   // flutterLocalNotificationsPlugin.show(
      //   //   notification.hashCode,
      //   //     notification.title,
      //   //     notification.body,
      //   //
      //   //     NotificationDetails(
      //   //       android: AndroidNotificationDetails(channel.id,
      //   //           channel.name,
      //   //           color: Colors.deepPurpleAccent,
      //   //           playSound: true,
      //   //           sound: RawResourceAndroidNotificationSound(sound.split('.').first),
      //   //         enableVibration: true,
      //   //
      //   //     ),
      //   //       iOS: IOSNotificationDetails(
      //   //         sound: sound,
      //   //       ),
      //   //     )
      //   // );
      // }
      goToRequestAceeptingScreen( context,getRequestId(message),);
     // print('Got a message whilst in the foreground!');
      //print('Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification.title}');
      }

    }
    );

    // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((message) {

      goToRequestAceeptingScreen( context,getRequestId(message));
      if (message.notification != null) {
        print(
            'Message null contained a notification: ${message.notification.title}');
      }
    });
  }
  Future<String> getToken() async {
    String token = await firebaseMessaging.getToken();
    //print("token is :: $token");
    if(FirebaseAuth.instance.currentUser==null){
      return '';
    }
   await FirebaseFirestore.instance.collection('users')
.doc(FirebaseAuth.instance.currentUser.uid).update({"token":token});
    firebaseMessaging.subscribeToTopic('users');
    firebaseMessaging.subscribeToTopic('users');
  }

  static String getRequestId(message) {
    String RequestId = '';
    if (Platform.isAndroid) {
      RequestId = message.data['req_id'];
    } else {
      RequestId = message['req_id'];
    }
    return RequestId;
  }


}

