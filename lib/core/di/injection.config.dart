// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../features/home/view_models/add_todo_bottom_sheet_view_model.dart';
import '../../features/home/view_models/home_view_model.dart';
import '../services/local_storage_service.dart';
import '../../features/login/view_models/login_view_model.dart';
import '../../features/register/view_models/register_view_model.dart';
import '../../features/splash/view_models/splash_view_model.dart';
import 'third_party_services.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final thirdPartyServices = _$ThirdPartyServices();
  gh.lazySingleton<BottomSheetService>(
      () => thirdPartyServices.bottomSheetService);
  gh.lazySingleton<DialogService>(() => thirdPartyServices.dialogService);
  gh.factory<Dio>(() => thirdPartyServices.dio);
  gh.factory<LocalStorageService>(() => LocalStorageService());
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServices.navigationService);
  gh.lazySingleton<SnackbarService>(() => thirdPartyServices.snackBarService);
  gh.factory<SplashViewModel>(() =>
      SplashViewModel(get<LocalStorageService>(), get<NavigationService>()));
  gh.factory<AddTodoBottomSheetViewModel>(() => AddTodoBottomSheetViewModel(
        get<Dio>(),
        get<SnackbarService>(),
        get<NavigationService>(),
        get<LocalStorageService>(),
      ));
  gh.factory<HomeViewModel>(() => HomeViewModel(
        get<Dio>(),
        get<LocalStorageService>(),
        get<NavigationService>(),
        get<SnackbarService>(),
      ));
  gh.factory<LoginViewModel>(() => LoginViewModel(
        get<NavigationService>(),
        get<SnackbarService>(),
        get<Dio>(),
        get<LocalStorageService>(),
      ));
  gh.factory<RegisterViewModel>(() => RegisterViewModel(
        get<NavigationService>(),
        get<SnackbarService>(),
        get<Dio>(),
      ));
  return get;
}

class _$ThirdPartyServices extends ThirdPartyServices {
  @override
  BottomSheetService get bottomSheetService => BottomSheetService();
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackBarService => SnackbarService();
}
