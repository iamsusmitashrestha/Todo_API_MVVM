class Todo {
  final String id;
  final String text;
  final String dateTime;
  // bool done;

  Todo({this.id, this.dateTime, this.text});

  Todo.fromJson(Map<String, dynamic> parsedJson)
      : text = parsedJson['text'],
        dateTime = parsedJson['dateTime'],
        id = parsedJson['_id'];
}
