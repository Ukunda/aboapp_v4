import 'package:intl/intl.dart';
import 'package:flutter/material.dart'; // For Locale, though intl handles most

class CurrencyFormatter {
  // Formats a double value into a currency string based on currencyCode and locale.
  static String format(
    double amount, {
    required String currencyCode, // e.g., "USD", "EUR"
    Locale? locale,             // For locale-specific formatting rules (e.g., decimal separators)
    int? decimalDigits,         // Override default decimal digits for the currency
  }) {
    // Determine the locale string for NumberFormat.
    // If a specific locale is provided, use it. Otherwise, try to infer from currency or default.
    String localeString;
    if (locale != null) {
      localeString = locale.toLanguageTag().replaceAll('-', '_');
    } else {
      // Basic inference for common currencies if no locale is passed.
      // For a robust solution, a larger mapping or relying on device locale might be needed.
      switch (currencyCode.toUpperCase()) {
        case 'USD':
        case 'CAD':
        case 'AUD':
          localeString = 'en_US';
          break;
        case 'EUR':
          localeString = 'de_DE'; // Or 'fr_FR', 'es_ES' etc. Defaulting to one.
          break;
        case 'GBP':
          localeString = 'en_GB';
          break;
        case 'JPY':
          localeString = 'ja_JP';
          break;
        case 'CHF':
          localeString = 'de_CH';
          break;
        default:
          localeString = 'en_US'; // A general fallback
      }
    }

    try {
      final format = NumberFormat.currency(
        locale: localeString,
        symbol: getCurrencySymbol(currencyCode), // Use our helper for the symbol
        decimalDigits: decimalDigits ?? _getDefaultDecimalDigits(currencyCode),
      );
      return format.format(amount);
    } catch (e) {
      // Fallback if NumberFormat fails for some reason (e.g., unsupported locale for currency)
      print("Currency formatting error for $currencyCode with locale $localeString: $e");
      return '${getCurrencySymbol(currencyCode)}${amount.toStringAsFixed(decimalDigits ?? 2)}';
    }
  }

  // Provides the currency symbol for a given code.
  static String getCurrencySymbol(String currencyCode) {
    // This is a simplified map. For comprehensive coverage, consider a dedicated library
    // or a more extensive map.
    final Map<String, String> symbols = {
      'USD': '\$',
      'EUR': '€',
      'GBP': '£',
      'JPY': '¥',
      'CHF': 'CHF', // Swiss Franc often uses the code itself as symbol
      'CAD': 'CA\$',
      'AUD': 'A\$',
      // Add more as needed
    };
    return symbols[currencyCode.toUpperCase()] ?? currencyCode; // Fallback to code if symbol not found
  }

  // Provides default decimal digits for common currencies.
  static int _getDefaultDecimalDigits(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'JPY':
        return 0; // Japanese Yen typically has no decimals
      // Most other currencies
      case 'USD':
      case 'EUR':
      case 'GBP':
      case 'CHF':
      case 'CAD':
      case 'AUD':
      default:
        return 2;
    }
  }

  // Parses a formatted currency string back to a double.
  // This can be complex due to different formatting. This is a simplified version.
  static double? tryParse(String formattedAmount) {
    // Remove common currency symbols and grouping separators.
    // This is a very basic approach and might not cover all locales/formats.
    String cleaned = formattedAmount
        .replaceAll(RegExp(r'[$\€£¥CHF]'), '') // Common symbols
        .replaceAll(',', '') // Remove thousands separators (assuming '.' is decimal)
        .trim();
    
    // If your app uses specific locales where '.' is a thousands separator and ',' is decimal,
    // you'll need more sophisticated parsing based on the current locale.
    // For example, for German locale: cleaned = cleaned.replaceAll('.', '').replaceAll(',', '.');
    
    return double.tryParse(cleaned);
  }
}