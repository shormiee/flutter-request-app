import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/screens/auth-screen.dart';
import 'package:flutter_chatapp/widgets/new-request.dart';


class RequestCard extends StatelessWidget {
// final QuerySnapshot snapshot;
// final int index;
  final user = FirebaseAuth.instance.currentUser;
  RequestCard(this.request,
    this.usid,
      // this.snapshot, this.index,
    // this.rid,
      // bool bool,

      );
  final String request;
  final String usid;
  // final String rid;

  @override
  Widget build(BuildContext context) {
    // var snapshotData = snapshot.docs[index].data;
    // var docId = snapshot.docs[index].docsID;
    return Row(

      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            color: Colors.grey[200],
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),

              //topRight: Radius.circular(12),
              topLeft: Radius.circular(12),
            ),
          ),
          width: 200,

          margin: EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 16),

          // padding: const EdgeInsets.symmetric(
          //     vertical: 15,
          //     horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                //mainAxisSize: MainAxisSize.max,
                 mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                      future: FirebaseFirestore.instance.collection('users').doc(usid).get(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator(),);
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 5, bottom: 8.0,),
                          child: Text(
                            snapshot.data['name'],
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17,),
                          ),
                        );
                      }
                  ),
                  Text( 'requested for a'),

                 Padding(
                   padding: const EdgeInsets.only(top: 5.0, bottom: 8,),
                   child: Text(
                        request,  style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                         fontStyle: FontStyle.normal,
                      ),

                      ),
                 ),

                ],
              ),
              // Column(
              //   children: [
              //     IconButton(
              //       icon: Icon(Icons.delete_forever_outlined),
              //     color: Colors.deepPurpleAccent,
              //     tooltip: 'delete',
              //
              //       onPressed: ()
              //       {
              //
              //         var newRequest;
              //        FirebaseFirestore.instance.collection('request').doc(newRequest.id).delete();
              //         // deleteRequest(id),
              //       },
              //     ),
              //   ],
              // ),
            ],
          ),

        ),
      ],
    );
  }
}
// class  deleteReq() async {
//   String id = await FirebaseFirestore.instance.collection('request').id;
//   //print("token is :: $token");
//   if(FirebaseAuth.instance.currentUser==null){
//     return '';
//   }
//   await FirebaseFirestore.instance.collection('users')
//       .doc(FirebaseAuth.instance.currentUser.uid).update({"token":token});
//
// }

