import 'package:Todo_API_MVVM/common/widgets/ui_helpers.dart';
import 'package:flutter/material.dart';

class KTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  KTextField({this.controller, this.obscureText = false, this.keyboardType});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        keyboardType: keyboardType,
        obscureText: obscureText,
        controller: controller,
        decoration: InputDecoration(
          contentPadding: sXPadding,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
            ),
          ),
        ),
      ),
    );
  }
}
