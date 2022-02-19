// import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chatapp/screens/auth-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/widgets/new-request.dart';


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.teal[400],
        title: Center(child: Text(' Whats on your mind?' ),),

        actions: [
          DropdownButton(icon: Icon(Icons.more_vert,
            color: Theme.of(context).primaryIconTheme.color,

          ),
            items: [
              DropdownMenuItem(child: Container(child: Row(
                children: [
                  Icon(
                      Icons.exit_to_app,
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
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            // Container(child: Text(' Make a request ', style: TextStyle(fontSize: 22),)),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 100, bottom: 50,),
              child: Container(
                  child: NewRequest(),
              ),
            ),


          ],
        ),
      ),
    );

  }
}
