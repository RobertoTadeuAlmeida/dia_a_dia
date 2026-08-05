import 'package:flutter/material.dart';
import 'package:dia_a_dia/core/constants/app_keys.dart';

class SuccessMessage extends StatelessWidget {
  final String? message;

  const SuccessMessage._({super.key, required this.message});

  factory SuccessMessage({Key? key, required String? message}) {
    if (message == null || message.isEmpty) {
      return const _SuccessMessageHidden();
    }
    return SuccessMessage._(key: key, message: message);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: AppKeys.successMessage,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.check_circle_outline,
            key: AppKeys.successMessageIcon,
            color: Colors.green,
          ),
          const SizedBox(width: 8),
          Flexible(child: Text(message!, key: AppKeys.successMessageText)),
        ],
      ),
    );
  }
}

class _SuccessMessageHidden extends SuccessMessage {
  const _SuccessMessageHidden() : super._(message: null);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
