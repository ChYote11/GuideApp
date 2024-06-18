// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, sort_child_properties_last, non_constant_identifier_names, unused_field, unused_import, avoid_print, unused_local_variable
import 'dart:convert';
import 'dart:io';
import "package:async/async.dart";
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:guideapp/components/url.dart';
import 'package:guideapp/components/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../../components/url.dart' as url;

class addItemPage extends StatefulWidget {
  const addItemPage({
    super.key
  });

  @override
  State < addItemPage > createState() => _addItemPage();
}

class _addItemPage extends State < addItemPage > {
  final formKey = GlobalKey < FormState > ();

  final TextEditingController name = TextEditingController();
  final TextEditingController point = TextEditingController();

  File ? _image;
  List < XFile > ? _selectedImages;

  String path1 = url.url + 'item/create';

  Future < void > sendDataToBackend1() async {
    // String base64Image = base64Encode(_image!);
    // print(base64Image);
    // print('data1');
    // print('body');
    String fileName = _image!.path.split('/').last;
    // _image = (await MultipartFile.fromFile(_image!.path, filename: fileName));
    FormData body = FormData.fromMap({
      'name': name.text,
      'point': point.text,
      "img": await MultipartFile.fromFile(_image!.path, filename: fileName),
      'item_img': 'public/item_img/' + fileName,
    });
    print(_image!.path);
    var dio = Dio();
    var data = await dio.post(path1, data: body);
    var jsonData = data.data;

    // print(jsonData['status']);
    // print(jsonData['data']['book_id']);

    if (jsonData['status'] == 'success') {
      print(body);
      print('object');
      
    } else {
      print('error');
    }
    setState(() {
      loading = false;
    });
  }


  void selectCoverImage() async {
    final XFile ? img =
      await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _image = File(img!.path);
    });
  }

  bool loading = false;

  // final
  // final img_cover =
  // final TextEditingController content = TextEditingController();
  // final TextEditingController lat = TextEditingController();
  // final TextEditingController long = TextEditingController();

  get uploadImage => null;

  double _opacity = 1.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.blueGrey,
            title: Text(
              "add Item",
              textAlign: TextAlign.center,
            ),
            actions: [
              GestureDetector(
                onTapDown: (_) {
                  setState(() {
                    point as dynamic;
                    // print('down');
                    // print(_selectedImages);
                    sendDataToBackend1();
                    loading = true;
                    
                    print("g");
                    _opacity = 0.5;
                  });
                },
                onTapUp: (_) {
                  setState(() {
                    _opacity = 1.0;
                  });
                },
                onTapCancel: () {
                  setState(() {
                    _opacity = 1.0;
                  });
                },
                child: AnimatedOpacity(
                  duration: Duration(milliseconds: 100),
                  opacity: _opacity,
                  child: Container(
                    color: Colors.blueGrey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            'เพิ่ม',
                            style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: Container(
            color: Colors.blueGrey[100],
            child: ListView(
              // physics: const BouncingScrollPhysics(), // Disable scrolling upwards
              children: [
                _image != null ?
                Container(
                  height: 200,
                  width: 500,
                  color: Colors.white,
                  child: Image.file(
                    (_image!),
                    fit: BoxFit.cover,
                  ),
                  // child: Image.asset(),
                ) :
                Container(
                  height: 200,
                  width: 500,
                  color: Colors.blue[200],
                  child: Icon(Icons.add_box),

                  // child: Image.asset(),
                ),

                Padding(
                  padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: selectCoverImage,
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(20),
                          child: const Center(
                            child: Text(
                              'เพิ่มรูปภาพรายการ',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                ),

                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.padding),
                    hintText: "ชื่อรายการ",
                  ),
                ),

                TextField(
                  controller: point,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.point_of_sale_rounded),
                    hintText: "คะแนน",
                  ),
                ),

              ],
            ),
          )),
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