import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:aboapp/core/theme/app_colors.dart';
import 'package:aboapp/core/theme/app_typography.dart';

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
        primaryContainer: AppColors.primaryLight,
        onPrimaryContainer: AppColors.primaryDark,
        secondary: AppColors.accent,
        onSecondary: AppColors.onAccent,
        secondaryContainer: Color(0xFFFDE2EC),
        onSecondaryContainer: Color(0xFF7C2454),
        tertiary: AppColors.info,
        onTertiary: AppColors.onInfo,
        tertiaryContainer: Color(0xFFD8E6FD),
        onTertiaryContainer: Color(0xFF0F4C81),
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: Color(0xFFFFDAD6),
        onErrorContainer: Color(0xFF410002),
        surface: AppColors.backgroundLight, // Was background
        onSurface: AppColors.onSurfaceLight, // Was onBackground
        surfaceContainerHighest: AppColors.borderLight, // Was surfaceVariant
        onSurfaceVariant: AppColors.onSurfaceVariantLight,
        outline: AppColors.borderLight,
        outlineVariant: Color(0xFFCAC4D0),
        shadow: Color(0x1A000000), // Colors.black.withOpacity(0.1)
        scrim: Color(0x4D000000),  // Colors.black.withOpacity(0.3)
        inverseSurface: AppColors.surfaceDark,
        onInverseSurface: AppColors.onSurfaceDark,
        inversePrimary: AppColors.primaryDark,
        surfaceTint: AppColors.primary,
      ),
      textTheme: _buildTextTheme(base: ThemeData.light().textTheme, onSurfaceColor: AppColors.onSurfaceLight),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.backgroundLight,
        foregroundColor: AppColors.onSurfaceLight,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: AppTypography.titleLarge,
        iconTheme: IconThemeData(color: AppColors.onSurfaceLight),
      ),
      cardTheme: CardTheme(
        elevation: 1.0,
        color: AppColors.surfaceLight,
        surfaceTintColor: Colors.transparent,
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
        fillColor: const Color(0x80FFFFFF), // AppColors.surfaceLight.withOpacity(0.5)
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
        hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.onSurfaceVariantLight.withOpacity(0.7)), // Kept withOpacity as it's not const
        floatingLabelStyle: AppTypography.bodySmall.copyWith(color: AppColors.primary),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.borderLight,
        selectedColor: AppColors.primary,
        labelStyle: AppTypography.labelMedium.copyWith(color: AppColors.onSurfaceVariantLight),
        secondaryLabelStyle: AppTypography.labelMedium.copyWith(color: AppColors.onPrimary),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        iconTheme: const IconThemeData(color: AppColors.onSurfaceVariantLight, size: 18),
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
        elevation: 2.0,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: AppTypography.fontFamily,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.primaryLight,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryDark,
        onPrimaryContainer: AppColors.primaryLight,
        secondary: AppColors.accent,
        onSecondary: AppColors.onAccent,
        secondaryContainer: Color(0xFF7C2454),
        onSecondaryContainer: Color(0xFFFDE2EC),
        tertiary: AppColors.info,
        onTertiary: AppColors.onInfo,
        tertiaryContainer: Color(0xFF0F4C81),
        onTertiaryContainer: Color(0xFFD8E6FD),
        error: AppColors.error,
        onError: AppColors.onError,
        errorContainer: Color(0xFF93000A),
        onErrorContainer: Color(0xFFFFDAD6),
        surface: AppColors.backgroundDark, // Was background
        onSurface: AppColors.onSurfaceDark, // Was onBackground
        surfaceContainerHighest: AppColors.borderDark, // Was surfaceVariant
        onSurfaceVariant: AppColors.onSurfaceVariantDark,
        outline: AppColors.borderDark,
        outlineVariant: Color(0xFF49454F),
        shadow: Color(0x33000000), // Colors.black.withOpacity(0.2)
        scrim: Color(0x66000000),  // Colors.black.withOpacity(0.4)
        inverseSurface: AppColors.surfaceLight,
        onInverseSurface: AppColors.onSurfaceLight,
        inversePrimary: AppColors.primary,
        surfaceTint: AppColors.primaryLight,
      ),
      textTheme: _buildTextTheme(base: ThemeData.dark().textTheme, onSurfaceColor: AppColors.onSurfaceDark),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.backgroundDark,
        foregroundColor: AppColors.onSurfaceDark,
        systemOverlayStyle: SystemUiOverlayStyle.light,
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
          foregroundColor: AppColors.primaryDark,
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
        fillColor: const Color(0x801F2937), // AppColors.surfaceDark.withOpacity(0.5)
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
        hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.onSurfaceVariantDark.withOpacity(0.7)), // Kept withOpacity
        floatingLabelStyle: AppTypography.bodySmall.copyWith(color: AppColors.primaryLight),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.borderDark,
        selectedColor: AppColors.primaryLight,
        labelStyle: AppTypography.labelMedium.copyWith(color: AppColors.onSurfaceVariantDark),
        secondaryLabelStyle: AppTypography.labelMedium.copyWith(color: AppColors.primaryDark),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        iconTheme: const IconThemeData(color: AppColors.onSurfaceVariantDark, size: 18),
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
    );
  }

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

extension SemanticThemeColors on ThemeData {
  Color get success => brightness == Brightness.light ? AppColors.success : AppColors.success; 
  Color get onSuccess => brightness == Brightness.light ? AppColors.onSuccess : AppColors.onSuccess;
  Color get warning => brightness == Brightness.light ? AppColors.warning : AppColors.warning;
  Color get onWarning => brightness == Brightness.light ? AppColors.onWarning : AppColors.onWarning;
  Color get info => brightness == Brightness.light ? AppColors.info : AppColors.info;
  Color get onInfo => brightness == Brightness.light ? AppColors.onInfo : AppColors.onInfo;
}