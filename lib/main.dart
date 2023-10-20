// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:guideapp/App.dart';
import 'package:guideapp/model/library.dart';
import 'package:guideapp/page/homepage.dart';
import 'package:guideapp/page/loginpage.dart';
import 'package:provider/provider.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Guide Demo',
        home: App());
  }
}