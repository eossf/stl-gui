import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class ScreenTest extends StatefulWidget {
  final String name;
  const ScreenTest({ Key? key, required this.name }) : super(key: key);

  @override
  State<ScreenTest> createState() => _ScreenTest();
}

class _ScreenTest extends State<ScreenTest> {
  int count = 0;
  var locationText = 'Click me for location';

  /* DONT REMOVE - EXAMPLE OF async determine position GPS / GeoLocator */
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ElevatedButton(
              onPressed: () async {
                //Instead of performing asynchronous work inside a call to setState(),
                // first execute the work (without updating the widget state),
                // and then synchronously update the state inside a call to setState().
                Position _currentPosition = await Geolocator.getCurrentPosition();
                setState(() {
                  locationText =  '${_currentPosition.latitude.toString()}, ${_currentPosition.longitude.toString()}';
                });
              },
              child: Text(locationText)),
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
                  onPressed: () { locationText = "search position";  },
                  child: Text(locationText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /* DONT REMOVE - EXAMPLE OF gesture
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap:() => {
        setState((){
          count--;
        })
      },
      onTap: (){
        setState((){
          count++;
        });
      },
    child:
      Text('${widget.name}: $count'),
    );
  }*/

}
