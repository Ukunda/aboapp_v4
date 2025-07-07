import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../localization/localization_extension.dart';

/// Context-aware currency formatter that automatically uses app locale and user's currency preference
class ContextCurrencyFormatter {
  static String format(
    BuildContext context,
    double amount, {
    String? currencyCode,             
    int? decimalDigits,         
  }) {
    final locale = Localizations.localeOf(context);
    // In a real app, you'd get the user's currency preference from settings
    // For now, we'll use a default or the provided currency code
    final currency = currencyCode ?? _getDefaultCurrencyForLocale(locale);
    
    String localeString = locale.toLanguageTag().replaceAll('-', '_');

    try {
      final format = NumberFormat.currency(
        locale: localeString,
        symbol: getCurrencySymbol(currency), 
        decimalDigits: decimalDigits ?? _getDefaultDecimalDigits(currency),
      );
      return format.format(amount);
    } catch (e) {
      // Fallback formatting
      return '${getCurrencySymbol(currency)}${amount.toStringAsFixed(decimalDigits ?? 2)}';
    }
  }

  static String getCurrencySymbol(String currencyCode) {
    final Map<String, String> symbols = {
      'USD': '\$',
      'EUR': '€',
      'GBP': '£',
      'JPY': '¥',
      'CHF': 'CHF', 
      'CAD': 'CA\$',
      'AUD': 'A\$',
    };
    return symbols[currencyCode.toUpperCase()] ?? currencyCode;
  }

  static int _getDefaultDecimalDigits(String currencyCode) {
    switch (currencyCode.toUpperCase()) {
      case 'JPY':
        return 0; 
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

  static String _getDefaultCurrencyForLocale(Locale locale) {
    switch (locale.languageCode) {
      case 'de':
        return 'EUR';
      case 'fr':
        return 'EUR';
      case 'en':
      default:
        switch (locale.countryCode) {
          case 'GB':
            return 'GBP';
          case 'CA':
            return 'CAD';
          case 'AU':
            return 'AUD';
          case 'US':
          default:
            return 'USD';
        }
    }
  }

  static double? tryParse(String formattedAmount) {
    String cleaned = formattedAmount
        .replaceAll(RegExp(r'[\$\\€£¥CHF]'), '') 
        .replaceAll(',', '') 
        .trim();
    return double.tryParse(cleaned);
  }
}