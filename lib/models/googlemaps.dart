import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsSTL {
  void _onMapCreated(GoogleMapController controller) {
    //mapController = controller;
    final marker = Marker(
      markerId: MarkerId('test'),
      position: LatLng(46.177974,6.270123),
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: 'title',
        snippet: 'address',
      ),
    );
  }
}
