import 'package:Todo_API_MVVM/common/widgets/k_label.dart';
import 'package:Todo_API_MVVM/common/widgets/k_primary_button.dart';
import 'package:Todo_API_MVVM/common/widgets/k_text_field.dart';
import 'package:Todo_API_MVVM/common/widgets/ui_helpers.dart';
import 'package:Todo_API_MVVM/core/di/injection.dart';
import 'package:Todo_API_MVVM/features/register/view_models/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => locator<RegisterViewModel>(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Container(
          padding: sPagePadding,
          child: ListView(
            children: [
              KLabel(text: "Name"),
              xsHeightSpan,
              KTextField(
                controller: model.nameController,
              ),
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
                text: "Register",
                onPressed: model.onRegister,
              ),
              mHeightSpan,
              KPrimaryButton(
                text: "Login",
                onPressed: model.goToLogin,
              )
            ],
          ),
        ),
      ),
    );
  }
}
