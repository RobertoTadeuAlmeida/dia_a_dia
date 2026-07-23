import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dia_a_dia/core/constants/app_keys.dart';
import 'package:dia_a_dia/core/widgets/primary_button.dart';
import 'package:dia_a_dia/modules/login/viewmodel/signup_viewmodel.dart';
import 'package:dia_a_dia/modules/login/view/widgets/auth_card.dart';
import 'package:dia_a_dia/modules/login/view/widgets/auth_header.dart';
import 'package:dia_a_dia/modules/login/view/widgets/or_divider.dart';
import 'package:dia_a_dia/modules/login/view/widgets/social_login_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<SignUpViewModel>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          key: AppKeys.signupBackButton,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const AuthHeader(),
              const SizedBox(height: 32),
              AuthCard(
                child: Column(
                  children: [
                    TextFormField(key: AppKeys.signupNameField),
                    TextFormField(key: AppKeys.signupLastNameField),
                    TextFormField(key: AppKeys.signupEmailField),
                    TextFormField(key: AppKeys.signupPasswordField),
                    TextFormField(key: AppKeys.signupConfirmPasswordField),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      key: AppKeys.signupButton,
                      text: 'Criar Conta',
                      onPressed: viewModel.isButtonEnabled ? () {} : null,
                      isLoading: viewModel.isLoading,
                    ),
                    const OrDivider(),
                    SocialLoginButton(
                      onPressed: () {},
                      isLoading: viewModel.isLoading,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text.rich(
                TextSpan(
                  text: 'Já tem uma conta? ',
                  children: [
                    TextSpan(
                      text: 'Fazer Login',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
