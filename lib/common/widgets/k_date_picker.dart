import 'package:Todo_API_MVVM/common/widgets/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class KDatePicker extends StatefulWidget {
  final Function(DateTime) onDatePicked;
  KDatePicker({@required this.onDatePicked});
  @override
  _KDatePickerState createState() => _KDatePickerState();
}

class _KDatePickerState extends State<KDatePicker> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    var now = DateTime.now();
    dateController.text = DateFormat("dd MMM, yyy").format(now);
    widget.onDatePicked(now);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: TextField(
          controller: dateController,
          enabled: false,
          decoration: InputDecoration(
            contentPadding: sXPadding,
            suffixIcon: Icon(Icons.calendar_today),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black12,
              ),
            ),
          ),
        ),
      ),
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        DateTime pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            Duration(days: 365),
          ),
        );
        if (pickedDate == null) return;

        dateController.text = DateFormat("dd MMM, yyy").format(pickedDate);

        widget.onDatePicked(pickedDate);
      },
    );
  }
}
