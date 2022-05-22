import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stlgui/models/detail.dart';
import 'package:provider/provider.dart';
import '../constants.dart' as Constants;

class ScreenGoogleMaps extends StatefulWidget {
  const ScreenGoogleMaps({Key? key}) : super(key: key);

  @override
  _ScreenGoogleMapsState createState() => _ScreenGoogleMapsState();
}

class _ScreenGoogleMapsState extends State<ScreenGoogleMaps> {
  late GoogleMapController mapController;
  Set<Marker> markers = {};
  LatLng _trackPosition = Constants.Latlng.defaultLatLng;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      markers.add(const Marker(
        markerId: MarkerId('starting-marker'),
        position: LatLng(46.184416227042675018310546875,6.26998200081288814544677734375),
        infoWindow: InfoWindow(
          title: 'Starting Point',
          snippet: 'Your track begin here',
        ),
      ));
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
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _trackPosition,
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