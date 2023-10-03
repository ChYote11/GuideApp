// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTapChange;
  MyBottomNavBar({super.key, required this.onTapChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: GNav(
        onTabChange: (value) => onTapChange!(value),
        activeColor: Colors.white,
        tabs: const [
          GButton(
            icon: Icons.book,
            text: 'Book',
          ),
          GButton(
            icon: Icons.map,
            text: 'Map',
          ),
          GButton(
            icon: Icons.home,
            text: 'Home',
          ),
          GButton(
            icon: Icons.document_scanner,
            text: "Feed",
          ),
        ],
      ),
    );
  }
}
