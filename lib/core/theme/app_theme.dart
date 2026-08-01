import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ─────────────────────────────────────────────────────────────────────────────
// AppColors — paleta única, referenciada em ambos os temas
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppColors {
  // Brand
  static const primary        = Color(0xFF3B4FE8);
  static const primaryLight   = Color(0xFF6B7BEF); // hover / pressed light
  static const primaryDark    = Color(0xFF2A3BC0); // hover / pressed dark

  // Neutrals — light
  static const backgroundLight  = Color(0xFFEEF0F8);
  static const surfaceLight      = Color(0xFFFFFFFF);
  static const inputBgLight      = Color(0xFFF2F3F7);
  static const dividerLight      = Color(0xFFD8DAEA);
  static const textDarkLight     = Color(0xFF0D1117);
  static const textMutedLight    = Color(0xFF8E94A3);

  // Neutrals — dark
  static const backgroundDark   = Color(0xFF0F1117);
  static const surfaceDark       = Color(0xFF1A1D27);
  static const inputBgDark       = Color(0xFF22263A);
  static const dividerDark       = Color(0xFF2C3150);
  static const textDarkDark      = Color(0xFFF0F2FF);
  static const textMutedDark     = Color(0xFF6B7280);

  // Action button (preto no light, branco-suave no dark)
  static const actionLight       = Color(0xFF0D1117);
  static const actionDark        = Color(0xFFF0F2FF);

  // Semantic
  static const error   = Color(0xFFE83B3B);
  static const success = Color(0xFF22C55E);
  static const warning = Color(0xFFF59E0B);
}

// ─────────────────────────────────────────────────────────────────────────────
// AppTextStyles — escala tipográfica consistente
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppTextStyles {
  static const _base = TextStyle(fontFamily: 'Inter');

  static final displayLarge  = _base.copyWith(fontSize: 28, fontWeight: FontWeight.w700, letterSpacing: -0.5);
  static final headingMedium = _base.copyWith(fontSize: 20, fontWeight: FontWeight.w700);
  static final labelLarge    = _base.copyWith(fontSize: 16, fontWeight: FontWeight.w600, letterSpacing: 0.3);
  static final labelMedium   = _base.copyWith(fontSize: 14, fontWeight: FontWeight.w600);
  static final bodyMedium    = _base.copyWith(fontSize: 15, fontWeight: FontWeight.w400);
  static final bodySmall     = _base.copyWith(fontSize: 13, fontWeight: FontWeight.w400);
  static final caption       = _base.copyWith(fontSize: 12, fontWeight: FontWeight.w400);
}

// ─────────────────────────────────────────────────────────────────────────────
// AppDimensions — raios e alturas reutilizáveis
// ─────────────────────────────────────────────────────────────────────────────
abstract final class AppDimensions {
  static const radiusSmall  = 8.0;
  static const radiusMedium = 12.0;
  static const radiusLarge  = 20.0;
  static const buttonHeight = 52.0;
  static const inputHeight  = 52.0;
}

// ─────────────────────────────────────────────────────────────────────────────
// AppTheme — factory light() e dark()
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
      hintStyle: AppTextStyles.bodyMedium.copyWith(color: hintColor),
      contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      border: OutlineInputBorder(borderRadius: radius, borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: radius, borderSide: BorderSide.none),
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
        minimumSize: const Size(double.infinity, AppDimensions.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        textStyle: AppTextStyles.labelLarge,
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
        minimumSize: const Size(double.infinity, AppDimensions.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMedium),
        ),
        textStyle: AppTextStyles.labelLarge,
      ),
    );
  }

  static DividerThemeData _dividerTheme(Color color) =>
      DividerThemeData(color: color, thickness: 1, space: 1);

  // ── Light ────────────────────────────────────────────────────────────────────

  static ThemeData light() {
    const scheme = ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.primaryLight,
      surface: AppColors.surfaceLight,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textDarkLight,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Inter',
      brightness: Brightness.light,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundLight,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.headingMedium.copyWith(
          color: AppColors.textDarkLight,
        ),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        iconTheme: const IconThemeData(color: AppColors.textDarkLight),
      ),
      inputDecorationTheme: _inputTheme(
        fillColor: AppColors.inputBgLight,
        focusBorderColor: AppColors.primary,
        hintColor: AppColors.textMutedLight,
      ),
      elevatedButtonTheme: _elevatedButtonTheme(
        backgroundColor: AppColors.actionLight,
        foregroundColor: Colors.white,
        disabledBg: AppColors.dividerLight,
      ),
      outlinedButtonTheme: _outlinedButtonTheme(
        borderColor: AppColors.dividerLight,
        foregroundColor: AppColors.textDarkLight,
      ),
      dividerTheme: _dividerTheme(AppColors.dividerLight),
      textTheme: TextTheme(
        displayLarge:  AppTextStyles.displayLarge.copyWith(color: AppColors.textDarkLight),
        headlineMedium: AppTextStyles.headingMedium.copyWith(color: AppColors.textDarkLight),
        labelLarge:    AppTextStyles.labelLarge.copyWith(color: AppColors.textDarkLight),
        labelMedium:   AppTextStyles.labelMedium.copyWith(color: AppColors.textDarkLight),
        bodyMedium:    AppTextStyles.bodyMedium.copyWith(color: AppColors.textDarkLight),
        bodySmall:     AppTextStyles.bodySmall.copyWith(color: AppColors.textMutedLight),
        labelSmall:    AppTextStyles.caption.copyWith(color: AppColors.textMutedLight),
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
      fontFamily: 'Inter',
      brightness: Brightness.dark,
      colorScheme: scheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.backgroundDark,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: AppTextStyles.headingMedium.copyWith(
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
        displayLarge:   AppTextStyles.displayLarge.copyWith(color: AppColors.textDarkDark),
        headlineMedium: AppTextStyles.headingMedium.copyWith(color: AppColors.textDarkDark),
        labelLarge:     AppTextStyles.labelLarge.copyWith(color: AppColors.textDarkDark),
        labelMedium:    AppTextStyles.labelMedium.copyWith(color: AppColors.textDarkDark),
        bodyMedium:     AppTextStyles.bodyMedium.copyWith(color: AppColors.textDarkDark),
        bodySmall:      AppTextStyles.bodySmall.copyWith(color: AppColors.textMutedDark),
        labelSmall:     AppTextStyles.caption.copyWith(color: AppColors.textMutedDark),
      ),
    );
  }
}