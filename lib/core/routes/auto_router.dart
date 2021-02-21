import 'package:Todo_API_MVVM/features/home/views/home_view.dart';
import 'package:Todo_API_MVVM/features/login/views/login_view.dart';
import 'package:Todo_API_MVVM/features/register/views/register_view.dart';
import 'package:Todo_API_MVVM/features/splash/views/splash_view.dart';
import 'package:auto_route/auto_route_annotations.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: SplashView, initial: true),
    MaterialRoute(page: RegisterView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: HomeView),
  ],
)
class $AutoRouter {}
