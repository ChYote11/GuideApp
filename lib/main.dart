// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:guideapp/App.dart';
import 'package:guideapp/model/library.dart';
import 'package:guideapp/page/homepage.dart';
import 'package:guideapp/page/loginpage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=> Library(),
    builder: (context, child) => const MaterialApp(
      debugShowCheckedModeBanner: false,
        title: 'Guide Demo',
        home: App()),);
  }
}