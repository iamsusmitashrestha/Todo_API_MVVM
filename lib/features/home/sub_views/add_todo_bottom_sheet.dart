import 'package:Todo_API_MVVM/common/widgets/k_bottom_sheet.dart';
import 'package:Todo_API_MVVM/common/widgets/k_date_picker.dart';
import 'package:Todo_API_MVVM/common/widgets/k_label.dart';
import 'package:Todo_API_MVVM/common/widgets/k_outline_button.dart';
import 'package:Todo_API_MVVM/common/widgets/k_primary_button.dart';
import 'package:Todo_API_MVVM/common/widgets/k_text_field.dart';
import 'package:Todo_API_MVVM/common/widgets/k_time_picker.dart';
import 'package:Todo_API_MVVM/common/widgets/ui_helpers.dart';
import 'package:Todo_API_MVVM/core/di/injection.dart';
import 'package:Todo_API_MVVM/features/home/view_models/add_todo_bottom_sheet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddTodoBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddTodoBottomSheetViewModel>.reactive(
      viewModelBuilder: () => locator<AddTodoBottomSheetViewModel>(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => KBottomSheet(
        children: [
          KLabel(
            text: "Todo",
          ),
          xsHeightSpan,
          KTextField(
            controller: model.todoController,
          ),
          sHeightSpan,
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KLabel(
                      text: "Date",
                    ),
                    xsHeightSpan,
                    KDatePicker(onDatePicked: model.setDate),
                  ],
                ),
              ),
              mWidthSpan,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    KLabel(
                      text: "Time",
                    ),
                    xsHeightSpan,
                    KTimePicker(onTimePicked: model.setTime),
                  ],
                ),
              ),
            ],
          ),
          sHeightSpan,
          Row(
            children: [
              Expanded(
                child: KOutlineButton(
                  text: "Cancel",
                  onPressed: model.cancel,
                ),
              ),
              mWidthSpan,
              Expanded(
                child: KPrimaryButton(
                  text: "Done",
                  isBusy: model.isBusy,
                  onPressed: model.addTodo,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
