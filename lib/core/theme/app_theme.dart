import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aboapp/core/theme/app_colors.dart';
import 'package:aboapp/core/theme/app_typography.dart';

// This class is not meant to be instantiated.
// It provides static ThemeData configurations for light and dark themes.
abstract class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: AppTypography.fontFamily,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryLight, // Or a lighter variant
        onPrimaryContainer: AppColors.primaryDark, // Text on primary container
        secondary: AppColors.accent, // Using accent as secondary
        onSecondary: AppColors.onAccent,
        secondaryContainer: Color(0xFFFDE2EC), // Lighter accent
        onSecondaryContainer: Color(0xFF7C2454), // Text on accent container
        tertiary: AppColors.info, // Example, can be another color
        onTertiary: AppColors.onInfo,
        tertiaryContainer: Color(0xFFD8E6FD),
        onTertiaryContainer: Color(0xFF0F4C81),
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: Color(0xFFFFDAD6),
        onErrorContainer: Color(0xFF410002),
        background: AppColors.backgroundLight,
        onBackground: AppColors.onSurfaceLight,
        surface: AppColors.surfaceLight,
        onSurface: AppColors.onSurfaceLight,
        surfaceVariant: AppColors.borderLight, // For cards, dividers, etc.
        onSurfaceVariant: AppColors.onSurfaceVariantLight,
        outline: AppColors.borderLight,
        outlineVariant: Color(0xFFCAC4D0), // Slightly darker outline
        shadow: Colors.black.withOpacity(0.1),
        scrim: Colors.black.withOpacity(0.3),
        inverseSurface: AppColors.surfaceDark,
        onInverseSurface: AppColors.onSurfaceDark,
        inversePrimary: AppColors.primaryDark,
        surfaceTint: AppColors.primary, // Color used for elevation overlays
      ),
      textTheme: _buildTextTheme(base: ThemeData.light().textTheme, onSurfaceColor: AppColors.onSurfaceLight),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.backgroundLight, // Or surfaceLight
        foregroundColor: AppColors.onSurfaceLight, // Icon and title color
        systemOverlayStyle: SystemUiOverlayStyle.dark, // For light status bar icons
        titleTextStyle: AppTypography.titleLarge, // Use a specific style
        iconTheme: IconThemeData(color: AppColors.onSurfaceLight),
      ),
      cardTheme: CardTheme(
        elevation: 1.0,
        color: AppColors.surfaceLight,
        surfaceTintColor: Colors.transparent, // To avoid tinting based on elevation overlay
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: AppColors.borderLight, width: 0.5),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          textStyle: AppTypography.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
          elevation: 2.0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          textStyle: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceLight.withOpacity(0.5), // Slightly transparent fill
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.primary, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.error, width: 2.0),
        ),
        labelStyle: AppTypography.bodyMedium.copyWith(color: AppColors.onSurfaceVariantLight),
        hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.onSurfaceVariantLight.withOpacity(0.7)),
        floatingLabelStyle: AppTypography.bodySmall.copyWith(color: AppColors.primary),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.borderLight,
        selectedColor: AppColors.primary,
        labelStyle: AppTypography.labelMedium.copyWith(color: AppColors.onSurfaceVariantLight),
        secondaryLabelStyle: AppTypography.labelMedium.copyWith(color: AppColors.onPrimary), // For selected chip
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        iconTheme: IconThemeData(color: AppColors.onSurfaceVariantLight, size: 18),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: 4.0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceLight,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.onSurfaceVariantLight,
        selectedLabelStyle: AppTypography.labelSmall,
        unselectedLabelStyle: AppTypography.labelSmall,
        elevation: 2.0, // Subtle elevation
      ),
      // Add other theme properties as needed
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppTypography.fontFamily,
      primaryColor: AppColors.primary, // Or a slightly lighter primary for dark theme
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primaryLight, // Lighter primary for dark theme
        onPrimary: AppColors.onPrimary, // Often black or very dark gray on light primary
        primaryContainer: AppColors.primaryDark,
        onPrimaryContainer: AppColors.primaryLight,
        secondary: AppColors.accent, // Lighter accent
        onSecondary: AppColors.onAccent,
        secondaryContainer: Color(0xFF7C2454), // Darker accent container
        onSecondaryContainer: Color(0xFFFDE2EC),
        tertiary: AppColors.info, // Lighter info
        onTertiary: AppColors.onInfo,
        tertiaryContainer: Color(0xFF0F4C81),
        onTertiaryContainer: Color(0xFFD8E6FD),
        error: AppColors.error, // Often a lighter red
        onError: AppColors.onError,
        errorContainer: Color(0xFF93000A), // Dark error container
        onErrorContainer: Color(0xFFFFDAD6),
        background: AppColors.backgroundDark,
        onBackground: AppColors.onSurfaceDark,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.onSurfaceDark,
        surfaceVariant: AppColors.borderDark,
        onSurfaceVariant: AppColors.onSurfaceVariantDark,
        outline: AppColors.borderDark,
        outlineVariant: Color(0xFF49454F),
        shadow: Colors.black.withOpacity(0.2),
        scrim: Colors.black.withOpacity(0.4),
        inverseSurface: AppColors.surfaceLight,
        onInverseSurface: AppColors.onSurfaceLight,
        inversePrimary: AppColors.primary,
        surfaceTint: AppColors.primaryLight,
      ),
      textTheme: _buildTextTheme(base: ThemeData.dark().textTheme, onSurfaceColor: AppColors.onSurfaceDark),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.backgroundDark, // Or surfaceDark
        foregroundColor: AppColors.onSurfaceDark,
        systemOverlayStyle: SystemUiOverlayStyle.light, // For dark status bar icons
        titleTextStyle: AppTypography.titleLarge,
        iconTheme: IconThemeData(color: AppColors.onSurfaceDark),
      ),
      cardTheme: CardTheme(
        elevation: 1.0,
        color: AppColors.surfaceDark,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: const BorderSide(color: AppColors.borderDark, width: 0.5),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.primaryDark, // Good contrast
          textStyle: AppTypography.labelLarge,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
          elevation: 2.0,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          textStyle: AppTypography.labelLarge.copyWith(fontWeight: FontWeight.w600),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.0)),
        ),
      ),
       inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDark.withOpacity(0.5),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.error, width: 1.5),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: AppColors.error, width: 2.0),
        ),
        labelStyle: AppTypography.bodyMedium.copyWith(color: AppColors.onSurfaceVariantDark),
        hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.onSurfaceVariantDark.withOpacity(0.7)),
        floatingLabelStyle: AppTypography.bodySmall.copyWith(color: AppColors.primaryLight),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.borderDark,
        selectedColor: AppColors.primaryLight,
        labelStyle: AppTypography.labelMedium.copyWith(color: AppColors.onSurfaceVariantDark),
        secondaryLabelStyle: AppTypography.labelMedium.copyWith(color: AppColors.primaryDark),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        iconTheme: IconThemeData(color: AppColors.onSurfaceVariantDark, size: 18),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.primaryDark,
        elevation: 4.0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.onSurfaceVariantDark,
        selectedLabelStyle: AppTypography.labelSmall,
        unselectedLabelStyle: AppTypography.labelSmall,
        elevation: 2.0,
      ),
      // Add other theme properties as needed
    );
  }

  // Helper to build TextTheme with consistent font family and color application
  static TextTheme _buildTextTheme({required TextTheme base, required Color onSurfaceColor}) {
    return base.copyWith(
      displayLarge: AppTypography.displayLarge.copyWith(color: onSurfaceColor),
      displayMedium: AppTypography.displayMedium.copyWith(color: onSurfaceColor),
      displaySmall: AppTypography.displaySmall.copyWith(color: onSurfaceColor),
      headlineLarge: AppTypography.headlineLarge.copyWith(color: onSurfaceColor),
      headlineMedium: AppTypography.headlineMedium.copyWith(color: onSurfaceColor),
      headlineSmall: AppTypography.headlineSmall.copyWith(color: onSurfaceColor),
      titleLarge: AppTypography.titleLarge.copyWith(color: onSurfaceColor),
      titleMedium: AppTypography.titleMedium.copyWith(color: onSurfaceColor),
      titleSmall: AppTypography.titleSmall.copyWith(color: onSurfaceColor),
      bodyLarge: AppTypography.bodyLarge.copyWith(color: onSurfaceColor),
      bodyMedium: AppTypography.bodyMedium.copyWith(color: onSurfaceColor),
      bodySmall: AppTypography.bodySmall.copyWith(color: onSurfaceColor),
      labelLarge: AppTypography.labelLarge.copyWith(color: onSurfaceColor),
      labelMedium: AppTypography.labelMedium.copyWith(color: onSurfaceColor),
      labelSmall: AppTypography.labelSmall.copyWith(color: onSurfaceColor),
    ).apply(
      bodyColor: onSurfaceColor,
      displayColor: onSurfaceColor,
    );
  }
}

// Optional: Theme Extension for easy access to semantic colors if not using ColorScheme directly
extension SemanticThemeColors on ThemeData {
  Color get success => brightness == Brightness.light ? AppColors.success : AppColors.success; // Or a lighter/darker variant for dark theme
  Color get onSuccess => brightness == Brightness.light ? AppColors.onSuccess : AppColors.onSuccess;
  Color get warning => brightness == Brightness.light ? AppColors.warning : AppColors.warning;
  Color get onWarning => brightness == Brightness.light ? AppColors.onWarning : AppColors.onWarning;
  Color get info => brightness == Brightness.light ? AppColors.info : AppColors.info;
  Color get onInfo => brightness == Brightness.light ? AppColors.onInfo : AppColors.onInfo;
}