import 'package:dia_a_dia/modules/login/view/pages/widgets/or_divider.dart';
import 'package:flutter/material.dart';

import 'package:dia_a_dia/core/theme/app_theme.dart';
import 'package:dia_a_dia/core/widgets/custom_text_field.dart';
import 'package:dia_a_dia/modules/login/utils/login_validators.dart';
import 'package:dia_a_dia/modules/login/view/pages/widgets/sign_in_button.dart';

import 'google_button.dart';

class LoginCard extends StatelessWidget {
  const LoginCard({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.onTogglePassword,
    required this.isLoading,
    required this.onSignIn,
    required this.onGoogleSignIn,
  });

  final GlobalKey<FormState> formKey;

  final TextEditingController emailController;
  final TextEditingController passwordController;

  final bool obscurePassword;

  final VoidCallback onTogglePassword;
  final VoidCallback onSignIn;
  final VoidCallback onGoogleSignIn;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _FieldLabel('Email'),

            const SizedBox(height: 8),

            CustomTextField(
              controller: emailController,
              hint: 'seu@email.com',
              prefixIcon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validator: LoginValidators.email,
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [const _FieldLabel('Senha')],
            ),

            const SizedBox(height: 8),

            CustomTextField(
              controller: passwordController,
              hint: '••••••••',
              prefixIcon: Icons.lock_outline_rounded,
              obscureText: obscurePassword,
              textInputAction: TextInputAction.done,
              validator: LoginValidators.password,
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

            SignInButton(isLoading: isLoading, onPressed: onSignIn),
            OrDivider(),
            GoogleButton(isLoading: isLoading, onPressed: onGoogleSignIn),
          ],
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyles.labelMedium);
  }
}

class _ForgotPasswordLink extends StatelessWidget {
  const _ForgotPasswordLink({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        'Esqueceu a senha?',
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
