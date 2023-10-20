// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guideapp/components/constants.dart';
import 'package:guideapp/page/homepage.dart';



class LoginPage extends StatelessWidget {

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  int count = 0;
  String path = 'http://localhost:3000/users/login';


  Future < void > checkWithBackend(BuildContext context) async {

    final body = ({
      'username': username.text,
      'password': password.text
    });
    var dio = Dio();
    var data = await dio.post(path, data: body);
    var jsonData = data.data;

    if (jsonData['status'] == 'success') {
      box.write('key',username.text);

      print(username.text);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else if (jsonData['msg'] == 'invalid password') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("รหัสผ่านเกิดข้อผิดพลาด"),
            content: Text("กรุณนาตรวจสอบรหัสผ่านอีกครั้ง"),
            actions: < Widget > [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    } else if (jsonData['msg'] == 'user not found') {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("ไม่พบชื่อผู้ใช้"),
            content: Text("ไม่พบชื่อผู้ใช้ในระบบ กรุณาตรวจสอบชื่อผู้ใช้อีกครั้ง"),
            actions: < Widget > [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.greenAccent,
        title: Text("Sing in"),
      ),
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false, // set it to false
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              //logo
              Padding(
                padding: const EdgeInsets.all(0),
                  child: Image.asset(
                    'image/guide.jpg',

                    height: 200,
                  ),
              ),
              const Text(
                  'Sign In',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.black),
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
                      controller: username,
                      decoration: InputDecoration(
                        hintText: "Enter your username",
                        labelText: "Username",
                      ),
                      keyboardType: TextInputType.text,
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
                        controller: password,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          labelText: "Password",
                        ),
                        obscureText: true,
                      ),
                    ),

                    const SizedBox(height: 20, ),

                      GestureDetector(
                        onTap: () {
                          
                          checkWithBackend(context);
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => HomePage(),
                          //   ),
                          // );

                        },

                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(20),
                            child: const Center(
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
                      GestureDetector(


                        child: Container(
                          width: 300,
                          decoration: BoxDecoration(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(20),
                            child: const Center(
                              child: Text(
                                'Map',
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
    );
  }
}