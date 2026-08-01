import 'package:flutter/material.dart';
import 'package:dia_a_dia/core/constants/app_keys.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      key: AppKeys.orDivider,
      children: const [
        Expanded(child: Divider()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text('OU'),
        ),
        Expanded(child: Divider()),
      ],
    );
  }
}