import 'package:flutter/material.dart';

class Task {
  final String taskID;
  //final String date;
  final String title;
  final String content;

  Task({this.title, @required this.content, @required this.taskID});

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      //date: json['date'],
      title: json['title'],
      content: json['content'],
      taskID: json['taskID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      //'date': date,
      'title': title,
      'content': content,
      'taskID': taskID,
    };
  }
}
