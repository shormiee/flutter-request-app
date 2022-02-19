//import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chatapp/widgets/request-card.dart';

class Requests extends StatelessWidget {
  // deleteReq( String id) {
  //   print('requests $id');
  // }
  @override

  Widget build(BuildContext context) {

    return FutureBuilder(
        future: Future.value (FirebaseAuth.instance.currentUser),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          var today = new DateTime.now();
          today = new DateTime(today.year, today.month, today.day);
          return StreamBuilder(
              stream: FirebaseFirestore.instance.collection
                ('request').where('created_at',isGreaterThanOrEqualTo: today).orderBy('created_at', descending: true).snapshots(),
              builder: (ctx, requestSnapshot) {
                if (requestSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
               final requestDocs = requestSnapshot.data.docs;
               // return new ListView(),
               // print(document.id)
                return
                  // Flexible(
                 ListView.builder(
                    reverse: false,
                    itemCount: requestDocs.length,

                    itemBuilder: (ctx, index) {
                      //final request = requestDocs[index];
                      final requestDocs = requestSnapshot.data.docs;
                      return
                        // Text( requestDocs[index]['text'], );

                        RequestCard(
                          requestDocs[index]['text'],
                    //     request['text'],
                    //    request['name'],
                            requestDocs[index]['userId'],
                         // requestDocs[index]['id'],
                  //requestDocs['userId'] == futureSnapshot.data.uid,
                     // request['tokenId'],
                      );

                    },

                  );

                // );
              }
          );
        });
  }
}
