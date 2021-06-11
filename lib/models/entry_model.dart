import 'package:flutter/material.dart';

class Entry {
  final String entryID;
  final String date;
  final String entry;

  Entry({this.date, this.entry, @required this.entryID});

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      date: json['date'],
      entry: json['entry'],
      entryID: json['entryID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'entry': entry,
      'entryID': entryID,
    };
  }
}
