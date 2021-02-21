import 'package:Todo_API_MVVM/common/widgets/ui_helpers.dart';
import 'package:flutter/material.dart';

class KOutlineButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  KOutlineButton({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: OutlineButton(
        padding: mPadding,
        color: Theme.of(context).primaryColor,
        onPressed: onPressed,
        child: Text(
          text,
        ),
      ),
    );
  }
}
