import 'package:flutter/material.dart';
import 'package:guideapp/model/book.dart';
import 'package:guideapp/page/homepage.dart';

class SeaLife extends StatelessWidget {
  final Book book;

  final int selectedBookIndex;


  SeaLife({super.key, 
    required this.book,
    required this.selectedBookIndex
  });




  @override Widget build(BuildContext context) {
    print(book);
    return Scaffold(

      appBar: AppBar(
        title: Text("Sealife"),
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: Colors.black, ),
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => HomePage(), ), );
              }

              , ), ),
        actions: [],
      ),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            
              Text('Selected Book Title: ${book.name}'),
              Text('Selected Book Index: $selectedBookIndex')
          ],
        ),
      ),
    );
  }
}