import 'package:flutter/material.dart';
import 'package:dia_a_dia/core/constants/app_keys.dart';

class ErrorMessage extends StatelessWidget {
  final String? message;

  const ErrorMessage._({super.key, required this.message});

  factory ErrorMessage({Key? key, required String? message}) {
    if (message == null || message.isEmpty) {
      return const _ErrorMessageHidden();
    }
    return ErrorMessage._(key: key, message: message);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      key: AppKeys.errorMessage,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            key: AppKeys.errorMessageIcon,
            color: theme.colorScheme.error,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message!,
              key: AppKeys.errorMessageText,
              style: TextStyle(color: theme.colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorMessageHidden extends ErrorMessage {
  const _ErrorMessageHidden() : super._(message: null);

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
