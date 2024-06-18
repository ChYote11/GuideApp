// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, avoid_print, unused_local_variable, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, avoid_unnecessary_containers
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:guideapp/model/item.dart';
import '../components/constants.dart';
import '../components/url.dart' as url;

class PointPage extends StatefulWidget {
  const PointPage({
    super.key
  });

  @override
  State < PointPage > createState() => _PointPageState();
}

class _PointPageState extends State < PointPage > {
  int count = 0;
  // String path = url.url + 'items/call';

  Future < void > decreasePoint(int point) async {

    final body = ({
      // 'user_id': "U01347698d6ff5e939e955b5d2186011a",
      'user_id': box.read('userID'),
      'item_point': point
      //ส่ง id ของ item มาด้วย
    });


    var dio = Dio();
    var data = await dio.patch(url.url + 'users/decreasepoint', data: body);
    var jsonData = data.data;

    if (jsonData['status'] == 'success') {
      print('decreased');
      // print(jsonData['data1']);
    }

  }

  // Future < List < User >> updateUser() async {

  //   var dio = Dio();
  //   var data = await dio.get(url.url + 'user/');
  //   var jsonData = data.data;
  //   // print(jsonData);
  //   List < User > user = [];

  //   if (jsonData['status'] == "error") {
  //     //pop up แจ้งเตือนว่า การทำงานผิดพลาด
  //   } else {
  //     count = jsonData['data'].length;

  //     for (var u in jsonData['data']) {
  //       print(jsonData);
  //       User user_inloop = User();
  //       user_inloop.user_id = u['user_id'];
  //       user_inloop.point = u['point'];
  //       user.add(user_inloop);
  //     }
  //     print(user);
  //   }
  //   return user;
  // }

  Future < List < Item >> checkApi() async {

    var dio = Dio();
    var data = await dio.get(url.url + 'item');
    var jsonData = data.data;

    List < Item > item = [];

    if (jsonData['status'] == "error") {
      //pop up แจ้งเตือนว่า การทำงานผิดพลาด
    } else {
      count = jsonData['data'].length;

      for (var u in jsonData['data']) {
        Item item_inloop = Item();
        item_inloop.id = u['id'];
        item_inloop.name = u['name'];
        item_inloop.point = u['point'];
        item_inloop.item_img = u['item_img'];

        // book_inloop.images = u['images'];
        if (u['item_img'].isEmpty || u['item_img'] == null) {
          item_inloop.item_img = [] as String;
        } else {
          item_inloop.item_img = u['item_img'];
          // print(u['images']);
        }
        item.add(item_inloop);
      }
    }
    return item;
  }

  // void checkItemId() {
  //   print(jsonData['data']['book_id']);
  // }

  @override
  void initState() {
    super.initState();
    // print(box.read('token1')); // คะแนน

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
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
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: count,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.all(20.0), // กำหนดระยะห่างแนวตั้งระหว่าง Container
                  width: 335,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100],
                    borderRadius: BorderRadius.circular(25)
                  ),
                  child: Column(
                    children: [
                      // SizedBox(height: 25, ),

                      Container(
                        width: 335,
                        height: 250,
                        child: Image.network(
                          url.url + snapshot.data[index].item_img,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 20, ),

                      Text(
                        snapshot.data[index].name,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10, ),

                      Text(
                        snapshot.data[index].point.toString() + " คะแนน",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue
                        ),
                      ),
                      SizedBox(height: 10, ),

                      GestureDetector(
                        onTap: () {
                          print(snapshot.data[index].id);
                          decreasePoint(snapshot.data[index].point);
                          // checkItemId();
                          // updateUser();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25)
                              
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // decreasePoint(snapshot.data[index].point);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("ปิด"))
                              ],
                              title: const Text('ยินดีด้วย!!'),
                                contentPadding: const EdgeInsets.all(20),
                                  content: Column(
                                    children: [
                                      const Text('คุณได้แลกคูปองเรียบร้อยแล้ว'),
                                        Container(
                                          margin: EdgeInsets.all(20),
                                          width: 250,
                                          height: 250,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            color: Colors.blueGrey,
                                          ),
                                          child: Container(child: Image.asset("image/Yote.png")),
                                          // child: Text('คะแนนเหลือ' + ),
                                        )
                                    ],
                                  ),
                            ));
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 250,
                              height: 75,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.blueGrey,
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: Center(
                                child: Text(
                                  'แลกคูปอง',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),

                                ),
                              ),
                            ),
                          ],

                        ),
                      ),
                      SizedBox(height: 25, ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

}