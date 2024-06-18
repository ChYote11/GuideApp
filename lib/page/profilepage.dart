// ignore_for_file: no_logic_in_create_state, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api, avoid_print, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:guideapp/page/homepage.dart';


class ProfilePage extends StatefulWidget {
  final String puserId;
  final String pdisplayName;
  final String pstatusMessage;
  final String paccessToken;
  final String pimgUrl;

  const ProfilePage({
    Key ? key,
    required this.puserId,
    required this.pdisplayName,
    required this.pstatusMessage,
    required this.paccessToken,
    required this.pimgUrl
  }): super(key: key);
  @override
  _ProfilePage createState() => _ProfilePage();
}

class _ProfilePage extends State < ProfilePage > {
  String displayName = "{DisplayName}";
  String statusMessage = "{Status}";
  String imgUrl = "{imgUrl}";
  String accessToken = "{AccessToken}";
  String userId = "{userId}";

  void logout() async {
    try {
      await LineSDK.instance.logout();
      Navigator.pop(context);
    }
    on PlatformException
    catch (e) {
      print(e.message);
    }
  }

  @override
  void initState() {
    setState(() {
      userId = widget.puserId;
      displayName = widget.pdisplayName;
      statusMessage = widget.pstatusMessage;
      imgUrl = widget.pimgUrl;
      accessToken = widget.paccessToken;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        title: Text("เข้าสู่ระบบ"),
      ),
      backgroundColor: Colors.white,
      // resizeToAvoidBottomInset: false, // set it to false
      body: SingleChildScrollView(
        child: Column(
          children: < Widget > [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: < Widget > [
                Padding(
                  padding: const EdgeInsets.all(30),
                    child: Image.network(imgUrl, width: 100, height: 100, ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Text("ยินดีต้อนรับ", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
                ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: < Widget > [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                    child: Text("* DisplayName:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
                ),
              ],
            ),
            Wrap(
              children: < Widget > [
                Padding(padding: EdgeInsets.all(8.0),
                  child: Text(displayName, style: TextStyle(fontSize: 20), ), )
              ], ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: < Widget > [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                    child: Text("* userId:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
                ),
              ],
            ),
            Wrap(
              children: < Widget > [
                Padding(padding: EdgeInsets.all(8.0),
                  child: Text(userId, style: TextStyle(fontSize: 20), ), )
              ], ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: < Widget > [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                    child: Text("* StatusMessage:", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), ),
                ),
              ],
            ),
            Wrap(
              children: < Widget > [
                Padding(padding: EdgeInsets.all(8.0),
                  child: Text(statusMessage, style: TextStyle(fontSize: 20), ), )
              ], ),
            Row(children: < Widget > [
              GestureDetector(
                onTap: () {
                  logout();
                },
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                      child: Container(
                        child: Text("ออกจากระบบ", style: TextStyle(color: Colors.white), ),
                        color: Color.fromRGBO(255, 59, 10, 1),
                        padding: EdgeInsets.all(8),
                      ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (contex) => HomePage()));
                },
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                      child: Container(
                        child: Text("ไปที่หน้า Home ", style: TextStyle(color: Colors.white), ),
                        color: Colors.green,
                        padding: EdgeInsets.all(8),
                      ),
                  ),
                ),
              )
            ], )
          ], ), ));
  }
}