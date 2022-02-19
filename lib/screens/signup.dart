import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chatapp/screens/auth-screen.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
 //   _nameController = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");
    _confirmPasswordController = TextEditingController(text: "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            children: <Widget>[
              const SizedBox(height: 100.0),
              Text(
                "Sign Up",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),

              // TextField(
              //   //controller: _nameController,
              //   decoration: InputDecoration(hintText: "Enter name"),
              // ),
              const SizedBox(height: 20.0),

              TextField(
                controller: _emailController,
                decoration: InputDecoration(hintText: "Enter email"),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "Enter password"),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(hintText: "Confirm password"),
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                child: Text("Signup"),
                onPressed: () async {
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty
                      // ||_nameController.text.isEmpty
                  ) {
                    print("Email and password cannot be empty");
                    return;
                  }
                  if (_confirmPasswordController.text.isEmpty ||
                      _passwordController.text !=
                          _confirmPasswordController.text) {
                    print("confirm password does not match");
                    return;
                  }
                  try {
                    final user = await AuthHelper.signupWithEmail(
                      // name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text);

                    if (user != null) {
                      print("signup successful");
                      Navigator.pop(context);
                    }
                  } catch (e) {
                    print(e);
                  }
                },
              ),

              ElevatedButton.icon(
                // child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // children: [
                icon: Image(image:  AssetImage('assets/g-icon.png',
                ), height: 30,),
                label: Text("Continue with Google"),
                // ],
                // ),
                onPressed: () async {
                  try {
                    await AuthHelper.signInWithGoogle();
                  } catch (e) {
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}