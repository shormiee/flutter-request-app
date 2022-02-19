// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_chatapp/widgets/auth_form.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class AuthScreen extends StatefulWidget {
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }
//
// class _AuthScreenState extends State<AuthScreen> {
//   final _auth = FirebaseAuth.instance;
//
//   var _isLoading = false;
//   void _submitAuthForm(
//       String email,
//       String password,
//       String username,
//       bool isLogin,
//       BuildContext ctx,
//       )
//   async {
//     UserCredential authResult;
// try {
//   setState(() {
//     _isLoading = true;
//   });
// if(isLogin) {
//   authResult = await _auth.signInWithEmailAndPassword(
//     email: email,
//     password: password,
//   );
// } else {
//   authResult = await _auth.createUserWithEmailAndPassword(
//     email: email,
//     password: password,
//   );
//   await FirebaseFirestore.instance.collection('users')
//       .doc(authResult.user.uid).set({
//   'username': username,
//   'email': email,
//   });
// }
// }
//  on PlatformException catch (err) {
//   var message = 'an error occurred';
//  if(err.message != null)
//  {
//    message = err.message;
//  }
//  Scaffold.of(ctx).showSnackBar(
//    SnackBar( content: Text(message),
//      backgroundColor: Theme.of(ctx).errorColor,),
//
//  );
//  setState(() {
//    _isLoading = false;
//  });
//
//  }
//  catch (err) {
//   print(err);
//   setState(() {
//     _isLoading = false;
//   });
//  }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).primaryColor,
//       body: AuthForm(_submitAuthForm,
//         _isLoading,
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:package_info/package_info.dart';

import 'package:device_info/device_info.dart';

// const cappId = "my app id";
class AuthHelper {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static signInWithEmail({String name,
    String email,
    String password,


  })

  async {
    final res = await _auth.signInWithEmailAndPassword( email: email, password: password);
    final User user = res.user;
    return user;
  }

  static signupWithEmail({
    String name,
    String email,
    String password
  }) async {
    final res = await _auth.createUserWithEmailAndPassword(
         email: email, password: password);
    final User user = res.user;
    return user;
  }
  // the place where you are saving that user oboject

  static signInWithGoogle() async {
    GoogleSignIn googleSignIn = GoogleSignIn();
    final acc = await googleSignIn.signIn();
    final auth = await acc.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: auth.accessToken, idToken: auth.idToken);
    final res = await _auth.signInWithCredential(credential);
    return res.user;
  }

  static logOut() {
    GoogleSignIn().signOut();
    return _auth.signOut();
  }
}
class UserHelper {
  static FirebaseFirestore _db = FirebaseFirestore.instance;

static saveUser(User user) async {

  // var tokenId = status.userId;


    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    int buildNumber = int.parse(packageInfo.buildNumber);

    Map<String, dynamic> userData = {
      "name": user.displayName,
      "email": user.email,
      "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
      "created_at": user.metadata.creationTime.millisecondsSinceEpoch,
      "role": user,
      //"tokenId": tokenId,
      "build_number": buildNumber,


    };
    final userRef = _db.collection("users").doc(user.uid);
    if ((await userRef.get()).exists) {
      await userRef.update({
        "last_login": user.metadata.lastSignInTime.millisecondsSinceEpoch,
        "build_number": buildNumber,

      });
    } else {

      await _db.collection("users").doc(user.uid).set({
        'email': user.email,
        //"tokenId": tokenId,
      });
    }
    await _saveDevice(user);


  }


  static _saveDevice(User user) async {
    DeviceInfoPlugin devicePlugin = DeviceInfoPlugin();
    String deviceId;
    Map<String, dynamic> deviceData;
    if (Platform.isAndroid) {
      final deviceInfo = await devicePlugin.androidInfo;
      deviceId = deviceInfo.androidId;
      deviceData = {
        "os_version": deviceInfo.version.sdkInt.toString(),
        "platform": 'android',
        "model": deviceInfo.model,
        "device": deviceInfo.device,
      };
    }
    if (Platform.isIOS) {
      final deviceInfo = await devicePlugin.iosInfo;
      deviceId = deviceInfo.identifierForVendor;
      deviceData = {
        "os_version": deviceInfo.systemVersion,
        "device": deviceInfo.name,
        "model": deviceInfo.utsname.machine,
        "platform": 'ios',
      };
    }
    final nowMS = DateTime.now().toUtc().millisecondsSinceEpoch;
    final deviceRef = _db
        .collection("users")
        .doc(user.uid)
        .collection("devices")
        .doc(deviceId);
    if ((await deviceRef.get()).exists) {
      await deviceRef.update({
        "updated_at": nowMS,
        "uninstalled": false,
      });
    } else {
      await deviceRef.set({
        "updated_at": nowMS,
        "uninstalled": false,
        "id": deviceId,
        "created_at": nowMS,
        "device_info": deviceData,

      });
    }
  }
}