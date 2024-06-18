// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, use_key_in_widget_constructors, must_be_immutable, avoid_print, prefer_interpolation_to_compose_strings, non_constant_identifier_names, unused_import, unrelated_type_equality_checks

import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:get/get.dart';
import 'package:guideapp/components/constants.dart';
import 'package:guideapp/model/user.dart';
import 'package:guideapp/page/adminauthen.dart';
import 'package:guideapp/page/Admin/addlocationpage.dart';
import 'package:guideapp/page/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/url.dart'
as url;



class LoginPage extends StatelessWidget {

  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();

  int count = 0;
  String path = url.url + 'users/login';



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

    if (username.text == 'Admin' && password.text == 'Admin') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => adminAuthen(),
          // code: s;dlfkjgdkls;fjg
        ),
      );
    }
    // else if (jsonData['status'] == 'success') {

    //   // print(jsonData['data']);
    //   // print(json.decode(data.data));/ คะแนน

    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => HomePage(),
    //     ),
    //   );
    // } else if (jsonData['msg'] == 'invalid password') {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(25)
    //         ),
    //         title: Text("  เกิดข้อผิดพลาด"),
    //         content: Text("กรุณนาตรวจสอบรหัสผ่านอีกครั้ง"),
    //         actions: < Widget > [
    //           TextButton(
    //             child: Text("OK"),
    //             onPressed: () {
    //               Navigator.of(context).pop(); // Close the dialog
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // } else if (jsonData['msg'] == 'user not found') {
    //   showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(25)
    //         ),
    //         title: Text("ไม่พบชื่อผู้ใช้"),
    //         content: Text("ไม่พบชื่อผู้ใช้ในระบบ กรุณาตรวจสอบชื่อผู้ใช้อีกครั้ง"),
    //         actions: < Widget > [
    //           TextButton(
    //             child: Text("OK"),
    //             onPressed: () {
    //               Navigator.of(context).pop(); // Close the dialog
    //             },
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // }
  }

  String displayName = "{DisplayName}";
  String statusMessage = "{Status}";
  String imgUrl = "{imgUrl}";
  String accessToken = "{AccessToken}";
  String userId = "{userId}";

  void logout() async {
    try {
      await LineSDK.instance.logout();
      // Navigator.pop(context);
      print("Logout");
    }
    on PlatformException
    catch (e) {
      print(e.message);
    }
  }

  @override
  void initState() {
    // setState(() {
    //   userId = widget.puserId;
    //   displayName = widget.pdisplayName;
    //   statusMessage = widget.pstatusMessage;
    //   imgUrl = widget.pimgUrl;
    //   accessToken = widget.paccessToken;
    // });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        title: Text("เข้าสู่ระบบ"),
      ),
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false, // set it to false
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
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
                                color: Colors.blueGrey,
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
            )
          ]
        ))



    );
  }
}