// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guideapp/book/book1.dart';
import 'package:guideapp/book/sealife.dart';
import 'package:guideapp/components/book_tile.dart';
import 'package:guideapp/model/book.dart';
import 'package:guideapp/model/library.dart';
import 'package:provider/provider.dart';


class BookPage extends StatefulWidget {
  const BookPage({
    super.key
  });

  @override
  State < BookPage > createState() => _BookPageState();
}

class _BookPageState extends State < BookPage > {


  @override
  Widget build(BuildContext context) {
    return Consumer < Library > (builder: (context, value, child) => Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
              child: Text("Which book ?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24), ),
          ),
        ),

        const SizedBox(height: 10),

          Expanded(
            child: GridView.builder(
              itemCount: 4,
              padding: EdgeInsets.all(0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                // Create a book
                Book book = value.getBookList()[index];
                return GestureDetector(
                  onTap: () {
                    print('Tapped on item $index');
                    print(value.bookList[index]);
                    print(index);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeaLife(book: value.bookList[index],selectedBookIndex: index),
                      ),
                    );
                  },
                  child: BookTile(book: book),
                );
              },
            ),
          )

      ],
    ));
  }
}