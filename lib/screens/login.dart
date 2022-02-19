import 'package:flutter_chatapp/screens/auth-screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chatapp/screens/signup.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   // TextEditingController _nameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;



  @override
  void initState() {
    super.initState();
     // _nameController = TextEditingController(text: "");
    _emailController = TextEditingController(text: "");
    _passwordController = TextEditingController(text: "");

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
              Center(
                child: Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
              ),
              const SizedBox(height: 20.0),
              // TextField(
              //   controller: _nameController,
              //
              //   decoration: InputDecoration(hintText: "Enter your name"),
              // ),
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
              ElevatedButton(
                child: Text("Login"),
                onPressed: () async {
                  if (
                      _passwordController.text.isEmpty || _emailController.text.isEmpty
                          // || _nameController.text.isEmpty
                  ) {
                    print("Email, name and password cannot be empty");
                    return;
                  }
                  try {
                    final user = await AuthHelper.signInWithEmail(
                         // name: _nameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                      );

                    if (user != null) {
                      print("login successful");
                    }
                    // await FirebaseFirestore.instance.collection('users').doc(user.uid).set({}
                    // );


                  } catch (e) {
                    print(e);
                  }
                },
              ),

              ElevatedButton(
                child: Text("Create account"),
                onPressed: () async {
                   Navigator.push(context, MaterialPageRoute(builder: (_) => SignupPage(),
                   ),
                   );
                },
              ),
              ElevatedButton.icon(
                // child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                // children: [
                icon: Image(image:  AssetImage('assets/g-icon.png',
                ), height: 30,),
                label: Text("Login with Google"),
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
