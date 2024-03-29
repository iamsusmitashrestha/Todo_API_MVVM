import 'package:Todo_API_MVVM/common/configs/app_config.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

@module
abstract class ThirdPartyServices {
  @lazySingleton
  NavigationService get navigationService;
  @lazySingleton
  DialogService get dialogService;
  @lazySingleton
  SnackbarService get snackBarService;
  @lazySingleton
  BottomSheetService get bottomSheetService;
  @injectable
  Dio get dio {
    Dio dioInstance = Dio();

    dioInstance.options.baseUrl = AppConfig.BASE_URL;

    return dioInstance;
  }
}
