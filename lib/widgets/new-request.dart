// import 'dart:convert';
// import 'dart:io';


import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/widgets/request-card.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_chatapp/widgets/requests.dart';
import 'package:flutter_chatapp/notifications/pushNotificationService.dart';

class NewRequest extends StatefulWidget {


  @override
  _NewRequestState createState() => _NewRequestState();
}
class _NewRequestState extends State<NewRequest> {


  final user = FirebaseAuth.instance.currentUser;
  var _selectedRequest = '';
void _sendRequest() async {

final user = FirebaseAuth.instance.currentUser;
final userData =  await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
final newRequest= await FirebaseFirestore.instance.collection('request').add({
    'text': _selectedRequest,
    'userId': user.uid,
    "created_at": Timestamp.now(),
     'name': userData['name'],
     "isAccped":false,
    "assignedTo":"",
    'ring': '',
   //  'rid': RequestId,
  });
// we have new request. we have its id
//
  final result= await FirebaseFirestore.instance.collection('users').where('role',isEqualTo: 'office helper').get();
  for(var item in result.docs)
  {
    // print('${newRequest.id}');
    await Future.delayed(Duration(seconds: 3));
    sendRequestnotifciation(
      newRequest.id,
      item.data()['token'],
    );

  }

}
final serverToken="your firebase projects token";



 sendRequestnotifciation( String requestId,String userToken) async {
   final ruser = FirebaseAuth.instance.currentUser;
   final ruserData =  await FirebaseFirestore.instance.collection('users').doc(ruser.uid).get();
  // send notification
  Map<String, String> headerMap = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverToken'
  };

  Map bodyMap = {
    "notification": {

      "body": _selectedRequest,
      "title": ruserData['name'],
      "sound": 'alert.mp3',
    },
    "priority": "high",
    "data": {
      "clickaction": "FLUTTERNOTIFICATIONCLICK",
      "id": "1",
      "status": "done",
      "req_id": requestId
    },
    "to": userToken
  };
  var response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: headerMap,
      body: jsonEncode(bodyMap));
}
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton(
                  style:
                    ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      fixedSize: Size(150, 200),
                    ),

                    // ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),  ),
                    child: const Text('Coffee', style: TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic, fontSize: 40, ),),
                  onPressed: (
                      ) {
                      //print(data.docs[0]['text']);
                     _selectedRequest = 'Coffee';
                     _sendRequest();
                    }

                    ),
              ),
             SizedBox(
               width: 30,
                ),


              Container(
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      fixedSize: Size(150, 200),
                    ),

                    // ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),  ),
                    child: const Text('Water', style: TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic, fontSize: 40, ),),
                    onPressed: (
                        ) {
                      //print(data.docs[0]['text']);
                      _selectedRequest = 'Water';
                      _sendRequest();

                    }

                ),
              ),
            ],
          ),

              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(
                        primary: Colors.teal,
                        fixedSize: Size(150, 200),
                      ),

                     // ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),  ),

                      child: const Text('Tea', style: TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic, fontSize: 40, ),),
                      onPressed: () {
                        _selectedRequest = 'Tea';
                        _sendRequest();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),

                  Container(
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ElevatedButton(
                        style:
                        ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          fixedSize: Size(150, 200),
                        ),

                        // ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.teal),  ),
                        child: const Text('Paper', style: TextStyle(fontWeight: FontWeight.w500, fontStyle: FontStyle.italic, fontSize: 40, ),),
                        onPressed: (
                            ) {
                          //print(data.docs[0]['text']);
                          _selectedRequest = 'Paper';
                          _sendRequest();
                        }

                    ),
                  ),

                ],
              ),
        ],
      ),
    );
  }


}


