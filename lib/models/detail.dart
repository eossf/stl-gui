import 'package:flutter/foundation.dart';
import 'package:stlgui/models/events.dart';
import 'package:stlgui/models/track.dart';

class DetailModel extends ChangeNotifier {
  /// The private field backing [events].
  late EventsModel _events;

  /// Internal, private state of the detail. Stores the ids of each track.
  final List<int> _tracksIds = [];

  /// The current events. Used to construct tracks from numeric ids.
  EventsModel get events => _events;

  set events(EventsModel newEvents) {
    _events = newEvents;
    notifyListeners();
  }

  /// List of tracks in the detail.
  List<Track> get tracks => _tracksIds.map((id) => _events.getById(id)).toList();

  /// Adds [track] to detail. This is the only way to modify the detail from outside.
  void add(Track track) {
    _tracksIds.add(track.id);
    notifyListeners();
  }

  void remove(Track track) {
    _tracksIds.remove(track.id);
    notifyListeners();
  }

  void clear(){
    _tracksIds.clear();
    notifyListeners();
  }

  bool isEmpty() {
    return _tracksIds.isEmpty;
  }
}
