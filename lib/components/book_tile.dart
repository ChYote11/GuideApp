import 'package:flutter/material.dart';
import 'package:guideapp/model/book.dart';

class BookTile extends StatelessWidget {
  Book book;
  BookTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 280,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(children: [
        //pic
        Text(book.name),

        //name
        // Text(book.descirption),

        //des
        Image.asset(book.img_cover)
      ]),
    );
  }
}