import 'package:flutter/material.dart';
import 'package:dia_a_dia/core/constants/app_keys.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    this.prefixIcon,
    this.errorText,
    this.obscureText = false,
    this.enabled = true,
    this.onTap,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction,
    this.isPassword = false,
    this.onTogglePasswordVisibility,
  });

  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData? prefixIcon;
  final String? errorText;
  final bool obscureText;
  final bool enabled;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final dynamic suffixIcon;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final bool isPassword;
  final VoidCallback? onTogglePasswordVisibility;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          key: AppKeys.authTextFieldLabel,
        ),
        TextFormField(
          key: AppKeys.authTextField,
          controller: controller,
          obscureText: obscureText,
          enabled: enabled,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    key: AppKeys.authTextFieldPrefixIcon,
                  )
                : null,
            suffixIcon: isPassword
                ? IconButton(
                    key: AppKeys.authTextFieldPasswordToggle,
                    onPressed: onTogglePasswordVisibility,
                    icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                  )
                : (suffixIcon is IconData
                    ? Icon(suffixIcon as IconData)
                    : suffixIcon as Widget?),
            error: errorText != null
                ? Text(
                    errorText!,
                    key: AppKeys.authTextFieldError,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
