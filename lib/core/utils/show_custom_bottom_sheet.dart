import 'package:Todo_API_MVVM/core/di/injection.dart';
import 'package:Todo_API_MVVM/core/stacked_widgets/custom_stacked_setup.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

Future<SheetResponse> showCustomBottomSheet(
    {Widget widget, bool isDismissible = true}) {
  BottomSheetService _bottomSheetService = locator<BottomSheetService>();

  return _bottomSheetService.showCustomSheet(
    customData: widget,
    variant: BottomSheetType.custom,
    barrierDismissible: isDismissible,
    isScrollControlled: true,
  );
}
