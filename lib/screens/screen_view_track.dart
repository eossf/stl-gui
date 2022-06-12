import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stlgui/models/detail.dart';

class ScreenViewTrack extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var events = context.read<DetailModel>();
    var trackName = !events.isEmpty() ? events.tracks.first.name : " - ";
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
    //var trackNameStyle = Theme.of(context).textTheme.headline6;
    var detail = context.read<DetailModel>();
    var trackName =  !detail.isEmpty() ? detail.tracks.first.name : '';

    return ListView(
      children: const <Widget>[
        Card(
            child: ListTile(
          leading: FlutterLogo(),
          title: Text("Track Name"),
          )
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('One-line with leading widget'),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('One-line with trailing widget'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(),
            title: Text('One-line with both widgets'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            title: Text('One-line dense ListTile'),
            dense: true,
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 56.0),
            title: Text('Two-line ListTile'),
            subtitle: Text('Here is a second line'),
            trailing: Icon(Icons.more_vert),
          ),
        ),
        Card(
          child: ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text('Three-line ListTile'),
            subtitle: Text(
                'A sufficiently long subtitle warrants three lines.'
            ),
            trailing: Icon(Icons.more_vert),
            isThreeLine: true,
          ),
        ),
      ],
    );
    /*return ListView.builder(
      itemCount: detail.tracks.length,
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.done),
        title: Text(
          detail.tracks[index].name,
          style: trackNameStyle,
        ),
      ),
    );*/
  }
}

class _DetailBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var hugeStyle = Theme.of(context).textTheme.headline1!.copyWith(fontSize: 24);
    var detail = context.read<DetailModel>();
    var steps = "Number of Steps: " + detail.tracks[0].steps.toString();
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
