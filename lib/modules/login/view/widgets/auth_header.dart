import 'package:dia_a_dia/core/constants/app_keys.dart';
import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      key: AppKeys.authHeader,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //===========================================================================
        // Logo
        //===========================================================================
        FlutterLogo(size: 60, key: AppKeys.authLogo),

        SizedBox(height: 8),

        //===========================================================================
        // Título
        //===========================================================================
        Text(
          'Dia A Dia',
          key: AppKeys.authTitle,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        SizedBox(height: 4),

        //===========================================================================
        // Subtítulo
        //===========================================================================
        Text(
          'Seu dia mais organizado',
          key: AppKeys.authSubtitle,
          style: TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
