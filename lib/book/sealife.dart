// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, duplicate_ignore, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:guideapp/model/book.dart';
import 'package:guideapp/page/homepage.dart';
import '../components/url.dart' as url;

class SeaLife extends StatelessWidget {
  // SeaLife(book_id);
  // String get book_id;
  // final Book book;
  // ignore: non_constant_identifier_names
  final int book_id;
  final String name;
  final String img_cover;
  final String book_content;
  final String lat;
  final String long;
  final dynamic images;



  const SeaLife({
    super.key,
    required this.name,
    required this.book_id,
    required this.img_cover,
    required this.book_content,
    required this.lat,
    required this.long,
    required this.images
  });




  @override Widget build(BuildContext context) {
    // print(book_id);
    // print(name);
    // print(img_cover);
    // print(book_content);
    // print(lat);
    // print(long);
    // print(images.length);
    // print(images);

    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: Colors.black, ),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage(), ), );
              }, ), ),
        actions: [],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 400,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child:
                  Image.network(url.url + images[index]['img_path'],
                    fit: BoxFit.cover, ),
                );
              },
            ),
          ),

          Expanded(
            child: Container(
              height: 500,
              width: 400,
              margin: EdgeInsets.fromLTRB(15, 0, 15, 15),
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView(
                children: [
                  Column(
                    children: [Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(
                          child: Text(name,
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                          child: Text(book_content,
                            style: TextStyle(fontSize: 15, color: Colors.white), ),
                      ),
                    ],
                  ),
                  // Flexible(
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       // Test
                  //       // Navigator.push(
                  //       //   context,
                  //       //   MaterialPageRoute(builder: (context) => AccountPage()),
                  //       // );
                  //       // openGoogleMaps(double.parse(snapshot.data[index].lat), double.parse(snapshot.data[index].long));
                  //     },
                  //     child: Container(
                  //       height: 75,
                  //       width: 400,
                  //       margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  //       decoration: BoxDecoration(
                  //         color: Colors.white,
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //       child: Center(
                  //         child: ListTile(
                  //           leading: Icon(Icons.location_on,
                  //             size: 28,
                  //             color: Colors.black, ),
                  //           title: Text("Location",
                  //             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                  //               color: Colors.black)
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ]
              )
            ),
          ),
        ],
      ),
    );
  }
}