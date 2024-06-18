// ignore_for_file: non_constant_identifier_names, prefer_const_literals_to_create_immutables, avoid_print, camel_case_types, prefer_const_constructors, unused_label, prefer_interpolation_to_compose_strings

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:guideapp/model/user.dart';

import '../../components/url.dart'
as url;
import '../../model/item.dart';

class itemList extends StatefulWidget {
  const itemList({
    super.key
  });

  @override
  State < itemList > createState() => _userListState();
}

class _userListState extends State < itemList > {
  // String path = url.url + 'users';
  String path2 = url.url + 'item/delete';
  int count = 0;

  Future < void > delete(id) async {

    final body = ({
      'id': id,
    });

    print(id);

    var dio = Dio();
    var data = await dio.delete(path2, data: body);
    var jsonData = data.data;

    if (jsonData['status'] == 'success') {
      print('deleted');

      // print(jsonData['data1']);
    }
    setState(() {
      print("flase");
      loading = false;
    });
  }

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
  bool loading = false;

  @override
  void initState() {
    super.initState();
    // print(User());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            elevation: 0,
            title: Text("Item List"),

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
                                  Image.network(url.url + snapshot.data[index].item_img,
                                    width: 150, height: 150, ),
                                  SizedBox(height: 5, ),

                                  Text('ID: ' + snapshot.data[index].id.toString(),
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), ),
                                  SizedBox(height: 5, ),

                                  Text("Name ",
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), ),

                                  SizedBox(height: 5, ),
                                  Text(snapshot.data[index].name,
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold), ),
                                  SizedBox(height: 5, ),

                                  Text("Point: " + snapshot.data[index].point.toString(),
                                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5, ),

                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        delete(snapshot.data[index].id);
                                        loading = true;
                                      });
                                    },
                                    child: Container(
                                      width: 300,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(15)),
                                        color: Colors.red[400],
                                      ),
                                      child: Center(
                                        child: Text("ลบรายการ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), )),
                                    ),
                                  )
                                ], ),
                          )
                        ),
                      )
                    );
                  }
                }

              )
            ]),
          ),
        ),
        if (loading == true)...[
          isLoading(),
        ]
      ],
    );
  }
}

Widget isLoading() {
  return Container(
    color: Colors.white,
    height: 800,
    width: 500,
    child: SpinKitCubeGrid(
      color: Colors.blueGrey,
      size: 65,
    ),
  );
}