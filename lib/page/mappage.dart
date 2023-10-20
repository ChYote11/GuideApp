// ignore_for_file: prefer_const_constructors, unused_element, unnecessary_new, prefer_final_fields, deprecated_member_use, no_leading_underscores_for_local_identifiers, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/state_manager.dart';
import 'package:guideapp/book/sealife.dart';
import 'package:guideapp/components/constants.dart';
import 'package:guideapp/model/book.dart';
import 'package:guideapp/page/Account/accountpage.dart';
import 'package:guideapp/page/bookpage.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_toolkit/maps_toolkit.dart'
as map_tool;
// import 'package:url_launcher/url_launcher.dart';


class MapPage extends StatefulWidget {
  const MapPage({
    super.key
  });

  @override
  State < MapPage > createState() => _MapPageState();
}




class _MapPageState extends State < MapPage > {
  // final Completer < GoogleMapController > _controller =
  // Completer < GoogleMapController > ();

  // bool isInArea = true;

  // void checkUpdateLocation(LatLng pointLatLng) async {
  //   var dio = Dio();
  //   var data = await dio.get(path);
  //   var jsonData = data.data;

  //   List < Book > book = [];

  //   for (var u in jsonData['data']) {
  //     Book book_inloop = Book();

  //     // book_inloop.name = u['name'];
  //     // book_inloop.img_cover = u['img_cover'];
  //     // book_inloop.book_content = u['book_content'];
  //     // book_inloop.book_id = u['book_id'];
  //     book_inloop.lat = u['lat'];
  //     book_inloop.long = u['long'];

  //     // book_inloop.images = u['images'];
  //     if (u['images'].isEmpty || u['images'] == null) {
  //       book_inloop.images = [];
  //     } else {
  //       book_inloop.images = u['images'];
  //       // print(u['images']);
  //     }
  //     // print(book_inloop.images);


  //     // print( book_inloop.book_id);

  //     book.add(book_inloop);
  //   }

  //   List < map_tool.LatLng > convatedPolygonPoints = [];

  //   isInArea = map_tool.PolygonUtil.containsLocation(
  //     map_tool.LatLng(pointLatLng.latitude, pointLatLng.longitude),
  //     book as List < map_tool.LatLng > ,
  //     false);
  // }

  int count = 0;
  String path = 'http://localhost:3000/books';

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
        // print(book_inloop.images);


        // print( book_inloop.book_id);

        book.add(book_inloop);
      }
    }
    return book;
  }





  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future < void > openGoogleMaps(double latitude, double longitude) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Google Maps';
    }
  }

  // Future < Position > _getLocation() async  {
  //   try {
  //     Position userLocation = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.best);
  //     return userLocation;
  //   } catch (e) {
  //     userLocation;
  //   }
  // }

  // late BitmapDescriptor _markerIcon;

  //   Future _createMarkerImageFromAsset(BuildContext context) async {
  //   if (_markerIcon == null) {
  //     ImageConfiguration configuration = ImageConfiguration();
  //     BitmapDescriptor bmpd = await BitmapDescriptor.fromAssetImage(
  //         configuration, 'lib/image/IMG_7237.JPG');
  //     setState(() {
  //       _markerIcon = bmpd;
  //     });
  //   }
  // }


  late GoogleMapController mapController;

  Location _locationController = new Location();

  late Position _userLocation;



  // List < LatLng > polylineCoordinates = [];

  // List < LatLng > decodePolyline(String encoded) {
  //   var poly = PolylinePoints().decodePolyline(encoded);
  //   return poly.map((point) => LatLng(point.latitude, point.longitude)).toList();
  // }

  // LocationData ? currentLocation;

  // void getCurrentLocation() {
  //   Location location = Location();

  //   location.getLocation().then((location) {
  //     currentLocation = location;
  //   });
  // }

  // void getPolypoint() async {
  //   PolylinePoints polylinePoints = PolylinePoints();
  //   print("b4");
  //   // google_api_key is problem!!!!!!!! 
  //   PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
  //     google_Api_Key,
  //     PointLatLng(_userLocation.latitude, _userLocation.longitude),
  //     PointLatLng(_userLocation.latitude, _userLocation.longitude));
  //   print("asd");
  //   //google_api_key is problem!!!!!!!!
  //   if (result.points.isNotEmpty) {
  //     result.points.forEach((PointLatLng points) => polylineCoordinates.add(
  //       LatLng(points.latitude, points.longitude),
  //     ), );
  //     setState(() {

  //     });
  //   }
  //   print('after');
  // }

  void _showContainer() {
    // Create and show a container when the marker is tapped.
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          color: Colors.white,
          child: Center(
            child: Text("Your content goes here"),
          ),
        );
      },
    );
  }

  late String lat;
  late String long; 

  @override
  void initState() {
    super.initState();
    // print(LatLng(double.parse(currentLocation!.latitude! as String) , double.parse(currentLocation!.longitude! as String)));
    // print(count.length);
    // getLocationUpdate();
    // getPolypoint();
    // _createMarkerImageFromAsset(context);
    // getCurrentLocation();

  }

  @override
  Widget build(BuildContext context, ) {
    return Scaffold(
      body: FutureBuilder(
        future: checkApi(),
        builder: (BuildContext context, AsyncSnapshot < dynamic > snapshot) {
          if (!snapshot.hasData) {
            return Container(color: Colors.blue,
              height: 100, );
          } else {
            return GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: true,
              // mapToolbarEnabled: true,
              trafficEnabled: true,
              tiltGesturesEnabled: true,
              // myLocationButtonEnabled: true,
              compassEnabled: true,
              initialCameraPosition: CameraPosition(target: LatLng(13.7563, 100.5018),
                zoom: 13.5),
              // polylines: {
              //   Polyline(polylineId: PolylineId("route"),
              //     points: polylineCoordinates,
              //     color: Colors.blue,
              //     width: 7,
              //   )
              // },
              markers: {
                for (int index = 0; index < count; index++)...[
                  Marker(
                    markerId: MarkerId("Yote" + index.toString()),
                    icon: BitmapDescriptor.defaultMarker,
                    position: LatLng(double.parse(snapshot.data[index].lat), double.parse(snapshot.data[index].long)),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return ListView(
                            children: [
                              Container(
                                height: 350,
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Flexible(
                                      child: Container(
                                        height: double.infinity,
                                        width: double.infinity,
                                        child: Image.asset(snapshot.data[index].img_cover,
                                          fit: BoxFit.cover, ),
                                      )
                                    ),
                                    Row(children: [
                                      Padding(padding: EdgeInsets.all(20)),
                                      Text(
                                        snapshot.data[index].name,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold
                                        ),
                                        // textAlign: ,
                                      ),
                                    ], ),
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
                                              openGoogleMaps(double.parse(snapshot.data[index].lat) ,double.parse(snapshot.data[index].long) );
                                            },
                                            child: Container(
                                              height: 75,
                                              width: 400,
                                              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                              decoration: BoxDecoration(
                                                color: Colors.greenAccent,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Center(
                                                child: ListTile(
                                                  leading: Icon(Icons.location_on,
                                                    size: 28,
                                                    color: Colors.black, ),
                                                  title: Text("Location",
                                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                                                      color: Colors.black)
                                                  ),
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
                                                context, MaterialPageRoute(
                                                  builder: (context) => SeaLife(
                                                    name: snapshot.data[index].name,
                                                    book_id: snapshot.data[index].book_id,
                                                    img_cover: snapshot.data[index].img_cover,
                                                    book_content: snapshot.data[index].book_content,
                                                    lat: snapshot.data[index].lat,
                                                    long: snapshot.data[index].long,
                                                    images: snapshot.data[index].images,

                                                  )
                                                )
                                              );
                                            },
                                            child: Container(
                                              height: 75,
                                              width: 400,
                                              margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                              decoration: BoxDecoration(
                                                color: Colors.greenAccent,
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: Center(
                                                child: ListTile(
                                                  leading: Icon(Icons.book,
                                                    size: 28,
                                                    color: Colors.black, ),
                                                  title: Text("Go to book!",
                                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,
                                                      color: Colors.black)
                                                  ),
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
                    center: LatLng(double.parse(snapshot.data[index].lat), double.parse(snapshot.data[index].long)),
                    radius: 100,
                    strokeWidth: 2,
                    fillColor: Colors.blueAccent.withOpacity(0.2)
                  ),
                ]
              },
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
    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null &&
        currentLocation.longitude != null) {
        setState(() {
          _userLocation = LatLng(currentLocation.latitude!, currentLocation.longitude!) as Position;
          print(_userLocation);
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