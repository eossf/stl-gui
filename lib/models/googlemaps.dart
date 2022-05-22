import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsSTL {
  void _onMapCreated(GoogleMapController controller) {
    //mapController = controller;
    final marker = Marker(
      markerId: MarkerId('test'),
      position: LatLng(46.184416227042675018310546875,6.26998200081288814544677734375),
      // icon: BitmapDescriptor.,
      infoWindow: InfoWindow(
        title: 'title',
        snippet: 'address',
      ),
    );
  }
}
