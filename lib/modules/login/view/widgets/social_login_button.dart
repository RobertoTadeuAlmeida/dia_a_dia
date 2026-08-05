import 'package:dia_a_dia/core/constants/app_keys.dart';
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final Key? _btnKey;

  const SocialLoginButton({
    Key? key,
    required this.onPressed,
    this.isLoading = false,
  }) : _btnKey = key,
       super(key: null);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: _btnKey ?? AppKeys.socialLoginButton,
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
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.g_mobiledata,
                  key: AppKeys.socialLoginGoogleIcon,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    'Continuar com Google',
                    key: AppKeys.socialLoginText,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
    );
  }
}
