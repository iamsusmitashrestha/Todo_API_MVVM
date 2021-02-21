import 'package:Todo_API_MVVM/core/di/injection.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final locator = GetIt.instance;

@InjectableInit()
void configureDependencies() => $initGetIt(locator);
