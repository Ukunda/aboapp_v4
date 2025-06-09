// lib/core/theme/modern_theme.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aboapp/core/theme/app_typography.dart';

abstract class ModernTheme {
  static const Color _primary = Color(0xFFFFFFFF); // Accent is White/Black
  static const Color _primaryDark = Color(0xFF000000);

  // Light Mode Colors
  static const Color _backgroundLight = Color(0xFFF7F7F7);
  static const Color _surfaceLight = Colors.white;
  static const Color _onSurfaceLight = Color(0xFF121212);
  static const Color _onSurfaceVariantLight = Color(0xFF6E6E73);

  // Dark Mode Colors
  static const Color _backgroundDark = Color(0xFF000000);
  static const Color _surfaceDark =
      Color(0xFF1C1C1E); // Slightly lighter than pure black
  static const Color _onSurfaceDark = Color(0xFFFFFFFF);
  static const Color _onSurfaceVariantDark = Color(0xFF8A8A8E);

  static const _cardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20.0)),
  );

  static ThemeData get lightTheme {
    return _baseTheme(
      brightness: Brightness.light,
      backgroundColor: _backgroundLight,
      scaffoldColor: _backgroundLight,
      surfaceColor: _surfaceLight,
      onSurfaceColor: _onSurfaceLight,
      onSurfaceVariantColor: _onSurfaceVariantLight,
      primaryColor: _primaryDark, // Black text on light background
      onPrimaryColor: _surfaceLight, // White text on black components
      appBarColor: _backgroundLight,
    );
  }

  static ThemeData get darkTheme {
    return _baseTheme(
      brightness: Brightness.dark,
      backgroundColor: _backgroundDark,
      scaffoldColor: _backgroundDark,
      surfaceColor: _surfaceDark,
      onSurfaceColor: _onSurfaceDark,
      onSurfaceVariantColor: _onSurfaceVariantDark,
      primaryColor: _primary, // White text on dark background
      onPrimaryColor: _backgroundDark, // Black text on white components
      appBarColor: _backgroundDark,
    );
  }

  static ThemeData _baseTheme({
    required Brightness brightness,
    required Color backgroundColor,
    required Color scaffoldColor,
    required Color surfaceColor,
    required Color onSurfaceColor,
    required Color onSurfaceVariantColor,
    required Color primaryColor,
    required Color onPrimaryColor,
    required Color appBarColor,
  }) {
    final textTheme = _buildTextTheme(
        base: ThemeData(brightness: brightness).textTheme,
        onSurfaceColor: onSurfaceColor);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      fontFamily: AppTypography.fontFamily,
      scaffoldBackgroundColor: scaffoldColor,
      primaryColor: primaryColor,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: primaryColor,
        onPrimary: onPrimaryColor,
        secondary: primaryColor,
        onSecondary: onPrimaryColor,
        surface: surfaceColor,
        onSurface: onSurfaceColor,
        background: backgroundColor,
        onBackground: onSurfaceColor,
        error: Colors.red.shade400,
        onError: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: appBarColor,
        foregroundColor: onSurfaceColor,
        systemOverlayStyle: brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        titleTextStyle: textTheme.headlineSmall,
        iconTheme: IconThemeData(color: onSurfaceColor),
      ),
      cardTheme: CardTheme(
        elevation: 0,
        color: surfaceColor,
        shape: _cardShape,
        margin: const EdgeInsets.symmetric(vertical: 8),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: onSurfaceColor,
        foregroundColor: backgroundColor,
        elevation: 0,
        highlightElevation: 0,
        shape: const CircleBorder(),
      ),
      bottomAppBarTheme: BottomAppBarTheme(
        color: surfaceColor,
        elevation: 0,
        shape: const CircularNotchedRectangle(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: surfaceColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: onSurfaceVariantColor, width: 1),
        ),
      ),
      textTheme: textTheme,
    );
  }

  static TextTheme _buildTextTheme(
      {required TextTheme base, required Color onSurfaceColor}) {
    return base
        .copyWith(
          displayMedium: AppTypography.displayMedium
              .copyWith(color: onSurfaceColor, fontWeight: FontWeight.bold),
          headlineSmall: AppTypography.headlineSmall
              .copyWith(color: onSurfaceColor, fontWeight: FontWeight.w600),
          titleLarge: AppTypography.titleLarge
              .copyWith(color: onSurfaceColor, fontWeight: FontWeight.w600),
          titleMedium: AppTypography.titleMedium
              .copyWith(color: onSurfaceColor, fontWeight: FontWeight.w600),
          bodyLarge: AppTypography.bodyLarge.copyWith(color: onSurfaceColor),
          bodyMedium: AppTypography.bodyMedium
              .copyWith(color: onSurfaceColor.withOpacity(0.8)),
        )
        .apply(
          bodyColor: onSurfaceColor.withOpacity(0.8),
          displayColor: onSurfaceColor,
        );
  }
}
