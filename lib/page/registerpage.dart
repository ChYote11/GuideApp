// ignore_for_file: prefer_const_constructors, unused_import, library_private_types_in_public_api, use_build_context_synchronously

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guideapp/model/user.dart';
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

  final TextEditingController username = TextEditingController();
  final TextEditingController firstname = TextEditingController();
  final TextEditingController lastname = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();

  int count = 0;
  String path = 'http://localhost:3000/users/create';
  int point = 0;



  Future < void > sendDataToBackend() async {

    final body = ({
      'username': username.text,
      'firstname': firstname.text,
      'lastname': lastname.text,
      'password': password.text,
      'point': point = 0
    });
    var dio = Dio();
    var data = await dio.post(path, data: body);
    var jsonData = data.data;

    if (jsonData['status'] == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } else if (jsonData['msg'] == 'used'){
            showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("ชื่อผู้ใช้ไม่สามารถใช้งานได้"),
            content: Text("เนื่องจากมีชื่อผู้ใช้นี้ถูกใช้งานไปแล้ว"),
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
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("เกิดข้อผิดพลาด"),
            content: Text("กรุณาลองใหม่อีกครั้ง"),
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
        title: Text("Sign up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
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
                          controller: username,
                          decoration: InputDecoration(
                            hintText: "Enter your username",
                            labelText: "Username",
                          ),
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
                            controller: firstname,
                            decoration: InputDecoration(
                              hintText: "Enter your firstname",
                              labelText: "Firstname",
                            ),
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
                              controller: lastname,
                              decoration: InputDecoration(
                                hintText: "Enter your lastname",
                                labelText: "Lastname",
                              ),
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

                              Container(
                                width: 300,
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextField(
                                  controller: confirmpassword,
                                  decoration: InputDecoration(
                                    hintText: "Confirm your password",
                                    labelText: "Confirm password",
                                  ),
                                  obscureText: true,
                                ),
                              ),


                              const SizedBox(height: 20, ),

                                GestureDetector(
                                  onTap: () {
                                    if (password.text != confirmpassword.text) {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Error"),
                                            content: Text("Passwords do not match."),
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
                                    } else if (username.text.isEmpty || firstname.text.isEmpty || lastname.text.isEmpty) {
                                      // Validate that all fields are filled in.
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text("Error"),
                                            content: Text("Please fill in all fields."),
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
                                    } else {

                                      // If all fields are valid, send data to the backend.
                                      sendDataToBackend();
                                      // print(username);
                                      // sendDataToBackend(firstname.text);
                                      // print(firstname);
                                      // sendDataToBackend(lastname.text);
                                      // print(lastname);
                                      // sendDataToBackend(password.text);
                                      // print(password);

                                    }
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
                                          'Sign up',
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

// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => LoginPage(),
//   ),
// ),