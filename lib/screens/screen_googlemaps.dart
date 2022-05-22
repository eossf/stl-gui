import 'package:flutter/material.dart';
import 'package:stlgui/models/detail.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants.dart' as Constants;

class ScreenGoogleMaps extends StatelessWidget {
  // current position or track starting position
  final Set<Marker> _markers = {};
  final LatLng _trackPosition = Constants.Latlng.defaultLatLng;
  LatLng? _lastMapPosition;

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
        title: Text('GoogleMaps'),
        centerTitle: true,
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _trackPosition,
            zoom: 11.0,
          ),
          markers: _markers,
          mapType: MapType.terrain,
        ),
    );
  }
}