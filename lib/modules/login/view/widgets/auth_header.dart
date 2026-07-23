import 'package:dia_a_dia/core/constants/app_keys.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //===========================================================================
        // Logo
        //===========================================================================
        FlutterLogo(size: 100, key: AppKeys.authLogo),

        SizedBox(height: 16),

        //===========================================================================
        // Título
        //===========================================================================
        Text(
          'Dia A Dia',
          key: AppKeys.authTitle,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 8),

        //===========================================================================
        // Subtítulo
        //===========================================================================
        Text(
          'Seu dia mais organizado',
          key: AppKeys.authSubtitle,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
