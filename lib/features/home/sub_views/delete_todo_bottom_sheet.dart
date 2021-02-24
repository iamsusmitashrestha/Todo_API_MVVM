import 'package:Todo_API_MVVM/common/widgets/k_bottom_sheet.dart';
import 'package:Todo_API_MVVM/common/widgets/k_outline_button.dart';
import 'package:Todo_API_MVVM/common/widgets/k_primary_button.dart';
import 'package:Todo_API_MVVM/common/widgets/ui_helpers.dart';
import 'package:Todo_API_MVVM/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class DeleteTodoBottomSheetViewModel extends ChangeNotifier {
  final NavigationService _navigationService;
  DeleteTodoBottomSheetViewModel(this._navigationService);

  void confirm() {
    _navigationService.back(
      result: SheetResponse(confirmed: true, responseData: "Deleted todo"),
    );
  }

  void cancel() {
    _navigationService.back(
      result: SheetResponse(confirmed: false, responseData: "Deleted todo"),
    );
  }
}

class DeleteTodoBottomSheet
    extends ViewModelBuilderWidget<DeleteTodoBottomSheetViewModel> {
  @override
  bool get reactive => true;

  @override
  Widget builder(
    BuildContext context,
    DeleteTodoBottomSheetViewModel viewModel,
    Widget child,
  ) {
    return KBottomSheet(
      children: [
        Text(
          "Do you want to delete ?",
          style: Theme.of(context)
              .textTheme
              .subtitle1
              .copyWith(fontWeight: FontWeight.bold),
        ),
        mHeightSpan,
        Row(
          children: [
            Expanded(
              child: KOutlineButton(
                text: "No",
                onPressed: viewModel.cancel,
              ),
            ),
            mWidthSpan,
            Expanded(
              child: KPrimaryButton(
                onPressed: viewModel.confirm,
                text: "Yes",
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  DeleteTodoBottomSheetViewModel viewModelBuilder(BuildContext context) =>
      locator<DeleteTodoBottomSheetViewModel>();
}
