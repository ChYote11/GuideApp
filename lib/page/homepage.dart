// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:guideapp/components/bottom_nav_bar.dart';
import 'package:guideapp/components/top_nav_bar.dart';
import 'package:guideapp/page/bookpage.dart';
import 'package:guideapp/page/feedpage.dart';
import 'package:guideapp/page/mappage.dart';
import 'package:guideapp/page/pointpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //pages to display
  final List<Widget> _pages = [
    // book page
    const BookPage(),
    //Map page
    const MapPage(),
    //Home page
    const PointPage(),
    //Map page
    const FeedPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(
        onTapChange: (index) => navigateBottomBar(index),
      ),
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        elevation: 0,
        leading: Builder(
            builder: (context) => IconButton(
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                })),
        title: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Search...",
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                Icon(
                  Icons.search,
                  color: Colors.black,
                ),
              ],
            )),
      ),
      drawer: Drawer(
        backgroundColor: Colors.greenAccent,
        child: Column(children: [
          DrawerHeader(
            child: Image.asset(
              'lib/image/guide.jpg',
            ),
          ),

          const Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Divider(
              color: Colors.white,
            ),
          ),

          Row(
            children: [
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "Account",
                style: TextStyle(
                  fontSize: 15,
                ),
                // textAlign: ,
              ),
            ],
          ),

          // other pages
          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(24)),
            child: ListTile(
              leading: Icon(
                Icons.person,
                size: 35,
                color: Colors.black,
              ),
              title: Text(
                'Account',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(24)),
            child: ListTile(
              leading: Icon(
                Icons.lock,
                size: 35,
                color: Colors.black,
              ),
              title: Text(
                'Privacy',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(24)),
            child: ListTile(
              leading: Icon(
                Icons.notifications,
                size: 35,
                color: Colors.black,
              ),
              title: Text(
                'Notification',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),

          Row(
            children: [
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "Support & About",
                style: TextStyle(
                  fontSize: 15,
                ),
                // textAlign: ,
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(24)),
            child: ListTile(
              leading: Icon(
                Icons.flag,
                size: 35,
                color: Colors.black,
              ),
              title: Text(
                'Report a problem',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(24)),
            child: ListTile(
              leading: Icon(
                Icons.people,
                size: 35,
                color: Colors.black,
              ),
              title: Text(
                'Support',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(24)),
            child: ListTile(
              leading: Icon(
                Icons.info,
                size: 35,
                color: Colors.black,
              ),
              title: Text(
                'Terms and Policies',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),

          Row(
            children: [
              Padding(padding: EdgeInsets.all(10)),
              Text(
                "Logut",
                style: TextStyle(
                  fontSize: 15,
                ),
                // textAlign: ,
              ),
            ],
          ),

          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(24)),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                size: 35,
                color: Colors.white,
              ),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
