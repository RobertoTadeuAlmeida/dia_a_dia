import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          alignment: Alignment.center,
          child: const Text('DA'),
        ),
        const SizedBox(height: 14),
        const Text('Dia A Dia'),
        const SizedBox(height: 6),
        const Text('Seu dia mais organizado'),
      ],
    );
  }
}