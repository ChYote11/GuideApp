// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:guideapp/page/Admin/additempage.dart';
import 'package:guideapp/page/Admin/addlocationpage.dart';
import 'package:guideapp/page/Admin/itemlist.dart';
import 'package:guideapp/page/Admin/userlist.dart';

class adminAuthen extends StatelessWidget {
  adminAuthen({
    super.key
  });

  final TextEditingController code = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        title: Text("Admin Authen"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 75, ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => addlocationpage(),
                  ),
                );
              },
              child: Container(
                height: 100,
                width: 200,
                color: Colors.blueGrey,
                child: Center(
                  child: Text(
                    'Go to add book',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ), ),
                ),
              ),
            ),

            const SizedBox(height: 20, ),

              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => userList(),
                    ),
                  );
                },
                child: Container(
                  height: 100,
                  width: 200,
                  color: Colors.blueGrey,
                  child: Center(
                    child: Text(
                      'Go to user list',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ), ),
                  ),
                ),
              ),

              const SizedBox(height: 20, ),


                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => addItemPage(),
                      ),
                    );
                  },
                  child: Container(
                    height: 100,
                    width: 200,
                    color: Colors.blueGrey,
                    child: Center(
                      child: Text(
                        'Go to add item',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ), ),
                    ),
                  ),
                ),


                const SizedBox(height: 20, ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => itemList(),
                        ),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: 200,
                      color: Colors.blueGrey,
                      child: Center(
                        child: Text(
                          'Go to item list',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ), ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

}