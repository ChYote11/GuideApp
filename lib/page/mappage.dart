// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'dart:ffi';
import 'package:location/location.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatefulWidget {
  const MapPage({
    super.key
  });

  @override
  State < MapPage > createState() => _MapPageState();
}

class _MapPageState extends State < MapPage > {
  final Completer < GoogleMapController > _controller =
  Completer < GoogleMapController > ();

  Location _locationController = new Location();

  static
  const LatLng _pGooglePlex = LatLng(13.7563, 100.5018);

  LatLng ? _currentPosition;

  static
  const CameraPosition _bangkok = CameraPosition(
    target: LatLng(13.7563, 100.5018),
    zoom: 14.474,
  );
  @override
  void initState() {
    super.initState();
    getLocationUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: CameraPosition(target: _pGooglePlex,
          zoom: 14),

        markers: {
          Marker(markerId: MarkerId("_currentLocation"),
            icon: BitmapDescriptor.defaultMarker,
            position: _pGooglePlex, )
        },
      ),
    );
  }
  Future < void > getLocationUpdate() async {
    bool _serviceEnable;
    PermissionStatus _permissionGranted;

    _serviceEnable = await _locationController.serviceEnabled();
    if (_serviceEnable) {
      _serviceEnable = await _locationController.requestService();
    } else {
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
          _currentPosition = LatLng(currentLocation.latitude!, currentLocation.longitude!);
          print(_currentPosition);

        });
      }
    });
  }
}