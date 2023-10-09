// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:guideapp/App.dart';
import 'package:guideapp/page/homepage.dart';
import 'package:guideapp/page/loginpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Guide Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: App());
  }
}