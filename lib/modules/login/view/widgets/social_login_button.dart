import 'package:dia_a_dia/core/constants/app_keys.dart';
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  const SocialLoginButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: AppKeys.socialLoginButton,
      onPressed: isLoading ? null : onPressed,
      child: isLoading
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                key: AppKeys.socialLoginLoading,
                strokeWidth: 2,
              ),
            )
          : const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.g_mobiledata,
                  key: AppKeys.socialLoginGoogleIcon,
                  size: 28,
                ),
                SizedBox(width: 8),
                Text(
                  'Continuar com Google',
                  key: AppKeys.socialLoginText,
                ),
              ],
            ),
    );
  }
}
