import 'package:flutter/material.dart';
import 'package:dia_a_dia/core/constants/app_keys.dart';

class AuthCard extends StatelessWidget {
  final Widget child;

  const AuthCard({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      key: AppKeys.authCard,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
