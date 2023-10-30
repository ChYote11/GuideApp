// ignore_for_file: unnecessary_string_escapes, unused_import, prefer_const_constructors, override_on_non_overriding_member
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guideapp/page/loginpage.dart';
import 'package:guideapp/page/registerpage.dart';

class App extends StatelessWidget {
  const App({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            // logo
            Padding(
              padding: const EdgeInsets.all(100),
              child: Image.asset(
                'image/guide.jpg',
              ),
            ),
            // title
            const Text(
              'เข้าสู่ระบบ หรือ สมัครบัญชีใช้งาน',
              style: TextStyle(
                  fontSize: 23,
                  color: Colors.black),
            ),

            const SizedBox(height: 50),

            //Login button
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
                      'เข้าสู่ระบบ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),

            SizedBox(height: 25),

            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              ),
              child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      'สมัครบัญชี',
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
