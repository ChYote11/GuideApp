// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTapChange;
  MyBottomNavBar({super.key, required this.onTapChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: GNav(
        onTabChange: (value) => onTapChange!(value),
        activeColor: Colors.white,
        tabs: const [
          GButton(
            icon: Icons.book,
            text: 'หนังสือ',
          ),
          GButton(
            icon: Icons.map,
            text: 'แผนที่',
          ),
          GButton(
            icon: Icons.bubble_chart,
            text: 'คะแนน',
          ),
          GButton(
            icon: Icons.document_scanner,
            text: "ข่าวสาร",
          ),
        ],
      ),
    );
  }
}
