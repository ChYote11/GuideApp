// ignore_for_file: unused_field, prefer_interpolation_to_compose_strings, unused_local_variable, avoid_print, prefer_const_constructors, library_private_types_in_public_api, unused_import, use_build_context_synchronously
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:guideapp/components/url.dart';
import 'package:guideapp/components/url.dart'
as url;
import 'package:guideapp/model/user.dart';
import 'package:guideapp/page/adminauthen.dart';
import 'package:guideapp/page/homepage.dart';
import 'package:guideapp/page/loginpage.dart';
import 'package:guideapp/page/profilepage.dart';
import 'package:guideapp/page/registerpage.dart';

import 'components/constants.dart';

class App extends StatefulWidget {
  const App({
    Key ? key
  }): super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State < App > {
  late Future < String ? > _accessToken;

  @override
  void initState() {
    super.initState();
    lineSDKInit();
    // _accessToken = getAccessToken();
  }

  Future getAccessToken() async {
    try {
      final result = await LineSDK.instance.currentAccessToken;
      return result!.value;
    }
    on PlatformException
    catch (e) {
      print(e.message);
      return null;
    }
  }

  void lineSDKInit() async {
    await LineSDK.instance.setup(
      "2004574628",
      // universalLink: "14f2de8bd22d07fea0398d34fb96067c",
    ).then((_) {
      print("LineSDK is Prepared");
    });
  }

  String path = '${url.url}user';
  String path2 = url.url + 'users/create';
  int count = 0;

  Future < List < User >> checkApi() async {

    var dio = Dio();
    var data = await dio.get(path);
    var jsonData = data.data;
    // print(jsonData);
    List < User > user = [];

    if (jsonData['status'] == "error") {
      //pop up แจ้งเตือนว่า การทำงานผิดพลาด
    } else {
      count = jsonData['data'].length;

    }
    return user;
  }

  int point = 0;

  void startLineLogin() async {
    int i = 0;
    try {
      final result = await LineSDK.instance.login(scopes: ["profile"]);
      print(result.toString());
      var accesstoken = await getAccessToken();
      var displayname = result.userProfile!.displayName;
      var statusmessage = result.userProfile!.statusMessage;
      var imgUrl = result.userProfile!.pictureUrl;
      var userId = result.userProfile!.userId;

      print("DisplayName> " + displayname);
      print("StatusMessage> " + statusmessage!);
      print("ProfileURL> " + imgUrl!);
      print("userId> " + userId);

      final body = ({
        'user_id': userId,
        'displayname': displayname,
        'imgUrl': imgUrl,
        'statusMessage': statusmessage,
        'point': point,
      });

      var dio = Dio();
      var data = await dio.post(path2, data: body);
      var jsonData = data.data;

      List < User > user = [];

      if (jsonData['status'] == "error") {
        //pop up แจ้งเตือนว่า การทำงานผิดพลาด
      } else {
        if (jsonData['status'] == 'success') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
        }
      }
      box.write('Displayname', displayname);
      box.write('userId', userId);
      box.write('imgUrl', imgUrl);
      box.write('point', point);
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage(puserId: userId, paccessToken: accesstoken, pdisplayName: displayname, pimgUrl: imgUrl, pstatusMessage: statusmessage, )));
      
    }
    on PlatformException
    catch (e) {
      print("Error during LINE login: ${e.code} - ${e.message}");
      // แสดงข้อความแจ้งเตือนเกี่ยวกับข้อผิดพลาดนี้
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            // logo
            Padding(
              padding: const EdgeInsets.all(100),
                child: Image.asset(
                  'image/guide.jpg',
                ),
            ),
            // title
            const Text(
                'เข้าสู่ระบบ หรือ สมัครบัญชีใช้งาน',
                style: TextStyle(
                  fontSize: 23,
                  color: Colors.black),
              ),

              const SizedBox(height: 50),

                //Login button
                GestureDetector(
                  onTap: () {
                    startLineLogin();
                  },
                  child: Container(
                    width: 300,
                    color: Color.fromARGB(255, 0, 207, 45),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: < Widget > [
                        Image.asset('image/line.png', width: 80, height: 50, ),
                        Container(
                          color: Colors.black12,
                          width: 2,
                          height: 40,
                        ),
                        Expanded(
                          child: Center(child: Text("เข้าสู่ระบบด้วย LINE", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))), )
                      ]
                    )),
                ),

                SizedBox(height: 25),

            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              ),
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'เข้าสู่ระบบ Admin',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  ),
                )),
            ),
          ],
        ),
      ),
    );
  }
}