// lib/core/theme/app_theme.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aboapp/core/theme/app_typography.dart';

// VEREINFACHT: Nur noch eine Theme-Klasse für die gesamte App.
abstract class AppTheme {
  static const Color _primary =
      Color(0xFF000000); // Accent is Black in Light Mode
  static const Color _primaryDark =
      Color(0xFFFFFFFF); // Accent is White in Dark Mode

  // --- Light Mode Colors - MIT MEHR KONTRAST ---
  static const Color _backgroundLight = Color(0xFFF2F2F7);
  static const Color _surfaceLight = Colors.white;
  static const Color _onSurfaceLight = Color(0xFF121212);
  static const Color _onSurfaceVariantLight = Color(0xFF3C3C43);
  static const Color _borderLight = Color(0xFFE5E5E5);

  // --- Dark Mode Colors ---
  static const Color _backgroundDark = Color(0xFF000000);
  static const Color _surfaceDark = Color(0xFF1C1C1E);
  static const Color _onSurfaceDark = Color(0xFFE5E5EA);
  // Increased contrast for dark mode readability
  static const Color _onSurfaceVariantDark = Color(0xFFC7C7CC);

  static final _cardShapeLight = RoundedRectangleBorder(
    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
    side: BorderSide(color: _borderLight.withAlpha((255 * 0.7).round()), width: 1.0),
  );

  static const _cardShapeDark = RoundedRectangleBorder(
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
      primaryColor: _primary,
      onPrimaryColor: _surfaceLight,
      appBarColor: _backgroundLight,
      cardShape: _cardShapeLight,
      borderColor: _borderLight,
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
      primaryColor: _primaryDark,
      onPrimaryColor: _backgroundDark,
      appBarColor: _backgroundDark,
      cardShape: _cardShapeDark,
      borderColor: Colors.transparent,
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
    required ShapeBorder cardShape,
    required Color borderColor,
  }) {
    // KORREKTUR: onSurfaceVariantColor wird an _buildTextTheme übergeben
    final textTheme = _buildTextTheme(
        base: ThemeData(brightness: brightness).textTheme,
        onSurfaceColor: onSurfaceColor,
        onSurfaceVariantColor: onSurfaceVariantColor);

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
        error: Colors.red.shade400,
        onError: Colors.white,
        // onSurfaceVariant wird hier gesetzt und im Theme verwendet
        onSurfaceVariant: onSurfaceVariantColor,
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
      cardTheme: CardThemeData(
        elevation: 0,
        color: surfaceColor,
        shape: cardShape,
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
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
          borderSide: BorderSide(color: borderColor, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: borderColor, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: primaryColor, width: 1.5),
        ),
      ),
      textTheme: textTheme,
    );
  }

  // KORREKTUR: Diese Methode akzeptiert jetzt onSurfaceVariantColor
  static TextTheme _buildTextTheme(
      {required TextTheme base,
      required Color onSurfaceColor,
      required Color onSurfaceVariantColor}) {
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
          // KORREKTUR: Verwendet die deckende onSurfaceVariantColor
          bodyMedium:
              AppTypography.bodyMedium.copyWith(color: onSurfaceVariantColor),
        )
        .apply(
          // KORREKTUR: Verwendet die deckende onSurfaceVariantColor für Standard-Body-Text
          bodyColor: onSurfaceVariantColor,
          displayColor: onSurfaceColor,
        );
  }
}

// Helper extension to comply with original code structure if needed elsewhere.
extension ColorWithValues on Color {
  Color withValues({int? alpha}) {
    return withAlpha(alpha ?? (this.value >> 24) & 0xFF);
  }
}