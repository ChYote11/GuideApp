// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:guideapp/page/homepage.dart';
class AccountPage extends StatefulWidget {
  const AccountPage({
    super.key
  });

  @override
  State < AccountPage > createState() => _AccountPageState();
}

class _AccountPageState extends State < AccountPage > {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        leading: Builder(builder: (context) => IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,), 
            onPressed: () { 
              Navigator.push(context,
              MaterialPageRoute(
                builder: (context) => HomePage(),),);
             },),),
        title: Container(margin: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              color: Colors.black,
            ),
            Padding(padding: EdgeInsets.all(5)),
            Text("Profile",
            style: TextStyle(fontSize: 20,color: Colors.black),
            ),
            Padding(padding: EdgeInsets.all(33))
          ],)
        ),
      ),
      );
  }
}