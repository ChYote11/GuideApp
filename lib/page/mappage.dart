
// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:guideapp/book/book1.dart';
import 'package:guideapp/components/constants.dart';
import 'package:guideapp/page/Account/accountpage.dart';
import 'package:guideapp/page/bookpage.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher/url_launcher.dart';


class MapPage extends StatefulWidget {
  const MapPage({
    super.key
  });

  @override
  State < MapPage > createState() => _MapPageState();
}

final Set < Marker > _markers = {};

class _MapPageState extends State < MapPage > {
  // final Completer < GoogleMapController > _controller =
  // Completer < GoogleMapController > ();

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> openGoogleMaps(double latitude, double longitude) async {
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

  //   _openOnGoogleMapApp(double latitude, double longitude) async {
  //   String googleUrl =
  //       'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  //   if (await canLaunch(googleUrl)) {
  //     await launch(googleUrl);
  //   } else {
  //     // Could not open the map.
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

  static
  // const LatLng _at44 = LatLng(13.848096721235768, 100.54108205889553);
  // static LatLng _bangkok = LatLng(13.7563, 100.5018);
  List<dynamic> _bangkok  = [ LatLng(13.7563, 100.5018), LatLng(13.848096721235768, 100.54108205889553)]; 

  List<String> imageFile = ["image/WatPhraKaew11.jpg","image/IMG_7237.jpg"];


  List < LatLng > polylineCoordinates = [];

  List < LatLng > decodePolyline(String encoded) {
    var poly = PolylinePoints().decodePolyline(encoded);
    return poly.map((point) => LatLng(point.latitude, point.longitude)).toList();
  }

  // LocationData? currentLocation;

  // void getCurrentLocation(){
  //   Location location = Location();

  //   location.getLocation().then((location){
  //     currentLocation = location;
  //   } );
  // }

  void getPolypoint() async {
    PolylinePoints polylinePoints = PolylinePoints();
    print("b4");
    // google_api_key is problem!!!!!!!! 
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      google_Api_Key,
      PointLatLng(_userLocation.latitude, _userLocation.longitude),
      PointLatLng(_userLocation.latitude, _userLocation.longitude));
    print("asd");
    //google_api_key is problem!!!!!!!!
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng points) => polylineCoordinates.add(
        LatLng(points.latitude, points.longitude),
      ), );
      setState(() {

      });
    }
    print('after');
  }

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

  @override
  void initState() {
    super.initState();
    // getLocationUpdate();
    // getPolypoint();
    // _createMarkerImageFromAsset(context);
    // getCurrentLocation();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        // mapToolbarEnabled: true,
        trafficEnabled: true,
        tiltGesturesEnabled: true,
        // myLocationButtonEnabled: true,
        compassEnabled: true,
        initialCameraPosition: CameraPosition(target: _bangkok[0],
          zoom: 13.5),
        // polylines: {
        //   Polyline(polylineId: PolylineId("route"),
        //     points: polylineCoordinates,
        //     color: Colors.blue,
        //     width: 7,
        //   )
        // },
        

        markers: {
          for (int i = 0 ; i < 2 ; i++)...[
            Marker(
            markerId: MarkerId("jfgiqefiu" + i.toString()),
            icon: BitmapDescriptor.defaultMarker,
            position: _bangkok[i],
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
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(imageFile[i]),
                                    fit: BoxFit.cover)
                                ),
                              )
                            ),
                            Row(children: [
                              Padding(padding: EdgeInsets.all(20)),
                              Text(
                                "Descirption",
                                style: TextStyle(
                                  fontSize: 30,
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
                                      openGoogleMaps(_bangkok[i].latitude, _bangkok[i].longitude);    
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
                                        context,
                                        MaterialPageRoute(builder: (context) => Book1()),
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
            },)
          ],    
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