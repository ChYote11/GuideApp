import 'package:flutter/material.dart';
import 'package:guideapp/page/homepage.dart';

class Book1 extends StatelessWidget {
  const Book1({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        // elevation: 0,
        leading: Builder(builder: (context) => IconButton(
          icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black, ),
            onPressed: () {
              Navigator.push(context,
                MaterialPageRoute(
                  builder: (context) => HomePage(), ), );
            }, ), ),
        actions: [],
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(25),
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(8)
        ),
      ),
    );
  }
}