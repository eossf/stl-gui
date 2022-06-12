import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:stlgui/models/detail.dart';
import 'package:geolocator/geolocator.dart';

class ScreenGoogleMaps extends StatefulWidget {
  const ScreenGoogleMaps({Key? key}) : super(key: key);

  @override
  _ScreenGoogleMapsState createState() => _ScreenGoogleMapsState();
}

class _ScreenGoogleMapsState extends State<ScreenGoogleMaps> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  late Position _currentPosition;
  CameraPosition _cameraPosition = CameraPosition(target: LatLng( 46.177974,6.270123), zoom: 13);
  LatLng _markerStart = LatLng( 46.177974,6.270123);

  @override
  void initState() {
    getCurrentPosition();
    addMarkers();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getCurrentPosition() {
    Geolocator.getCurrentPosition().then((value) => _currentPosition = value);
  }

  Future<void> addMarkers() async {
    BitmapDescriptor bitmapDescriptor = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(35, 35)),"assets/starting-point.png");

    markers.add(
        Marker( //add start location marker
          markerId: MarkerId("starting-point"),
          position: _markerStart, // LatLng(_currentPosition.latitude, _currentPosition.longitude),
          infoWindow: InfoWindow( //popup info
            title: 'Your current location',
            snippet: 'Start Marker',
          ),
          icon: bitmapDescriptor,
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
        initialCameraPosition: _cameraPosition,
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