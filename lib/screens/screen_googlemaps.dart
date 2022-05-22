import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:stlgui/models/detail.dart';
import 'package:stlgui/constants.dart' as Constants;

class ScreenGoogleMaps extends StatefulWidget {
  const ScreenGoogleMaps({Key? key}) : super(key: key);

  @override
  _ScreenGoogleMapsState createState() => _ScreenGoogleMapsState();
}

class _ScreenGoogleMapsState extends State<ScreenGoogleMaps> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  LatLng startLocation = LatLng(46.184416227042675018310546875,6.26998200081288814544677734375);
  LatLng _trackPosition = Constants.Latlng.defaultLatLng;

  @override
  void initState() {
    addMarkers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  addMarkers() async {
    BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(
        size: Size(35, 35),
      ),
      "assets/starting-point.png",
    );

    markers.add(
        Marker( //add start location marker
          markerId: MarkerId("starting-point"),
          position: startLocation, //position of marker
          infoWindow: InfoWindow( //popup info
            title: 'Starting Point ',
            snippet: 'Start Marker',
          ),
          icon: markerbitmap,
        )
    );

    setState(() {
      //refresh UI
    });
  }

  @override
  Widget build(BuildContext context) {
    var events = context.read<DetailModel>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            if (!events.isEmpty()) {
              events.clear();
            }
            Navigator.of(context).pop();
          },
        ),
        title: Text('Your current location'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: GoogleMap(
        onMapCreated: (controller) { //method called when map is created
          setState(() {
            mapController = controller;
          });
        },
        initialCameraPosition: CameraPosition(
          target: startLocation,
          zoom: 13.0,
        ),
        markers: markers,
        mapToolbarEnabled: true,
        buildingsEnabled: false,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        mapType: MapType.terrain,
      ),
    );
  }
}