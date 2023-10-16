// ignore_for_file: prefer_const_constructors, unused_import, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:guideapp/model/profile.dart';
import 'package:guideapp/page/loginpage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({
    super.key
  });

  @override
  _RegisterPage createState() => _RegisterPage();
}

class _RegisterPage extends State < RegisterPage > {
  final formKey = GlobalKey < FormState > ();
  Profile profile = Profile(email: '', password: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    
                    const SizedBox(height: 20, ),
              
                      Container(
                        width: 300,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: "Enter your E-mail",
                            labelText: "E-mail",
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
              
                      const SizedBox(height: 20, ),
              
                        Container(
                          width: 300,
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Enter your Password",
                              labelText: "Password",
                            ),
                            obscureText: true,
                          ),
                        ),
              
                        const SizedBox(height: 20, ),
                        
                        
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            ),
                            child: Container(
                              width: 300,
                              decoration: BoxDecoration(
                                color: Colors.greenAccent,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(20),
                                child: const Center(
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  ),
                                )),
                          )
              
              
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}