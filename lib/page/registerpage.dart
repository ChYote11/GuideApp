// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:guideapp/model/profile.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  Profile profile = Profile(email: '', password: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // email
                Text(
                  "E-mail",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (email) {
                    profile.email = email!;
                  },
                ), // TextFormField
                SizedBox(
                  height: 15,
                ),
                Text(
                  "Password",
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  obscureText: true,
                ), // TextFormField
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text(
                      "Register",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {},
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
