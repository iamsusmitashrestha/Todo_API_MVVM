import 'package:flutter/material.dart';

class KLabel extends StatelessWidget {
  final String text;
  KLabel({this.text});
  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.subtitle2);
  }
}
