// ignore_for_file: prefer_const_constructors, camel_case_types, prefer_const_literals_to_create_immutables, sort_child_properties_last, non_constant_identifier_names, unused_field, unused_import, avoid_print, unused_local_variable, override_on_non_overriding_member, prefer_interpolation_to_compose_strings
import 'dart:convert';
import 'dart:io';
import "package:async/async.dart";
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:guideapp/components/utils.dart';
import 'package:image_picker/image_picker.dart';
import '../../components/url.dart'
as url;


// class ImageItem {
//   String imagePath;
//   ImageItem(this.imagePath);
// }

class addlocationpage extends StatefulWidget {
  const addlocationpage({
    super.key
  });

  @override
  State < addlocationpage > createState() => _addlocationpage();
}

class _addlocationpage extends State < addlocationpage > {
  final formKey = GlobalKey < FormState > ();

  final TextEditingController name = TextEditingController();
  final TextEditingController content = TextEditingController();
  final TextEditingController lat = TextEditingController();
  dynamic _dynamicData;
  final TextEditingController long = TextEditingController();

  File ? _image;
  List < XFile > ? _selectedImages;

  String path1 = url.url + 'books/create';
  String path2 = url.url + 'images/create';

  Future < void > sendDataToBackend1() async {
    // String base64Image = base64Encode(_image!);
    // print(base64Image);
    // print('data1');
    // print('body');
    String fileName = _image!.path.split('/').last;
    // _image = (await MultipartFile.fromFile(_image!.path, filename: fileName));
    FormData body = FormData.fromMap({
      'name': name.text,
      'book_content': content.text,
      'lat': lat.text,
      'long': long.text,
      "img": await MultipartFile.fromFile(_image!.path, filename: fileName),
      'img_cover': 'public/cover_img/' + fileName,

      // 'images': imgs
    });
    // print(_image!.path);
    var dio = Dio();
    var data = await dio.post(path1, data: body);
    var jsonData = data.data;

    // print(jsonData['status']);
    // print(jsonData['data']['book_id']);

    if (jsonData['status'] == 'success') {
      // print(body);
      // print('object');

      sendDataToBackend2(jsonData['data']['book_id']);
    } else {
      print('error');
    }
  }

  Future < void > sendDataToBackend2(int idBook) async {
    // print('data2');
    // List< MultipartFile >? files = [];
    // print(files);
    List < MultipartFile > filePaths = [];
    List < String > y = [];
    // List<XFile>? filename = _selectedImages!.split('/').last;
    //   for (XFile imageFile in _selectedImages!) {
    //   files.add(await MultipartFile.fromFile(imageFile.path, filename: imageFile.name));
    //   print(imageFile.path);
    // }
    for (var file in _selectedImages!) {
      // filePaths.add( file.path.split('/').last);
      filePaths
        .add((await MultipartFile.fromFile(file.path, filename: file.name)));
      y.add("public/content_img/" + file.path.split('/').last);
    }
    // print(filePaths);
    // print(y);
    // String fileName = _selectedImages!.split('/').last;
    // print(files);
    FormData body = FormData.fromMap({
      'images': y,
      'files': filePaths,
      'book_id': idBook,
      // 'images': files,
    });

    var dio = Dio();
    var data = await dio.post(path2, data: body);
    // print(data);
    var jsonData = data.data;

    if (jsonData['status'] == 'success') {
      print(body);
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

  final ImagePicker imagePicker = ImagePicker();

  void selectedImage() async {
    List < XFile > selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      _selectedImages ?.addAll(selectedImages);
    }
    setState(() {
      _selectedImages = selectedImages;
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
              "Admin",
              textAlign: TextAlign.center,
            ),
            actions: [
              GestureDetector(
                onTapDown: (_) {
                  setState(() {
                    lat.text as dynamic;
                    long.text as dynamic;
                    // print('down');
                    // print(_selectedImages);
                    sendDataToBackend1();
                    loading = true;
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
                  child: Icon(Icons.add_a_photo),

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
                              'เพิ่มรูปภาพหน้าปก',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            ),
                          )),
                    ),
                ),

                // add image
                _selectedImages != null ?
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8)),
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedImages!.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: 400,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Image.file(
                          File(_selectedImages![index].path),
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ) :
                Container(
                  height: 200,
                  color: Colors.blue[200],
                  child: Icon(Icons.add_a_photo),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: selectedImage,
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(20),
                          child: const Center(
                            child: Text(
                              'เพิ่มรูปภาพเนื้อหา',
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
                    prefixIcon: Icon(Icons.place),
                    hintText: "ชื่อสถานที่",
                  ),
                ),

                SizedBox(
                  height: 100,
                  child: TextField(
                    controller: content,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(5, 15, 0, 0),
                      hintText: "เขียนคำบรรยาย...",
                    ),
                  ),
                ),

                TextField(
                  controller: lat,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.place),
                    hintText: "Latitude",
                  ),
                ),

                TextField(
                  controller: long,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.place),
                    hintText: "Longtitude",
                  ),
                ),
              ],
            ),
          )
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