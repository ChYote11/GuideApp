// ignore_for_file: prefer_const_constructors, unused_import, avoid_print, use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:guideapp/App.dart';
import 'package:guideapp/model/book.dart';
import 'package:guideapp/model/library.dart';
import 'package:guideapp/page/Admin/additempage.dart';
import 'package:guideapp/page/Admin/itemlist.dart';
import 'package:guideapp/page/Admin/locationlist.dart';
import 'package:guideapp/page/Admin/userlist.dart';
import 'package:guideapp/page/adminauthen.dart';
import 'package:guideapp/page/Admin/addlocationpage.dart';
import 'package:guideapp/page/bookpage.dart';
import 'package:guideapp/page/feedpage.dart';
import 'package:guideapp/page/homepage.dart';
import 'package:guideapp/page/loginpage.dart';
import 'package:guideapp/page/mappage.dart';
import 'package:guideapp/page/pointpage.dart';
import 'package:guideapp/page/registerpage.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  LineSDK.instance.setup("2004574628").then((_) {
  print("LineSDK Prepared");
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      title: 'Guide',
      home: App());
  }
}