import 'package:flutter/material.dart';

class Track {
  final int id;
  final String name;
  final String author;
  final int steps;
  final Color color;

  Track({
    required this.id,
    required this.name,
    required this.author,
    required this.steps,
  }) : color = Colors.primaries[id % Colors.primaries.length];

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'],
      name: json['name'],
      author: json['author'],
      steps: json['steps'],
    );
  }
}
