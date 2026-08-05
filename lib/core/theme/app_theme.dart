import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppColors — Paleta oficial do projeto Dia A Dia
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppColors {
  // Brand / Identity
  static const primary = Color(0xFF4169A1);
  static const primaryDark = Color(0xFF2F4F7A);
  static const primaryLight = Color(0xFFE8F0FA);
  static const solar = Color(0xFFF5C84B);

  // Neutrals — Light
  static const backgroundLight = Color(0xFFF8FAFC);
  static const surfaceLight = Color(0xFFFFFFFF);
  static const textPrimaryLight = Color(0xFF1E293B);
  static const textSecondaryLight = Color(0xFF64748B);
  static const dividerLight = Color(0xFFE2E8F0); // Derivado para sutileza
  static const inputBgLight = Color(0xFFF1F5F9); // Derivado para contraste

  // Neutrals — Dark (Preservados para compatibilidade futura)
  static const backgroundDark = Color(0xFF0F1117);
  static const surfaceDark = Color(0xFF1A1D27);
  static const textDarkDark = Color(0xFFF0F2FF);
  static const textMutedDark = Color(0xFF6B7280);
  static const dividerDark = Color(0xFF2C3150);
  static const inputBgDark = Color(0xFF22263A);

  // States
  static const success = Color(0xFF2E8B57);
  static const error = Color(0xFFD64545);
  static const warning = Color(0xFFD99000);
  static const info = Color(0xFF3B82B6);

  // Categories
  static const work = Color(0xFF4F6FA8);
  static const study = Color(0xFF8064A2);
  static const personal = Color(0xFF4E8B78);
  static const health = Color(0xFFC86B6B);

  // Action (Alias para uso em botões e ações principais)
  static const actionLight = primary;
  static const actionDark = Color(0xFFF0F2FF);
}

// ─────────────────────────────────────────────────────────────────────────────
// AppTextStyles — Escala tipográfica oficial v1.0
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppTextStyles {
  static final _base = GoogleFonts.manrope();

  static final display = _base.copyWith(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
  );
  static final h1 = _base.copyWith(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 36 / 28,
  );
  static final h2 = _base.copyWith(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    height: 30 / 22,
  );
  static final h3 = _base.copyWith(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 26 / 18,
  );
  static final body = _base.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
  );
  static final bodySmall = _base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
  );
  static final label = _base.copyWith(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    height: 20 / 14,
  );
  static final caption = _base.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// AppDimensions — Raios e alturas reutilizáveis
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppDimensions {
  static const radiusSmall = 8.0;
  static const radiusMedium = 12.0;
  static const radiusLarge = 20.0;
  static const buttonHeight = 40.0;
  static const inputHeight = 40.0;
}

// ─────────────────────────────────────────────────────────────────────────────
// AppTheme — Factory light() e dark()
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppTheme {
  // ── Shared helpers ──────────────────────────────────────────────────────────

  static InputDecorationTheme _inputTheme({
    required Color fillColor,
    required Color focusBorderColor,
    required Color hintColor,
  }) {
    final radius = BorderRadius.circular(AppDimensions.radiusMedium);
    return InputDecorationTheme(
      filled: true,
      fillColor: fillColor,
      hintStyle: AppTextStyles.bodySmall.copyWith(color: hintColor),
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: BorderSide(color: focusBorderColor, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: radius,
        borderSide: const BorderSide(color: AppColors.error, width: 1.5),
      ),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme({
    required Color backgroundColor,
    required Color foregroundColor,
    required Color disabledBg,
  }) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        disabledBackgroundColor: disabledBg,
        disabledForegroundColor: foregroundColor.withOpacity(0.6),
        elevation: 0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        textStyle: AppTextStyles.label,
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme({
    required Color borderColor,
    required Color foregroundColor,
  }) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: foregroundColor,
        side: BorderSide(color: borderColor, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        textStyle: AppTextStyles.label,
      ),
    );
  }

  static DividerThemeData _dividerTheme(Color color) =>
      DividerThemeData(color: color, thickness: 1, space: 1);

  // ── Light ────────────────────────────────────────────────────────────────────

  static ThemeData light() {
    final scheme = ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primaryLight,
      onPrimaryContainer: AppColors.primaryDark,
      secondary: AppColors.solar,
      onSecondary: AppColors.textPrimaryLight,
      surface: AppColors.surfaceLight,
      onSurface: AppColors.textPrimaryLight,
      background: AppColors.backgroundLight,
      onBackground: AppColors.textPrimaryLight,
      error: AppColors.error,
      onError: Colors.white,
      outline: AppColors.dividerLight,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: scheme,
      fontFamily: GoogleFonts.manrope().fontFamily,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.h2.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: const IconThemeData(color: AppColors.textPrimaryLight),
      ),
      inputDecorationTheme: _inputTheme(
        fillColor: AppColors.inputBgLight,
        focusBorderColor: AppColors.primary,
        hintColor: AppColors.textSecondaryLight,
      ),
      elevatedButtonTheme: _elevatedButtonTheme(
        backgroundColor: AppColors.actionLight,
        foregroundColor: Colors.white,
        disabledBg: AppColors.dividerLight,
      ),
      outlinedButtonTheme: _outlinedButtonTheme(
        borderColor: AppColors.dividerLight,
        foregroundColor: AppColors.textPrimaryLight,
      ),
      dividerTheme: _dividerTheme(AppColors.dividerLight),
      textTheme: TextTheme(
        displaySmall: AppTextStyles.display.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        headlineLarge: AppTextStyles.h1.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        headlineMedium: AppTextStyles.h2.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        titleLarge: AppTextStyles.h3.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        bodyLarge: AppTextStyles.body.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        bodyMedium: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        labelLarge: AppTextStyles.label.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        bodySmall: AppTextStyles.caption.copyWith(
          color: AppColors.textSecondaryLight,
        ),
      ),
    );
  }

  // ── Dark ─────────────────────────────────────────────────────────────────────

  static ThemeData dark() {
    const scheme = ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.primaryLight,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textDarkDark,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      fontFamily: GoogleFonts.manrope().fontFamily,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.h2.copyWith(
          color: AppColors.textDarkDark,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        iconTheme: const IconThemeData(color: AppColors.textDarkDark),
      ),
      inputDecorationTheme: _inputTheme(
        fillColor: AppColors.inputBgDark,
        focusBorderColor: AppColors.primaryLight,
        hintColor: AppColors.textMutedDark,
      ),
      elevatedButtonTheme: _elevatedButtonTheme(
        backgroundColor: AppColors.actionDark,
        foregroundColor: AppColors.backgroundDark,
        disabledBg: AppColors.dividerDark,
      ),
      outlinedButtonTheme: _outlinedButtonTheme(
        borderColor: AppColors.dividerDark,
        foregroundColor: AppColors.textDarkDark,
      ),
      dividerTheme: _dividerTheme(AppColors.dividerDark),
      textTheme: TextTheme(
        displaySmall: AppTextStyles.display.copyWith(
          color: AppColors.textDarkDark,
        ),
        headlineLarge: AppTextStyles.h1.copyWith(color: AppColors.textDarkDark),
        headlineMedium: AppTextStyles.h2.copyWith(
          color: AppColors.textDarkDark,
        ),
        titleLarge: AppTextStyles.h3.copyWith(color: AppColors.textDarkDark),
        bodyLarge: AppTextStyles.body.copyWith(color: AppColors.textDarkDark),
        bodyMedium: AppTextStyles.bodySmall.copyWith(
          color: AppColors.textDarkDark,
        ),
        labelLarge: AppTextStyles.label.copyWith(color: AppColors.textDarkDark),
        bodySmall: AppTextStyles.caption.copyWith(
          color: AppColors.textMutedDark,
        ),
      ),
    );
  }
}
