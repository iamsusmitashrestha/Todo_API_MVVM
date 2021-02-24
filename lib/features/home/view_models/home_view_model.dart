import 'package:Todo_API_MVVM/core/routes/auto_router.gr.dart';
import 'package:Todo_API_MVVM/core/services/local_storage_service.dart';
import 'package:Todo_API_MVVM/core/utils/show_custom_bottom_sheet.dart';
import 'package:Todo_API_MVVM/features/home/models/todo.dart';
import 'package:Todo_API_MVVM/features/home/sub_views/add_todo_bottom_sheet.dart';
import 'package:Todo_API_MVVM/features/home/sub_views/delete_todo_bottom_sheet.dart';
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
      var response = await _dio.get("/todo",
          options: Options(headers: {
            'Authorization': "Bearer ${_localStorageService.read('token')}"
          }));
      todos = response.data.map<Todo>((item) => Todo.fromJson(item)).toList();
      setBusy(false);
    } on DioError catch (e) {
      setError("Something went wrong !");
      setBusy(false);
      if (e.type == DioErrorType.DEFAULT) {
        _snackbarService.showSnackbar(
            message: "Please check your internet connection.");
      } else if (e.type == DioErrorType.RESPONSE) {
        print(e.message);
        if (e.response.statusCode == 401 || e.response.statusCode == 403) {
          _snackbarService.showSnackbar(message: e.response.data['message']);
        } else {
          String message = "";
          for (var error in e.response.data['errors']) {
            message = message + error + "\n";
          }
          _snackbarService.showSnackbar(message: message.trim());
        }
      }
    }
  }

  void deleteTodo(int index) async {
    SheetResponse response = await showCustomBottomSheet(
      widget: DeleteTodoBottomSheet(),
    );

    try {
      setBusy(true);
      if (response != null && response.confirmed) {
        var response = await _dio.delete("/todo/${todos[index].id}",
            options: Options(headers: {
              'Authorization': "Bearer ${_localStorageService.read('token')}"
            }));
        todos.removeAt(index);
        notifyListeners();
      }
      setBusy(false);
    } on DioError catch (e) {
      setBusy(false);
      if (e.type == DioErrorType.DEFAULT) {
        _snackbarService.showSnackbar(
            message: "Please check your internet connection.");
      } else if (e.type == DioErrorType.RESPONSE) {
        print(e.message);
        if (e.response.statusCode == 401 || e.response.statusCode == 403) {
          _snackbarService.showSnackbar(message: e.response.data['message']);
        } else {
          String message = "";
          for (var error in e.response.data['errors']) {
            message = message + error + "\n";
          }
          _snackbarService.showSnackbar(message: message.trim());
        }
      }
    }

    if (response != null && response.confirmed) {
      todos.removeAt(index);
      notifyListeners();
    }
  }

  void logout() {
    _localStorageService.clear("token");
    _navigationService.replaceWith(Routes.loginView);
  }
}
