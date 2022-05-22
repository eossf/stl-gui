import 'package:google_maps_flutter/google_maps_flutter.dart';

class Screen {
  Screen._();
  static const String home = '/';
  static const String login = home + 'login';
  static const String viewtrack = home + 'viewtrack';
  static const String tracksList = home + 'trackslist';
  static const String googleMaps = home + 'googlemaps';
}

class Latlng {
  static const LatLng defaultLatLng = LatLng(46.186673,6.290673);
}
