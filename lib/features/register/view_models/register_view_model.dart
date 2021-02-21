import 'package:Todo_API_MVVM/core/routes/auto_router.gr.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class RegisterViewModel extends BaseViewModel {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final NavigationService _navigationService;
  final SnackbarService _snackbarService;
  final Dio _dio;

  RegisterViewModel(this._navigationService, this._snackbarService, this._dio);

  void initialise() {}

  void onRegister() async {
    try {
      var response = await _dio.post("/auth/register", data: {
        'name': nameController.text,
        'email': emailController.text,
        'password': passwordController.text,
      });
      _snackbarService.showSnackbar(message: response.data['message']);
      goToLogin();
    } on DioError catch (e) {
      if (e.type == DioErrorType.DEFAULT) {
        _snackbarService.showSnackbar(
            message: "Please check your internet connection.");
      } else if (e.type == DioErrorType.RESPONSE) {
        String message = "";
        for (var error in e.response.data['errors']) {
          message = message + error + "\n";
        }
        _snackbarService.showSnackbar(message: message.trim());
      }
    }
  }

  void goToLogin() {
    _navigationService.navigateTo(Routes.loginView);
  }
}
