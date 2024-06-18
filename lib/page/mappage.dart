// ignore_for_file: prefer_const_constructors, unused_element, unnecessary_new, prefer_final_fields, deprecated_member_use, no_leading_underscores_for_local_identifiers, avoid_print, prefer_interpolation_to_compose_strings, unrelated_type_equality_checks, unused_local_variable, depend_on_referenced_packages, unused_import, unnecessary_null_comparison, unused_field, sized_box_for_whitespace, non_constant_identifier_names, unnecessary_cast, curly_braces_in_flow_control_structures, use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:guideapp/book/sealife.dart';
import 'package:guideapp/components/constants.dart';
import 'package:guideapp/model/book.dart';
import 'package:guideapp/model/user.dart';
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart'
as geo; // or whatever name you want
import '../components/url.dart'
as url;
import '../model/route_path.dart';

// import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key
  });

  @override
  State < MapPage > createState() => _MapPageState();
}

class _MapPageState extends State < MapPage > {
  // int point = (box.read('token1'));
  int count = 0;
  String path = url.url + 'books';
  String route_path = url.url + 'path/create';
  String route = url.url + 'path';
  String patch = url.url + 'users/pluspoint';
  bool _showSlidingUpPanel = false;
  int user = 0;

  Future < List < Book >> checkIn() async {
    var dio = Dio();
    var data = await dio.get(path);
    var jsonData = data.data;
    // print(jsonData);
    List < Book > book = [];

    if (jsonData['status'] == "error") {
      //pop up แจ้งเตือนว่า การทำงานผิดพลาด
    } else {
      count = jsonData['data'].length;
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);
      double position1 = position.latitude;
      double position2 = position.longitude;
      // print("count $count");

      for (var u in jsonData['data']) {
        Book book_inloop = Book();
        book_inloop.name = u['name'];
        book_inloop.img_cover = u['img_cover'];
        book_inloop.book_content = u['book_content'];
        book_inloop.book_id = u['book_id'];
        book_inloop.lat = u['lat'];
        book_inloop.long = u['long'];

        if (Geolocator.distanceBetween(position1, position2, double.parse(book_inloop.lat), double.parse(book_inloop.long)) as double <= 20.0) {

          final body = ({
            'user_id': box.read('userId'),
            // 'user_id': "U01347698d6ff5e939e955b5d2186011a",
            'book_id': book_inloop.book_id
          });

          var dio = Dio();
          var data = await dio.post(route_path, data: body);
          print(data);
          var jsonData = data.data;
          print(jsonData);

          if (jsonData['status'] == 'success') {
            var dio = Dio();
            var data = await dio.get(route);
            var jsonData = data.data;

            for (var u in jsonData['data']) {
              Route_path path_inloop = Route_path();
              path_inloop.book_id = u['book_id'];
              path_inloop.user_id = u['user_id'];
              if (path_inloop.user_id == box.read('userId')) {
                user = user + 1;
                print(user);
                if (user > 2) {
                  final body = ({
                    'user_id': box.read('userId'),
                  });
                  var dio = Dio();
                  var data = await dio.patch(patch, data: body);
                  var jsonData = data.data;

                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(25)),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("close"))
                      ],
                      title: const Text('ยินดีด้วย! คุณเช็คอินครบแล้ว!!'),
                        contentPadding:
                        const EdgeInsets.all(20),
                          content: const Text(
                            'ระบบได้ทำการเพิ่ม 300 คะแนนเรียบร้อย'),
                    ));
                }
              }
            }
            print('success');
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius:
                  BorderRadius.circular(25)),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("close"))
                ],
                title: const Text('ทำการเช็คอินเรียบร้อย!!'),
                  contentPadding:
                  const EdgeInsets.all(20),
                    content: const Text(
                      'คุณได้ทำการเช็คอินเรียบร้อย'),
              ));
          } else if (jsonData['msg'] == 'used') {
            showDialog(
              context: context,
              builder: (context) {

                return AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(25)),
                  title: Text("ไม่สามารถเช็คอินได้"),
                  content: Text("เนื่องจากคุณเคยเช็คอินไปแล้ว"),
                  actions: < Widget > [
                    TextButton(
                      child: Text("ตกลง"),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
        book.add(book_inloop);
      }
    }
    return book;
  }

  Future < List < Book >> checkApi() async {
    var dio = Dio();
    var data = await dio.get(path);
    var jsonData = data.data;
    // print(jsonData);
    List < Book > book = [];
    if (jsonData['status'] == "error") {
      //pop up แจ้งเตือนว่า การทำงานผิดพลาด
    } else {
      count = jsonData['data'].length;
      // print("count $count");

      for (var u in jsonData['data']) {
        Book book_inloop = Book();

        book_inloop.name = u['name'];
        book_inloop.img_cover = u['img_cover'];
        book_inloop.book_content = u['book_content'];
        book_inloop.book_id = u['book_id'];
        book_inloop.lat = u['lat'];
        book_inloop.long = u['long'];
        // book_inloop.images = u['images'];
        if (u['images'].isEmpty || u['images'] == null) {
          book_inloop.images = [];
        } else {
          book_inloop.images = u['images'];
          // print(u['images']);
        }

        // print( book_inloop.book_id);
        // 13.841031
        // 100.575261

        book.add(book_inloop);
        // for (var i in book_inloop.lat) {
        //   print(i);
        //   for (var j in book_inloop.long) {
        //     print(j);
        // double distanceInMeters = Geolocator.distanceBetween(_currentPosition!.latitude, _currentPosition!.longitude, i, j);
        //     if (distanceInMeters <= 2) {
        //       print("yes");
        //     } else {
        //       print("no");
        //     }
        //   }
        // }
      }
    }
    return book;
  }

  Future < List < Book >> checkIsInMarker() async {
    var dio = Dio();
    var data = await dio.get(path);
    var jsonData = data.data;
    // print(jsonData);
    List < Book > book = [];

    if (jsonData['status'] == "error") {
      //pop up แจ้งเตือนว่า การทำงานผิดพลาด
    } else {
      count = jsonData['data'].length;
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high);
      double position1 = position.latitude;
      double position2 = position.longitude;
      // print("count $count");

      for (var u in jsonData['data']) {
        Book book_inloop = Book();

        book_inloop.name = u['name'];
        book_inloop.img_cover = u['img_cover'];
        book_inloop.book_content = u['book_content'];
        book_inloop.book_id = u['book_id'];
        book_inloop.lat = u['lat'];
        book_inloop.long = u['long'];
        if (Geolocator.distanceBetween(position1, position2, double.parse(book_inloop.lat), double.parse(book_inloop.long)) as double <= 20.0) {
          print(book_inloop.book_id);
          print("yes");
          Future < void > routePath() async {
            print('object');
            var dio = Dio();
            var data = await dio.post(route_path);
            var jsonData = data.data;

            final body = ({
              'user_id': box.read('user_id'),
              'book_id': book_inloop.book_id
            });
            print(box.read('user_id'));
            print(book_inloop.book_id);
          }
          setState(() {
            container = true;
          });
        } else {
          print("no");
        }

        // book_inloop.images = u['images'];
        // print(book_inloop.images);
        // print( book_inloop.book_id);


        book.add(book_inloop);
      }
    }
    return book;
  }

  Future < void > plusPoint() async {
    final body = ({
      'user_id': box.read('token1')
    });
    // print(body);

    var dio = Dio();
    var data = await dio.patch(url.url + 'users/pluspoint', data: body);
    var jsonData = data.data;

    if (jsonData['status'] == 'success') {
      // print('plus');
      // print(jsonData['data1']);
    }
  }

  bool isInSelectedArea = true;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future < void > openGoogleMaps(double latitude, double longitude) async {
    final url =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Google Maps';
    }
  }
  Position ? _currentPosition;
  // final double circleLat = 13.7459353;
  // final double circleLong = 100.5352072;
  // final double circleRadius = 50;

  // Get current location using Geolocator

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: geo.LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      // checkIsInMarker();
      print(_currentPosition);
    });
  }


  GoogleMapController ? mapController;

  Location _locationController = new Location();

  late Position _userLocation;

  LocationData ? currentLocation;

  // fromBook() {
  //   if (lat == 13.7563 && long == 100.5018) {
  //     LatLng notFrombook = LatLng(13.7563, 100.5018);
  //   } else {
  //     LatLng fromBook = LatLng(0, 0);
  //   }
  // }

  // late String lat;
  // late String long;

  // static const LatLng customLocation = LatLng(13.848043, 100.541085); // at44
  // double distanceInMeters = Geolocator.distanceBetween(_);
  bool container = false;

  @override
  void initState() {
    super.initState();
    checkIsInMarker();

    // print(currentLocation);
    // _getCurrentLocation();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      body: FutureBuilder(
        future: checkApi(),
        builder: (BuildContext context, AsyncSnapshot < dynamic > snapshot) {
          if (!snapshot.hasData) {
            return Container(
              color: Colors.white,
              height: 500,
              width: 500,
              child: SpinKitCubeGrid(
                color: Colors.blueGrey,
                size: 65,
              ),
            );
          } else {
            // bool withinCircle = isWithinAnyCircle(snapshot.data);
            return Stack(
              children: [
                GoogleMap(
                  mapType: MapType.normal,
                  mapToolbarEnabled: false,
                  trafficEnabled: true,
                  tiltGesturesEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(13.7563, 100.5018), zoom: 13.5),
                  markers: {
                    for (int index = 0; index < count; index++)...[
                      Marker(
                        markerId: MarkerId("Yote" + index.toString()),
                        icon: BitmapDescriptor.defaultMarker,
                        position: LatLng(double.parse(snapshot.data[index].lat),
                          double.parse(snapshot.data[index].long)),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return ListView(children: [
                                Container(
                                  height: 350,
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Flexible(
                                        child: Container(
                                          height: double.infinity,
                                          width: double.infinity,
                                          child: Image.network(
                                            url.url +
                                            snapshot.data[index].img_cover,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                      Row(
                                        children: [
                                          Padding(padding: EdgeInsets.all(20)),
                                          Text(
                                            snapshot.data[index].name,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                            // textAlign: ,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          //Go To position box Box
                                          Flexible(
                                            child: GestureDetector(
                                              onTap: () {
                                                // Test
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(builder: (context) => AccountPage()),
                                                // );
                                                openGoogleMaps(
                                                  double.parse(snapshot
                                                    .data[index].lat),
                                                  double.parse(snapshot
                                                    .data[index].long));
                                              },
                                              child: Container(
                                                height: 75,
                                                width: 400,
                                                margin: EdgeInsets.fromLTRB(
                                                  5, 10, 5, 10),
                                                decoration: BoxDecoration(
                                                  color: Colors.blueGrey[300],
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: ListTile(
                                                    leading: Icon(
                                                      Icons.location_on,
                                                      size: 28,
                                                      color: Colors.black,
                                                    ),
                                                    title: Text("Location",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color:
                                                        Colors.black)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),

                                          //Right Box
                                          Flexible(
                                            child: GestureDetector(
                                              onTap: () {
                                                // Test
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                    SeaLife(

                                                      name: snapshot
                                                      .data[index]
                                                      .name,
                                                      book_id: snapshot
                                                      .data[index]
                                                      .book_id,
                                                      img_cover: snapshot
                                                      .data[index]
                                                      .img_cover,
                                                      book_content: snapshot
                                                      .data[index]
                                                      .book_content,
                                                      lat: snapshot
                                                      .data[index]
                                                      .lat,
                                                      long: snapshot
                                                      .data[index]
                                                      .long,
                                                      images: snapshot
                                                      .data[index]
                                                      .images,
                                                    )
                                                  )
                                                );
                                              },
                                              child: Container(
                                                height: 75,
                                                width: 400,
                                                margin: EdgeInsets.fromLTRB(
                                                  5, 10, 5, 10),
                                                padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                                decoration: BoxDecoration(
                                                  color: Colors.blueGrey[300],
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                ),
                                                child: Center(
                                                  child: ListTile(
                                                    leading: Icon(
                                                      Icons.book,
                                                      size: 28,
                                                      color: Colors.black,
                                                    ),
                                                    title: Text("Go to book!",
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                        color:
                                                        Colors.black)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ]);
                            },
                          );
                        },
                      ),
                    ],
                  },
                  circles: {
                    for (int index = 0; index < count; index++)...[
                      Circle(
                        circleId: CircleId("circleId" + index.toString()),
                        center: LatLng(double.parse(snapshot.data[index].lat),
                          double.parse(snapshot.data[index].long)),
                        radius: 15,
                        strokeWidth: 2,
                        fillColor: Colors.blueAccent.withOpacity(0.2)),
                    ]
                  },
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),

                if (container)
                  GestureDetector(
                    onTap: () {
                      checkIn();
                      setState(() {
                        container = false;
                      });
                    },
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.blueGrey[900],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Center(
                          child: Text(
                            "แตะเพื่อเช็คอิน !",
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ))
                      ),
                    ),
                  ),

              ],
            );
          }
        },
      ),
    );
  }

  Future < void > getLocationUpdate() async {
    print("getlocation");
    bool _serviceEnable;
    PermissionStatus _permissionGranted;

    _serviceEnable = await _locationController.serviceEnabled();
    if (_serviceEnable) {
      print("serviceEnable");
      _serviceEnable = await _locationController.requestService();
    } else {
      print("else");
      return;
    }
    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    _locationController.onLocationChanged
      .listen((LocationData currentLocation) {
        if (currentLocation.latitude != null &&
          currentLocation.longitude != null) {
          setState(() {
            _userLocation =
              LatLng(currentLocation.latitude!, currentLocation.longitude!)
            as Position;
            // print(_userLocation);
          });
        }
      });
  }
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(DiagnosticsProperty<GoogleMapController>('mapController', mapController));
  // }
}