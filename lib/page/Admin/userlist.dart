// ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables, avoid_print, camel_case_types, prefer_const_constructors, unused_label, prefer_interpolation_to_compose_strings

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:guideapp/model/user.dart';

import '../../components/url.dart'
as url;

class userList extends StatefulWidget {
  const userList({
    super.key
  });

  @override
  State < userList > createState() => _userListState();
}

class _userListState extends State < userList > {
  String path = url.url + 'users';
  String path2 = url.url + 'users/delete';
  int count = 0;

  Future < void > delete(user_id) async {

    final body = ({
      'user_id': user_id,
    });

    print(user_id);

    var dio = Dio();
    var data = await dio.delete(path2, data: body);
    var jsonData = data.data;

    if (jsonData['status'] == 'success') {
      print('deleted');
      // print(jsonData['data1']);
    }
  }




  Future < List < User >> checkApi() async {

    var dio = Dio();
    var data = await dio.get(path);
    var jsonData = data.data;
    // print(jsonData);
    List < User > user = [];

    if (jsonData['status'] == "error") {
      //pop up แจ้งเตือนว่า การทำงานผิดพลาด
    } else {
      print("ok");
      count = jsonData['data'].length;
      print(count);

      for (var u in jsonData['data']) {
        print("object");
        print(jsonData['data']);

        User user_inloop = User();

        user_inloop.id = u['id'];
        print(user_inloop.id);

        user_inloop.user_id = u['user_id'];
        print(user_inloop.user_id);

        user_inloop.displayname = u['displayname'];
        print(user_inloop.displayname);

        user_inloop.statusMessage = u['statusMessage'];
        print(user_inloop.statusMessage);

        // user_inloop.creat_time = DateFormat('dd/MM/yyyy').format(DateTime.parse(u['creat_time'].toString()));
        user_inloop.creat_time = u['create_time'].toString();

        print(user_inloop.creat_time);

        user_inloop.accessToken = u['accessToken'];
        print(user_inloop.accessToken);

        user_inloop.imgUrl = u['imgUrl'];
        print(user_inloop.imgUrl);

        user_inloop.point = u['point'];
        print(user_inloop.point);
        // book_inloop.images = u['images'];
        user.add(user_inloop);
        print(user);
        print(count);
      }
    }
    return user;
  }
  @override
  void initState() {
    super.initState();
    // print(User());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        title: Text("User List"),
        // title: Container(
        //   padding: EdgeInsets.all(8),
        //   decoration: BoxDecoration(
        //     color: Colors.white, borderRadius: BorderRadius.circular(12)),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         "Search...",
        //         style: TextStyle(fontSize: 15, color: Colors.grey),
        //       ),
        //       Icon(
        //         Icons.search,
        //         color: Colors.black,
        //       ),
        //     ],
        //   )),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(children: [
          FutureBuilder(
            future: checkApi(),
            builder: (BuildContext context, AsyncSnapshot < dynamic > snapshot) {
              if (!snapshot.hasData) {
                return Container(
                  color: Colors.white,
                  height: 500,
                  width: 500,
                  child: SpinKitCubeGrid(
                    color: Colors.blueGrey,
                    size: 65,
                  ),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: count,
                    itemBuilder: (context, index) => Card(
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.network(snapshot.data[index].imgUrl,
                                width: 150, height: 150, ),
                              SizedBox(height: 5, ),

                              Text('ID: ' + snapshot.data[index].id.toString(),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), ),
                              SizedBox(height: 5, ),

                              Text("UserID ",
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), ),

                              SizedBox(height: 5, ),
                              Text(snapshot.data[index].user_id,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), ),
                              SizedBox(height: 5, ),

                              Text("Register Date: " + snapshot.data[index].creat_time,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              SizedBox(height: 5, ),

                              Text("Displayname: " + snapshot.data[index].displayname,
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              SizedBox(height: 5, ),

                              Text("Point: " + snapshot.data[index].point.toString(),
                                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                              SizedBox(height: 5, ),

                              GestureDetector(
                                onTap: () {
                                  delete(snapshot.data[index].user_id);
                                },
                                child: Container(
                                  width: 300,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                    color: Colors.red[400],
                                  ),
                                  child: Center(
                                    child: Text("ลบผู้ใช้", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), )),
                                ),
                              )
                            ], ),
                      )
                    ),
                  ));
              }
            }
          )
        ]), )
    );
  }
}