import 'package:Todo_API_MVVM/core/routes/auto_router.gr.dart';
import 'package:Todo_API_MVVM/core/services/local_storage_service.dart';
import 'package:Todo_API_MVVM/core/utils/show_custom_bottom_sheet.dart';
import 'package:Todo_API_MVVM/features/home/models/todo.dart';
import 'package:Todo_API_MVVM/features/home/sub_views/add_todo_bottom_sheet.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class HomeViewModel extends BaseViewModel {
  List<Todo> todos = [];
  final Dio _dio;
  final NavigationService _navigationService;
  final LocalStorageService _localStorageService;
  final SnackbarService _snackbarService;

  HomeViewModel(this._dio, this._localStorageService, this._navigationService,
      this._snackbarService);

  void initialise() {
    getTodo();
  }

  void addTodo() async {
    setBusy(true);
    SheetResponse response = await showCustomBottomSheet(
        widget: AddTodoBottomSheet(), isDismissible: false);
    if (response != null && response.confirmed) {
      // setBusy(true);
      getTodo();
      setBusy(false);
    }
  }

  void getTodo() async {
    try {
      setBusy(true);
      var response = await _dio.get("get/todo");
      print(response);
      setBusy(false);
    } on DioError catch (e) {
      setBusy(false);
      if (e.type == DioErrorType.DEFAULT) {
        _snackbarService.showSnackbar(
            message: "Please check your internet connection.");
      } else if (e.type == DioErrorType.RESPONSE) {
        print(e.message);
        String message = "";
        for (var error in e.response.data['errors']) {
          message = message + error + "\n";
        }
        _snackbarService.showSnackbar(message: message.trim());
      }
    }
  }

  void logout() {
    _localStorageService.clear("token");
    _navigationService.replaceWith(Routes.loginView);
  }
}
