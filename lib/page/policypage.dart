// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:guideapp/page/homepage.dart';

class Policypage extends StatelessWidget {
  const Policypage({
    super.key
  });

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
        title: Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.person,
                color: Colors.black,
              ),
              Expanded(
                child: Text("นโยบายความเป็นส่วนตัว",
                  style: TextStyle(fontSize: 19, color: Colors.black),
                ),
              ),
              Padding(padding: EdgeInsets.all(33))
            ], ),
        ),
      ),
      body: Image.asset("image/นโยบาย.jpg")
      // body: Expanded(
      //       child: Container(
      //         height: 500,
      //         width: 400,
      //         margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
      //         decoration: BoxDecoration(
      //           color: Colors.greenAccent,
      //           borderRadius: BorderRadius.circular(8),
      //         ),
      //         child: ListView(
      //           children: [
      //             Column(
      //               children: [Padding(
      //                   padding: EdgeInsets.all(20),
      //                   child: Center(
      //                     child: Text("name",
      //                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ]
      //         ),
      //       ),
      //     ),
    );
  }
}