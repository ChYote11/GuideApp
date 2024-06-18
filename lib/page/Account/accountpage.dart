// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, prefer_interpolation_to_compose_strings, unnecessary_import

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:guideapp/components/constants.dart';
import 'package:guideapp/model/user.dart';
import 'package:guideapp/page/homepage.dart';
import 'package:flutter/services.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({
    super.key
  });

  @override
  State < AccountPage > createState() => _AccountPageState();
}

class _AccountPageState extends State < AccountPage > {

  // String path = 'http://localhost:3001/users';

  int count = 0;

  @override
  void initState() {
    super.initState();

    print(box.read('imgUrl').toString());
        print(box.read('Displayname').toString());
    print(box.read('point').toString());

    // checkApi();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        leading: Builder(builder: (context) => IconButton(
          icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black, ),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => HomePage(), ), );
            }, ), ),
        title: Container(margin: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                color: Colors.black,
              ),
              Padding(padding: EdgeInsets.all(5)),
              Text("บัญชีผู้ใช้",
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              Padding(padding: EdgeInsets.all(33))
            ], )
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Container(
            width: 500,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(30),
                          child: Image.network(box.read('imgUrl'), width: 150, height: 150, ),
                      ),
                    ],
                  ),
                Text("ชื่อ : " + box.read('Displayname'),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  ), ),

                Text("คะแนน : " + box.read('point').toString(),
                  style: TextStyle(
                    fontSize: 18
                  ), ),

              ],
            ),
          ),
        ),
      )
    );
  }
}



//     FutureBuilder(
// future: null,
// builder: (BuildContext context, AsyncSnapshot < dynamic > snapshot) {
//   if (!snapshot.hasData) {
//     return Container(color: Colors.blue,
//       height: 100, );
//   } else {
//     return Padding(
//       padding: EdgeInsets.all(10),
//       child: Center(
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.greenAccent,
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Column(
//             children: [
//               Container(
//                 height: 150,
//                 width: 400,
//                 margin: EdgeInsets.all(20),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.grey,
//                 ),
//                 child: Column(
//                   children: [
//                     Icon(Icons.person,
//                       size: 150,
//                       color: Colors.black54, )
//                   ],
//                 ),
//               ),
//               Text("Name : ",
//                 style: TextStyle(
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold
//                 ), ),

//               Text("Username : ",
//                 style: TextStyle(
//                   fontSize: 18
//                 ), ),

//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
// )