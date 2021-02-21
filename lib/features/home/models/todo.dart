import 'package:flutter/material.dart';

class Todo {
  final String title;
  final DateTime date;
  final TimeOfDay time;
  // bool done;

  Todo({this.title, this.date, this.time});

  Todo.fromJson(Map<String, dynamic> parsedJson)
      : title = parsedJson['title'],
        date = DateTime.parse(parsedJson['date']),
        // done = parsedJson['done'] == "true",
        time = TimeOfDay.fromDateTime(DateTime.parse(parsedJson['time']));
}
