// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'package:flutter/material.dart';
import 'package:guideapp/App.dart';
import 'package:guideapp/components/bottom_nav_bar.dart';
import 'package:guideapp/components/constants.dart';
import 'package:guideapp/components/top_nav_bar.dart';
import 'package:guideapp/page/Account/accountpage.dart';
import 'package:guideapp/page/bookpage.dart';
import 'package:guideapp/page/feedpage.dart';
import 'package:guideapp/page/loginpage.dart';
import 'package:guideapp/page/mappage.dart';
import 'package:guideapp/page/pointpage.dart';

class HomePage extends StatefulWidget {


  const HomePage({
    super.key,
  });

  @override
  State < HomePage > createState() => _HomePageState();
}

class _HomePageState extends State < HomePage > {
  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  //pages to display
  final List < Widget > _pages = [
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
      //NavigationBar
      bottomNavigationBar: MyBottomNavBar(
        onTapChange: (index) => navigateBottomBar(index),
      ),
      //AppBar

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
        // title: Container(
        //   padding: EdgeInsets.all(8),
        //   decoration: BoxDecoration(
        //     color: Colors.white, borderRadius: BorderRadius.circular(12)),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       Text(
        //         "Search...",
        //         style: TextStyle(fontSize: 15, color: Colors.grey),
        //       ),
        //       Icon(
        //         Icons.search,
        //         color: Colors.black,
        //       ),
        //     ],
        //   )),
      ),
      drawer: Drawer(
        backgroundColor: Colors.greenAccent,
        child: Column(children: [
          DrawerHeader(
            child: Image.asset(
              'image/guide.jpg',
            ),
          ),

          // const Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 25.0),
          //       child: Divider(
          //         color: Colors.white,
          //       ),
          //   ),

          // Row(
          //   children: [
          //     Padding(padding: EdgeInsets.all(10)),
          //     Text(
          //       "บัญชีผู้ใช้",
          //       style: TextStyle(
          //         fontSize: 15,
          //       ),
          //       // textAlign: ,
          //     ),
          //   ],
          // ),

          // other pages
          GestureDetector(
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AccountPage(), ), );
            },
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 35,
                  color: Colors.black,
                ),
                title: Text(
                  'บัญชีผู้ใช้',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),



          // Container(
          //   margin: EdgeInsets.all(5),
          //   decoration: BoxDecoration(
          //     color: Colors.grey, borderRadius: BorderRadius.circular(12)),
          //   child: ListTile(
          //     leading: Icon(
          //       Icons.lock,
          //       size: 35,
          //       color: Colors.black,
          //     ),
          //     title: Text(
          //       'Privacy',
          //       style: TextStyle(fontSize: 20, color: Colors.white),
          //     ),
          //   ),
          // ),

          // Row(
          //   children: [
          //     Padding(padding: EdgeInsets.all(10)),
          //     Text(
          //       "นโยบายความเป็นส่วนตัว",
          //       style: TextStyle(
          //         fontSize: 15,
          //       ),
          //       // textAlign: ,
          //     ),
          //   ],
          // ),

          // Container(
          //   margin: EdgeInsets.all(5),
          //   decoration: BoxDecoration(
          //     color: Colors.grey, borderRadius: BorderRadius.circular(12)),
          //   child: ListTile(
          //     leading: Icon(
          //       Icons.flag,
          //       size: 35,
          //       color: Colors.black,
          //     ),
          //     title: Text(
          //       'Report a problem',
          //       style: TextStyle(fontSize: 20, color: Colors.white),
          //     ),
          //   ),
          // ),

          // Container(
          //   margin: EdgeInsets.all(5),
          //   decoration: BoxDecoration(
          //     color: Colors.grey, borderRadius: BorderRadius.circular(12)),
          //   child: ListTile(
          //     leading: Icon(
          //       Icons.people,
          //       size: 35,
          //       color: Colors.black,
          //     ),
          //     title: Text(
          //       'Support',
          //       style: TextStyle(fontSize: 20, color: Colors.white),
          //     ),
          //   ),
          // ),

          Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: Icon(
                Icons.info,
                size: 35,
                color: Colors.black,
              ),
              title: Text(
                'นโยบายความเป็นส่วนตัว',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),

          // Row(
          //   children: [
          //     Padding(padding: EdgeInsets.all(10)),
          //     Text(
          //       "ออกจากระบบ",
          //       style: TextStyle(
          //         fontSize: 15,
          //       ),
          //       // textAlign: ,
          //     ),
          //   ],
          // ),

          GestureDetector(
            onTap: () {
              box.erase();
              // Phoenix.rebirth(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => App(),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 35,
                  color: Colors.white,
                ),
                title: Text(
                  'ออกจากระบบ',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          )
        ]),
      ),
      body: _pages[_selectedIndex],
    );
  }
}