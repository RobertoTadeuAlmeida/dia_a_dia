import 'package:flutter/material.dart';

class AppTheme {
  // Colors (Design System)
  static const primary = Color(0xFF3B4FE8);
  static const background = Color(0xFFEEF0F8);
  static const inputBackground = Color(0xFFF2F3F7);
  static const textDark = Color(0xFF0D1117);
  static const textMuted = Color(0xFF8E94A3);
  static const divider = Color(0xFFD8DAEA);

  static ThemeData light() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: const ColorScheme.light(
        primary: primary,
        surface: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primary, width: 1.5),
        ),
      ),
    );
  }
}