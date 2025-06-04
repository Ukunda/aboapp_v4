import 'package:intl/intl.dart';
import 'package:flutter/material.dart'; // For Locale

class CurrencyFormatter {
  static String format(
    double amount, {
    required String currencyCode, 
    Locale? locale,             
    int? decimalDigits,         
  }) {
    String localeString;
    if (locale != null) {
      localeString = locale.toLanguageTag().replaceAll('-', '_');
    } else {
      switch (currencyCode.toUpperCase()) {
        case 'USD':
        case 'CAD':
        case 'AUD':
          localeString = 'en_US';
          break;
        case 'EUR':
          localeString = 'de_DE'; 
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
          localeString = 'en_US'; 
      }
    }

    try {
      final format = NumberFormat.currency(
        locale: localeString,
        symbol: getCurrencySymbol(currencyCode), 
        decimalDigits: decimalDigits ?? _getDefaultDecimalDigits(currencyCode),
      );
      return format.format(amount);
    } catch (e) {
      // print("Currency formatting error for $currencyCode with locale $localeString: $e"); // Avoid print
      return '${getCurrencySymbol(currencyCode)}${amount.toStringAsFixed(decimalDigits ?? 2)}';
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

  static double? tryParse(String formattedAmount) {
    String cleaned = formattedAmount
        .replaceAll(RegExp(r'[$\€£¥CHF]'), '') 
        .replaceAll(',', '') 
        .trim();
    return double.tryParse(cleaned);
  }
}