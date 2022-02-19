import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_chatapp/notifications/pushNotificationService.dart';
import 'package:flutter_chatapp/screens/auth-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/widgets/requests.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/request-card.dart';




class  OfficeHelper extends StatefulWidget {
  @override
  State< OfficeHelper> createState() => _OfficeHelperState();
}

class _OfficeHelperState extends State<OfficeHelper> {
  final firebaseMessaging = FirebaseMessaging.instance;
  @override
  void initState() {
    super.initState();
  }
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        title: Text('Your Task List'),
        //toolbarHeight: 150,
        actions: [
          DropdownButton(icon: Icon(Icons.more_vert,
            color: Theme.of(context).primaryIconTheme.color,

          ),
            items: [
              DropdownMenuItem(child:
              Container(
                child: Row(
                children: [
                  Icon(
                      Icons.exit_to_app
                  ),
                  SizedBox(width: 8,),
                  Text('Logout'),
                ],
              ),

              ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                AuthHelper.logOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[
           Expanded(child: Requests(),
           ),

          ],

        ),
      ),
    );
  }
}