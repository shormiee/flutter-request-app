import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/notifications/pushNotificationService.dart';
import 'package:flutter_chatapp/screens/alluser.dart';
import 'package:flutter_chatapp/screens/auth-screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_chatapp/screens/home.dart';
import 'package:flutter_chatapp/screens/login.dart';
import 'package:flutter_chatapp/screens/admin_home.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';



  // const AndroidNotificationChannel channel = AndroidNotificationChannel(
  //   'channel id 1',
  //   'channel name',
  //   importance: Importance.high,
  //   playSound: true,
  //   // sound: RawResourceAndroidNotificationSound(sound),
  //   enableLights: true,
  //   enableVibration: true,
  //
  // );

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();




//

//
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//     'high_importance_channel', // id
//     'High Importance Notifications', // title// description
//     importance: Importance.high,
//     playSound: true);
//


// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   print('A message just showed up :  ${message.messageId}');
// }

// void initState() {
//   super.initState();
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //new add
// FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);



// await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);
//
//  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true,
//  badge: true,
//  sound: true,);


  runApp(MyApp());
}



class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   permissionStatusFuture = getCheckNotificationPermStatus();
  //   WidgetsBinding.instance.addObserver(this);
  // }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PushNotifcationService.context=context;
    PushNotifcationService().initialize();
    PushNotifcationService().getToken();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            UserHelper.saveUser(snapshot.data);
            return StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance.collection("users").doc(
                  snapshot.data.uid).snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  final userDoc = snapshot.data;
                  final user = userDoc;
                  if (user['role'] == 'office helper') {
                    return OfficeHelper();
                  } else {
                    return HomePage();
                  }
                }
                else {
                  return
                    // Material(child: Center(child: CircularProgressIndicator(),),);
              AllUser();

                }
              },
            );
          }
          return LoginPage();
        }
    );
  }
}
