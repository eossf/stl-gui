import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:stlgui/common/theme.dart';
import 'package:stlgui/models/detail.dart';
import 'package:stlgui/models/events.dart';
import 'package:stlgui/screens/screen_view.dart';
import 'package:stlgui/screens/screen_events.dart';
// import 'package:stlgui/screens/screen_login.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/track.dart';

void main() async {
  await Future.wait([loadEnv()]);
  // after first init do the rest
  js.context["GOOGLE_MAPS_API_KEY"] = dotenv.env["GOOGLE_MAPS_API_KEY"]!;
  html.document.dispatchEvent(html.CustomEvent("GOOGLE_MAPS_API_KEY_event"));
  runApp(MyApp(await fetchTracks()));
}

Future<void> loadEnv() async {
  await dotenv.load();
}

Future fetchTracks() async {
  var mainUrl = dotenv.env["HOST_PROTOCOL"]! + '://' + dotenv.env["HOST_SERVER"]! + ':' + dotenv.env["HOST_PORT"]!;
  final response = await http.get(Uri.parse(mainUrl + '/tracks'));
  if (response.statusCode == 200) {
    List<Track> lt = (json.decode(response.body) as List).map((i) => Track.fromJson(i)).toList();
    return lt;
  } else {
    throw Exception('Failed to load track');
  }
}

class MyApp extends StatelessWidget {
  final Set<Marker> _markers = {};
  List<Track> listTracks;
  static LatLng _center = LatLng(-15.4630239974464, 28.363397732282127);
  LatLng? _lastMapPosition;

  MyApp(this.listTracks);

  @override
  Widget build(BuildContext context) {
    // Using MultiProvider is convenient when providing multiple objects.
    return MultiProvider(
      providers: [
        Provider(create: (context) => EventsModel(listTracks)),
        ChangeNotifierProxyProvider<EventsModel, DetailModel>(
          create: (context) => DetailModel(),
          update: (context, events, detail) {
            if (detail == null) throw ArgumentError.notNull('detail');
            detail.events = events;
            return detail;
          },
        ),
      ],
//      View, Follow, Record, Live
      child: MaterialApp(
        title: 'Summit Tracks List',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            mapType: MapType.normal,
            markers: _markers,
            onCameraMove: (position) => _lastMapPosition = position.target,
          ),
//          '/': (context) => ScreenLogin(),
          '/events': (context) => ScreenEvents(listTracks),
          '/view': (context) => ScreenView(),
        },
      ),
    );
  }
}

enum PlaceCategory {
  favorite,
  visited,
  wantToGo,
}

