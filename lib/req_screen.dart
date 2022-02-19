import 'package:flutter/material.dart';
class ReqScreen extends StatelessWidget {
  String id;
  // String name;
  // String text;
  ReqScreen(this.id,
      // this.name,
      // this.text,
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(
              "This is req is from ${id} "),
        ),
      ),

    );
  }
}
