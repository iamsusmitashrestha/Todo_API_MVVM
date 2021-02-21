import 'package:Todo_API_MVVM/common/widgets/k_label.dart';
import 'package:Todo_API_MVVM/common/widgets/k_primary_button.dart';
import 'package:Todo_API_MVVM/common/widgets/k_text_field.dart';
import 'package:Todo_API_MVVM/common/widgets/ui_helpers.dart';
import 'package:Todo_API_MVVM/core/di/injection.dart';
import 'package:Todo_API_MVVM/features/login/view_models/login_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => locator<LoginViewModel>(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: Container(
          padding: sPagePadding,
          child: ListView(
            children: [
              mHeightSpan,
              KLabel(text: "Email"),
              xsHeightSpan,
              KTextField(
                controller: model.emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              mHeightSpan,
              KLabel(text: "Password"),
              xsHeightSpan,
              KTextField(
                controller: model.passwordController,
                obscureText: true,
              ),
              mHeightSpan,
              KPrimaryButton(
                text: "Login",
                onPressed: model.onLogin,
                isBusy: model.isBusy,
              ),
              mHeightSpan,
              KPrimaryButton(
                text: "Register",
                onPressed: model.goToRegister,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
