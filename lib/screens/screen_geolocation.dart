import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ScreenGeolocation extends StatefulWidget {
  const ScreenGeolocation({ Key? key }) : super(key: key);

  @override
  State<ScreenGeolocation> createState() => _ScreenGeolocation();
}

class _ScreenGeolocation extends State<ScreenGeolocation> {
  var locationText = 'Click me for location';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
              onPressed: (){},
              child: Text('Loading...position')),
          const SizedBox(height: 30),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () async {
                    Position _currentPosition = await Geolocator.getCurrentPosition();
                    locationText =  '${_currentPosition.latitude.toString()}, ${_currentPosition.longitude.toString()}';
                  },
                  child: Text(locationText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}