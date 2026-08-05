import 'package:dia_a_dia/core/constants/app_keys.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      key: AppKeys.authHeader,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //===========================================================================
        // Logo
        //===========================================================================
        const FlutterLogo(size: 20, key: AppKeys.authLogo),

        const SizedBox(height: 2),

        //===========================================================================
        // Título
        //===========================================================================
        Text(
          'Dia A Dia',
          key: AppKeys.authTitle,
          style: theme.textTheme.headlineMedium,
        ),

        const SizedBox(height: 2),

        //===========================================================================
        // Subtítulo
        //===========================================================================
        Text(
          'Seu dia mais organizado',
          key: AppKeys.authSubtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}
