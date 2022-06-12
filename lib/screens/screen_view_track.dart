import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stlgui/models/detail.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ScreenViewTrack extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var events = context.read<DetailModel>();
    //var trackName = !events.isEmpty() ? events.tracks.first.name : " - ";
    var trackName = "test title";

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
        title: Text(trackName, style: Theme.of(context).textTheme.headline1),
        centerTitle: true,
        backgroundColor: Colors.yellow,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: _DetailList(),
              ),
            ),
            Divider(height: 4, color: Colors.black),
            _DetailBottom(),
          ],
        ),
      ),
    );
  }
}

class _DetailList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /*var trackNameStyle = Theme.of(context).textTheme.headline6;
    var detail = context.read<DetailModel>();
    var trackName =  !detail.isEmpty() ? detail.tracks.first.name : '<empty>';*/

    var trackName = "test";

    return Container(
      height: 16.0, // in logical pixels
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(color: Colors.black),
      // Row is a horizontal, linear layout.
      child: Row(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(target: LatLng(46.177974,6.270123), zoom: 13),
              mapToolbarEnabled: true,
              buildingsEnabled: false,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              mapType: MapType.terrain,
            )
          ),
        ],
      ),
    );
    /*ListView.builder(
        itemCount: detail.tracks.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.done),
          title: Text(
            detail.tracks[index].name,
            style: trackNameStyle,
          ),
        ),
      )*/
  }
}

class _DetailBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle = Theme.of(context).textTheme.headline1!.copyWith(fontSize: 24);
    //var detail = context.read<DetailModel>();
    //var steps = "Number of Steps: " + detail.tracks[0].steps.toString();
    var steps = "Number of Steps: 0";
    return SizedBox(
      height: 100,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<DetailModel>(builder: (context, detail, child) => Text(steps, style: hugeStyle)),
            SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}
