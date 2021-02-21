import 'package:Todo_API_MVVM/core/di/injection.dart';
import 'package:Todo_API_MVVM/core/routes/auto_router.gr.dart';
import 'package:Todo_API_MVVM/core/stacked_widgets/custom_stacked_setup.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:stacked_services/stacked_services.dart';

void main() async {
  await GetStorage.init();
  configureDependencies();
  customStackedSetup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo',
      navigatorKey: StackedService.navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: AutoRouter(),
    );
  }
}
