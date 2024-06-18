// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, avoid_print
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:guideapp/book/sealife.dart';
// import 'package:guideapp/components/book_tile.dart';
import 'package:guideapp/model/book.dart';
// import 'package:guideapp/model/library.dart';
// import 'package:provider/provider.dart';
import '../components/url.dart' as url;

class BookPage extends StatefulWidget {
  const BookPage({
    super.key
  });

  @override
  State < BookPage > createState() => _BookPageState();
}
class _BookPageState extends State < BookPage > {

  int count = 0;
  String path = '${url.url}books'; 
  
  Future < List < Book >> checkApi() async {

    var dio = Dio();
    var data = await dio.get(path);
    var jsonData = data.data;
    // print(jsonData);
    List < Book > book = [];

    if (jsonData['status'] == "error") {
      //pop up แจ้งเตือนว่า การทำงานผิดพลาด
    } else {
      count = jsonData['data'].length;

      for (var u in jsonData['data']) {
        print(jsonData);
        Book book_inloop = Book();
        book_inloop.name = u['name'];
        book_inloop.img_cover = u['img_cover'];
        book_inloop.book_content = u['book_content'];
        book_inloop.book_id = u['book_id'];
        book_inloop.lat = u['lat'];
        book_inloop.long = u['long'];
        
        // book_inloop.images = u['images'];
        if (u['images'].isEmpty || u['images'] == null) {
          book_inloop.images=[];
        }else{
          book_inloop.images=u['images'];
          // print(u['images']);
        }
        book.add(book_inloop);
      }
    }
    return book;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
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
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: count,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context, MaterialPageRoute(
                                  builder: (context) => SeaLife(
                                    name: snapshot.data[index].name,
                                    book_id: snapshot.data[index].book_id,
                                    img_cover: snapshot.data[index].img_cover,
                                    book_content: snapshot.data[index].book_content,
                                    lat: snapshot.data[index].lat,
                                    long: snapshot.data[index].long,
                                    images: snapshot.data[index].images,
                                  )
                                )
                              );
                            },
                            child: Card(
                              color: Colors.blueGrey[300],
                              child: Column(
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                        child: Text(
                                          snapshot.data[index].name,
                                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold,color: Colors.black),
                                        ),
                                    ),
                                  ),
                                  Container(
                                    width: 300,
                                    height: 100,
                                    child: Image.network(url.url + snapshot.data[index].img_cover,
                                      fit: BoxFit.cover, ),
                                  )
                                ],
                              ),
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