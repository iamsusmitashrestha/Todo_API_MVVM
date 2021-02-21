import 'package:Todo_API_MVVM/core/services/local_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class AddTodoBottomSheetViewModel extends BaseViewModel {
  final TextEditingController todoController = TextEditingController();
  DateTime _selectedDate;
  TimeOfDay _selectedTime;

  final Dio _dio;
  final SnackbarService _snackbarService;
  final NavigationService _navigationService;
  final LocalStorageService _localStorageService;

  AddTodoBottomSheetViewModel(this._dio, this._snackbarService,
      this._navigationService, this._localStorageService);

  void initialise() {}

  void setDate(DateTime pickedDate) {
    _selectedDate = pickedDate;
  }

  void setTime(TimeOfDay pickedTime) {
    _selectedTime = pickedTime;
  }

  void addTodo() async {
    try {
      setBusy(true);
      var response = await _dio.post("/todo",
          data: {
            'text': todoController.text,
            'dateTime': new DateTime(_selectedDate.year, _selectedDate.month,
                    _selectedDate.day, _selectedTime.hour, _selectedTime.minute)
                .toIso8601String()
          },
          options: Options(headers: {
            'Authorization': "Bearer ${_localStorageService.read('token')}"
          }));
      setBusy(false);
      _navigationService.back(result: SheetResponse(confirmed: true));
      print(response);
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
  }

  void cancel() {
    _navigationService.back(result: SheetResponse(confirmed: false));
  }
}
