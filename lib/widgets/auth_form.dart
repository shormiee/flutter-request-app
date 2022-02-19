// import 'package:flutter/material.dart';
//
// class AuthForm extends StatefulWidget {
//   AuthForm(this.submitFn, this.isLoading,);
//   final bool isLoading;
//   final void Function(
//       String email,
//       String password,
//       String userName,
//       bool isLogin,
//       BuildContext ctx,
//      ) submitFn;
//
//
//
//   @override
//   _AuthFormState createState() => _AuthFormState();
// }
//
// class _AuthFormState extends State<AuthForm> {
//
//   final _formKey = GlobalKey<FormState>();
//   var _isLogin = true;
//
//   var _userEmail = '';
//   var _userName = '';
//   var _userPassword = '';
//
//
//   void _trySubmit() {
//     final isValid = _formKey.currentState.validate();
//     FocusScope.of(context).unfocus();
//     if (isValid) {
//       _formKey.currentState.save();
//       widget.submitFn(
//           _userEmail.trim(),
//           _userName.trim(),
//       _userPassword.trim(),
//           _isLogin,
//         context
//       );
//
//     }
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return  Center(
//       child: Card(
//         margin: EdgeInsets.all(20),
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(16),
//           child: Form(
//               key: _formKey,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   TextFormField(
//                     validator: (value) {
//                       if (value.isEmpty || !value.contains('@')) {
//                         return 'please enter valid email address';
//                       }
//                       return null;
//                     },
//
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       labelText: 'Email Address',
//                     ),
//                     onSaved: (value) {
//                       _userEmail = value;
//                     },
//                   ),
//                   TextFormField(
//                     validator: (value) {
//                       if (value.isEmpty || value.length <4) {
//                         return 'please enter at least 4 character';
//                       }
//                       return null;
//                     },
//
//                     decoration: InputDecoration(
//                       labelText: 'Username',
//                     ),
//                     onSaved: (value) {
//                       _userName = value;
//                     },
//                   ),
//                   TextFormField(
//
//                     validator: (value) {
//                       if (value.isEmpty || value.length <7) {
//                         return 'password must be at least 7 characters long.';
//                       }
//                       return null;
//                     },
//                     decoration: InputDecoration(
//                       labelText: 'Password',
//                     ),
//                     onSaved: (value) {
//                       _userPassword = value;
//                     },
//
//                     obscureText: true,
//                   ),
//                   SizedBox(height: 12,),
//                   if (widget.isLoading)
//                     CircularProgressIndicator(),
//                   if(!widget.isLoading)
//                   ElevatedButton(
//                     child: Text(_isLogin ? 'Login' : 'Signup'),
//                     onPressed: _trySubmit,),
//
//
//                   if(!widget.isLoading)
//                   TextButton(
//                     child: Text(
//                         _isLogin ?
//                         'create new account' :
//                         'i already have an account'),
//                     onPressed: () {
//                       setState(() {
//                         _isLogin =  !_isLogin;
//                       });
//                     },
//                   )
//                 ],
//               )),
//         ),
//       ),
//     );
//   }
// }
