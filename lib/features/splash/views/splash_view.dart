import 'package:Todo_API_MVVM/common/widgets/k_label.dart';
import 'package:Todo_API_MVVM/common/widgets/k_primary_button.dart';
import 'package:Todo_API_MVVM/common/widgets/k_text_field.dart';
import 'package:Todo_API_MVVM/common/widgets/ui_helpers.dart';
import 'package:Todo_API_MVVM/core/di/injection.dart';
import 'package:Todo_API_MVVM/features/login/view_models/login_view_model.dart';
import 'package:Todo_API_MVVM/features/splash/view_models/splash_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      viewModelBuilder: () => locator<SplashViewModel>(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
