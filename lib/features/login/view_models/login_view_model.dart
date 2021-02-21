import 'package:Todo_API_MVVM/core/routes/auto_router.gr.dart';
import 'package:Todo_API_MVVM/core/services/local_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class LoginViewModel extends BaseViewModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final Dio _dio;
  final SnackbarService _snackbarService;
  final NavigationService _navigationService;
  final LocalStorageService _localStorageService;
  LoginViewModel(this._navigationService, this._snackbarService, this._dio,
      this._localStorageService);

  void initialise() {}

  void onLogin() async {
    try {
      setBusy(true);
      var response = await _dio.post("/auth/login", data: {
        'email': emailController.text,
        'password': passwordController.text,
      });
      setBusy(false);
      _snackbarService.showSnackbar(message: response.data['message']);
      _localStorageService.save("token", response.data['token']);
      _navigationService.replaceWith(Routes.homeView);
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

  void goToRegister() {
    _navigationService.navigateTo(Routes.registerView);
  }
}
