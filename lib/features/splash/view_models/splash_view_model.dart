import 'package:Todo_API_MVVM/core/routes/auto_router.gr.dart';
import 'package:Todo_API_MVVM/core/services/local_storage_service.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

@injectable
class SplashViewModel extends BaseViewModel {
  final LocalStorageService _localStorageService;
  final NavigationService _navigationService;

  SplashViewModel(this._localStorageService, this._navigationService);

  void initialise() {
    Future.delayed(Duration(milliseconds: 1000), () {
      String token = _localStorageService.read("token");
      if (token != null) {
        _navigationService.replaceWith(Routes.homeView);
      } else {
        _navigationService.replaceWith(Routes.loginView);
      }
    });
  }
}
