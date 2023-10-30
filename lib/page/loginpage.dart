// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, use_key_in_widget_constructors, must_be_immutable, avoid_print, prefer_interpolation_to_compose_strings, non_constant_identifier_names

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guideapp/components/constants.dart';
import 'package:guideapp/model/user.dart';
import 'package:guideapp/page/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LoginPage extends StatelessWidget {

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  int count = 0;
  String path = 'http://localhost:3000/users/login';


  // Future<Null> routeToService (Widget myWidget, User user) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('id', User.user_id);
  // }


  Future < void > checkWithBackend(BuildContext context) async {



    final body = ({
      'username': username.text,
      'password': password.text,
      // 'firstname': firstname,
    });

    var dio = Dio();
    var data = await dio.post(path, data: body);
    var jsonData = data.data;



    // if (jsonData['status' == "success"]) {
    //   box.write('data', jsonData['user']);
    // }
    // print(box.read('data'));
    // var result = json.decode(data.data);
    // print("result = $result");
    // for (var map in result) {
    //   if (password == User.FromJson(password as Map<String, dynamic>)){

    //   }
    // }

    if (jsonData['status'] == 'success') {


      print(jsonData['data']);
      // print(json.decode(data.data));
      box.write('token1', jsonData['data1']);
      box.write('token2', jsonData['data2']);
      box.write('token3', jsonData['data3']);


      box.write('username', username.text);
      print(username.text);
      print(box.read('token1'));
      print(box.read('token2'));
            print(box.read('token3'));




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
            title: Text("  เกิดข้อผิดพลาด"),
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
        title: Text("เข้าสู่ระบบ"),
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
                  'เข้าสู่ระบบ',
                  style: TextStyle(
                    
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
                        hintText: "ชื่อบัญชีผู้ใช้",
                        labelText: "ชื่อบัญชีผู้ใช้",
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
                          hintText: "รหัสผ่าน",
                          labelText: "รหัสผ่าน",
                        ),
                        obscureText: true,
                      ),
                    ),

                    const SizedBox(height: 20, ),

                      GestureDetector(
                        onTap: () {

                          checkWithBackend(context);

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
                                'เข้าสู่ระบบ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                              ),
                            )),
                      ),
            ],
          ),
        ),
      ),
    );
  }
}