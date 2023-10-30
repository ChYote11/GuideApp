// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, avoid_print


import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:guideapp/model/user.dart';

import '../components/constants.dart';
class PointPage extends StatefulWidget {
  const PointPage({
    super.key
  });

  @override
  State < PointPage > createState() => _PointPageState();
}

class _PointPageState extends State < PointPage > {
  int count = 0;
  String path = 'http://localhost:3000/users';


  Future < List < User >> checkApi() async {

    var dio = Dio();
    var data = await dio.get(path);
    var jsonData = data.data;
    print(jsonData);
    List < User > user = [];

    // if (jsonData['status'] == "error") {
    //   //pop up แจ้งเตือนว่า การทำงานผิดพลาด
    // } else {
    //   count = jsonData['data'].length;

    //   for (var u in jsonData['data']) {
    //     User user_inloop = User();

    //     user_inloop.username = u ['username'];
    //     user_inloop.point = u['point'];


    //     // book_inloop.images = u['images'];
    //     // if (u['images'].isEmpty || u['images'] == null) {
    //     //   book_inloop.images=[];
    //     // }else{
    //     //   book_inloop.images=u['images'];
    //     //   // print(u['images']);
    //     // }
    //     // print(book_inloop.images);


    //     // print( book_inloop.book_id);

    //     user.add(user_inloop);
    //   }
    // }
    return user;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkApi(),
        builder: (BuildContext context, AsyncSnapshot < dynamic > snapshot) {
          if (!snapshot.hasData) {
            return Container(color: Colors.blue,
              height: 100, );
          } else {
            return Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text("คะแนน:" + " " + box.read('token3').toString(),
                    style: TextStyle(
                      fontSize: 20,
                    ), ), ),
              ),  
            );
          }
        },
      ),
    );
  }
}