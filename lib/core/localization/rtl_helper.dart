import 'package:flutter/material.dart';

/// Helper class for handling Right-to-Left (RTL) language considerations
class RTLHelper {
  /// List of RTL language codes
  static const Set<String> rtlLanguages = {
    'ar', // Arabic
    'he', // Hebrew
    'fa', // Persian/Farsi
    'ur', // Urdu
    'ku', // Kurdish
    'dv', // Dhivehi
  };

  /// Check if a locale uses RTL text direction
  static bool isRTL(Locale locale) {
    return rtlLanguages.contains(locale.languageCode);
  }

  /// Get text direction for a locale
  static TextDirection getTextDirection(Locale locale) {
    return isRTL(locale) ? TextDirection.rtl : TextDirection.ltr;
  }

  /// Get alignment for text based on locale
  static TextAlign getTextAlign(Locale locale, {TextAlign? fallback}) {
    if (isRTL(locale)) {
      switch (fallback) {
        case TextAlign.left:
          return TextAlign.right;
        case TextAlign.right:
          return TextAlign.left;
        case TextAlign.start:
          return TextAlign.start; // Start respects RTL
        case TextAlign.end:
          return TextAlign.end; // End respects RTL
        default:
          return fallback ?? TextAlign.start;
      }
    }
    return fallback ?? TextAlign.start;
  }

  /// Get EdgeInsets that respect RTL layout
  static EdgeInsets getEdgeInsets({
    required double start,
    required double top,
    required double end,
    required double bottom,
  }) {
    return EdgeInsetsDirectional.fromSTEB(start, top, end, bottom);
  }

  /// Helper for icon placement in RTL contexts
  static Widget getDirectionalIcon({
    required IconData ltrIcon,
    required IconData rtlIcon,
    required Locale locale,
    double? size,
    Color? color,
  }) {
    return Icon(
      isRTL(locale) ? rtlIcon : ltrIcon,
      size: size,
      color: color,
    );
  }

  /// Common RTL-aware icon mappings
  static IconData getBackIcon(Locale locale) {
    return isRTL(locale) ? Icons.arrow_forward : Icons.arrow_back;
  }

  static IconData getForwardIcon(Locale locale) {
    return isRTL(locale) ? Icons.arrow_back : Icons.arrow_forward;
  }

  static IconData getMenuIcon(Locale locale) {
    return isRTL(locale) ? Icons.menu_open : Icons.menu;
  }
}

/// Extension to make RTL handling easier in widgets
extension RTLContext on BuildContext {
  /// Get text direction for current locale
  TextDirection get textDirection {
    final locale = Localizations.localeOf(this);
    return RTLHelper.getTextDirection(locale);
  }

  /// Check if current locale is RTL
  bool get isRTL {
    final locale = Localizations.localeOf(this);
    return RTLHelper.isRTL(locale);
  }

  /// Get RTL-aware text alignment
  TextAlign textAlign({TextAlign? fallback}) {
    final locale = Localizations.localeOf(this);
    return RTLHelper.getTextAlign(locale, fallback: fallback);
  }

  /// Get RTL-aware back icon
  IconData get backIcon {
    final locale = Localizations.localeOf(this);
    return RTLHelper.getBackIcon(locale);
  }

  /// Get RTL-aware forward icon
  IconData get forwardIcon {
    final locale = Localizations.localeOf(this);
    return RTLHelper.getForwardIcon(locale);
  }
}