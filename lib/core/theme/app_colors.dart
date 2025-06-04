import 'package:flutter/material.dart';

// This class is not meant to be instantiated.
// It holds static color definitions for the app.
abstract class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFF8B5CF6); // Purple
  static const Color primaryLight = Color(0xFFA78BFA);
  static const Color primaryDark = Color(0xFF7C3AED);
  static const Color onPrimary = Colors.white;

  // Accent/Secondary Palette (Can be same as primary or different)
  static const Color accent = Color(0xFFEC4899); // Pink, as an example accent
  static const Color onAccent = Colors.white;

  // Background & Surface Colors
  static const Color backgroundLight = Color(0xFFF9FAFB); // Off-white
  static const Color surfaceLight = Colors.white;
  static const Color onSurfaceLight = Color(0xFF1F2937); // Dark Gray
  static const Color onSurfaceVariantLight = Color(0xFF6B7280); // Medium Gray

  static const Color backgroundDark = Color(0xFF111827); // Very Dark Blue/Gray
  static const Color surfaceDark = Color(0xFF1F2937); // Dark Gray
  static const Color onSurfaceDark = Color(0xFFF3F4F6); // Light Gray
  static const Color onSurfaceVariantDark = Color(0xFF9CA3AF); // Medium-Light Gray

  // Semantic Colors
  static const Color error = Color(0xFFEF4444); // Red
  static const Color onError = Colors.white;
  static const Color success = Color(0xFF10B981); // Green
  static const Color onSuccess = Colors.white;
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color onWarning = Colors.black; // Or white depending on contrast
  static const Color info = Color(0xFF3B82F6); // Blue
  static const Color onInfo = Colors.white;

  // Neutral/Border Colors
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color borderDark = Color(0xFF374151);

  // Subscription Category Colors (example, can be moved or expanded)
  static const Color catStreaming = Color(0xFFEF4444); // Red
  static const Color catSoftware = Color(0xFF8B5CF6); // Purple (same as primary)
  static const Color catGaming = Color(0xFF10B981);   // Green
  static const Color catFitness = Color(0xFFF59E0B);  // Amber
  static const Color catMusic = Color(0xFF3B82F6);    // Blue
  static const Color catNews = Color(0xFF6366F1);     // Indigo
  static const Color catCloud = Color(0xFF06B6D4);    // Cyan
  static const Color catOther = Color(0xFF6B7280);    // Gray
}