import 'dart:core';

import 'package:stlgui/models/track.dart';

class EventsModel {
  List<Track> listTracks;

  EventsModel(this.listTracks);

  Track getById(int id) => listTracks.where((element) => element.id == id).first;

  Track getByPosition(int position) {
    return listTracks[position];
  }

  int size() {
    return listTracks.length;
  }
}
