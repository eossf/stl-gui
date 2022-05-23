import 'package:google_maps_flutter/google_maps_flutter.dart';

class Screen {
  Screen._();
  static const String home = '/';
  static const String login = home + 'login';
  static const String viewtrack = home + 'viewtrack';
  static const String tracksList = home + 'trackslist';
  static const String googleMaps = home + 'googlemaps';
  static const String geolocation = home + 'geolocation';
}

class Latlng {
  static const LatLng defaultLatLng = LatLng(46.184416227042675018310546875,6.26998200081288814544677734375);
}
