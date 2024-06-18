// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, avoid_print, non_constant_identifier_names, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unused_element, deprecated_member_use, unused_import, unrelated_type_equality_checks

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:guideapp/components/constants.dart';
import 'package:guideapp/model/book.dart';
import 'package:guideapp/model/route_path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_storage/get_storage.dart';
import '../book/sealife.dart';
import '../components/url.dart'
as url;
import '../model/user.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({
    super.key
  });

  @override
  State < FeedPage > createState() => _FeedPageState();
}

String path = '${url.url}books';
String path2 = url.url + 'users';
String path3 = url.url + 'path';
int count = 0;

Future < List < Book >> bookApi() async {
  var dio = Dio();
  var data = await dio.get(path);
  var jsonData = data.data;

  // print(jsonData);
  List < Book > book = [];

  if (jsonData['status'] == "error") {
    //pop up แจ้งเตือนว่า การทำงานผิดพลาด
  } else {
    count = jsonData['data'].length;

    var data3 = await dio.get(path3);
    var jsonData3 = data3.data;
    print(jsonData3);



    for (var u in jsonData['data']) {
      Book book_inloop = Book();
      book_inloop.name = u['name'];
      book_inloop.img_cover = u['img_cover'];
      book_inloop.book_content = u['book_content'];
      book_inloop.book_id = u['book_id'];
      book_inloop.lat = u['lat'];
      book_inloop.long = u['long'];
      book.add(book_inloop);

      for (var u in jsonData3['data']) {
        Route_path path_inloop = Route_path();
        path_inloop.book_id = u['book_id'];
        path_inloop.user_id = u['user_id'];

        if (book_inloop.book_id == path_inloop.book_id && box.read('userId') == path_inloop.user_id) {
          book.removeWhere((book)=> book.book_id == path_inloop.book_id );
          count = count - 1;
        }
        // path.add(path_inloop);

      }

      // book_inloop.images = u['images'];

      if (u['images'].isEmpty || u['images'] == null) {
        book_inloop.images = [];
      } else {
        book_inloop.images = u['images'];
        // print(u['images']);
      }
      
    }
  }
  return book;
}

Future < List < Route_path >> pathApi() async {

  var dio = Dio();
  var data = await dio.get(path3);
  var jsonData = data.data;
  // print(jsonData);
  List < Route_path > path = [];

  if (jsonData['status'] == "error") {
    //pop up แจ้งเตือนว่า การทำงานผิดพลาด
  } else {
    count = jsonData['data'].length;

    for (var u in jsonData['data']) {
      Route_path path_inloop = Route_path();
      path_inloop.book_id = u['book_id'];
      path_inloop.user_id = u['user_id'];
      // book_inloop.book_content = u['book_content'];

      // book_inloop.images = u['images'];
      path.add(path_inloop);
    }
  }
  return path;
}

Future < void > openGoogleMaps(double latitude, double longitude) async {
    final url =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Google Maps';
    }
  }

bool container = false;

class _FeedPageState extends State < FeedPage > {

  @override
  void initState() {
    super.initState();
    print(count);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            FutureBuilder(
              future: bookApi(),
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
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                        ),
                        itemCount: count,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            color: Colors.blueGrey[300],
                            child: Column(
                              children: [
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                      child: Text(
                                        snapshot.data[index].name,
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                                      ),
                                  ),
                                ),
                                Container(
                                  width: 300,
                                  height: 150,
                                  child: Image.network(url.url + snapshot.data[index].img_cover,
                                    fit: BoxFit.cover, ),
                                ),
                                SizedBox(height: 15, ),

                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                          children: [
                                            //Go To position box Box
                                            Flexible(
                                              child: GestureDetector(
                                                onTap: () {
                                                  // Test
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(builder: (context) => AccountPage()),
                                                  // );
                                                  openGoogleMaps(
                                                    double.parse(snapshot
                                                      .data[index].lat),
                                                    double.parse(snapshot
                                                      .data[index].long));
                                                },
                                                child: Container(
                                                  height: 75,
                                                  width: 400,
                                                  margin: EdgeInsets.fromLTRB(
                                                    5, 10, 5, 10),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blueGrey,
                                                    borderRadius:
                                                    BorderRadius.circular(12),
                                                  ),
                                                  child: Center(
                                                    child: ListTile(
                                                      leading: Icon(
                                                        Icons.location_on,
                                                        size: 28,
                                                        color: Colors.black,
                                                      ),
                                                      title: Text("Location",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color:
                                                          Colors.black)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                
                                            //Right Box
                                            Flexible(
                                              child: GestureDetector(
                                                onTap: () {
                                                  // Test
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                      SeaLife(
                                
                                                        name: snapshot
                                                        .data[index]
                                                        .name,
                                                        book_id: snapshot
                                                        .data[index]
                                                        .book_id,
                                                        img_cover: snapshot
                                                        .data[index]
                                                        .img_cover,
                                                        book_content: snapshot
                                                        .data[index]
                                                        .book_content,
                                                        lat: snapshot
                                                        .data[index]
                                                        .lat,
                                                        long: snapshot
                                                        .data[index]
                                                        .long,
                                                        images: snapshot
                                                        .data[index]
                                                        .images,
                                                      )
                                                    )
                                                  );
                                                },
                                                child: Container(
                                                  height: 75,
                                                  width: 400,
                                                  margin: EdgeInsets.fromLTRB(
                                                    5, 10, 5, 10),
                                                  padding: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                  decoration: BoxDecoration(
                                                    color: Colors.blueGrey,
                                                    borderRadius:
                                                    BorderRadius.circular(12),
                                                  ),
                                                  child: Center(
                                                    child: ListTile(
                                                      leading: Icon(
                                                        Icons.book,
                                                        size: 28,
                                                        color: Colors.black,
                                                      ),
                                                      title: Text("Go to book!",
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          color:
                                                          Colors.black)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),

                                // if (container)
                                //   Container(
                                //     width: 300,
                                //     height: 110,
                                //     decoration: BoxDecoration(
                                //       color: Colors.green,
                                //     ),
                                //   ),
                                //   SizedBox(height: 15, ),

                                //   if (!container)
                                //     Container(
                                //       width: 300,
                                //       height: 110,
                                //       decoration: BoxDecoration(
                                //         color: Colors.red, // สีแดงถ้า container เป็น false
                                //       ),
                                //     ),
                                //     SizedBox(height: 15, ),

                              ],
                            ),
                          );
                        }
                    ),
                  );
                }
              }
            )
          ],
        ),
      ),
    );
  }
}