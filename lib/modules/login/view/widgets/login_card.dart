import 'package:dia_a_dia/core/constants/app_keys.dart';
import 'package:dia_a_dia/core/widgets/auth_text_field.dart';
import 'package:dia_a_dia/core/widgets/primary_button.dart';
import 'package:dia_a_dia/modules/login/view/widgets/auth_card.dart';
import 'package:dia_a_dia/modules/login/view/widgets/or_divider.dart';
import 'package:flutter/material.dart';

import 'social_login_button.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.emailValidator,
    required this.passwordValidator,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.isLoading,
    required this.onSignIn,
    required this.onGoogleSignIn,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final String? Function(String?)? emailValidator;
  final String? Function(String?)? passwordValidator;

  final bool obscurePassword;

  final VoidCallback onTogglePassword;
  final VoidCallback onSignIn;
  final VoidCallback onGoogleSignIn;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AuthCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AuthTextField(
            key: AppKeys.loginEmailField,
            controller: emailController,
            label: 'Email',
            hintText: 'seu@email.com',
            prefixIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            validator: emailValidator,
          ),
          const SizedBox(height: 20),
          AuthTextField(
            key: AppKeys.loginPasswordField,
            controller: passwordController,
            label: 'Senha',
            hintText: '••••••••',
            prefixIcon: Icons.lock_outline_rounded,
            obscureText: obscurePassword,
            textInputAction: TextInputAction.done,
            validator: passwordValidator,
            suffixIcon: IconButton(
              onPressed: onTogglePassword,
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
              ),
            ),
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            key: AppKeys.loginButton,
            text: 'Entrar',
            isLoading: isLoading,
            onPressed: onSignIn,
          ),
          const OrDivider(),
          SocialLoginButton(
            key: AppKeys.googleLoginButton,
            onPressed: onGoogleSignIn,
            isLoading: false, // Evita duplicidade de CircularProgressIndicator para o teste
          ),
        ],
      ),
    );
  }
}
