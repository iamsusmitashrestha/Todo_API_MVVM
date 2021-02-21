import 'package:Todo_API_MVVM/common/widgets/ui_helpers.dart';
import 'package:flutter/material.dart';

class KTimePicker extends StatefulWidget {
  final Function(TimeOfDay) onTimePicked;
  KTimePicker({@required this.onTimePicked});
  @override
  _KTimePickerState createState() => _KTimePickerState();
}

class _KTimePickerState extends State<KTimePicker> {
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then((value) {
      var now = TimeOfDay.now();
      timeController.text = now.format(context);
      widget.onTimePicked(now);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        child: TextField(
          controller: timeController,
          enabled: false,
          decoration: InputDecoration(
            contentPadding: sXPadding,
            suffixIcon: Icon(Icons.access_time_outlined),
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
        TimeOfDay pickedTime = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());

        if (pickedTime == null) return;

        timeController.text = pickedTime.format(context);

        widget.onTimePicked(pickedTime);
      },
    );
  }
}
