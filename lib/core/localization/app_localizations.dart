import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  Map<String, String> _localizedStrings = {};
  Map<String, String> _fallbackStrings = {}; // English fallback

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  Future<bool> load() async {
    try {
      // Load the main locale file
      String jsonString = await rootBundle.loadString('assets/l10n/${locale.languageCode}.json');
      Map<String, dynamic> jsonMap = json.decode(jsonString);

      _localizedStrings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });

      // Load English fallback if not already English
      if (locale.languageCode != 'en') {
        try {
          String fallbackJsonString = await rootBundle.loadString('assets/l10n/en.json');
          Map<String, dynamic> fallbackJsonMap = json.decode(fallbackJsonString);
          _fallbackStrings = fallbackJsonMap.map((key, value) {
            return MapEntry(key, value.toString());
          });
        } catch (e) {
          // If fallback fails, continue without it
        }
      }

      return true;
    } catch (e) {
      // If loading fails, try to load English as fallback
      if (locale.languageCode != 'en') {
        try {
          String fallbackJsonString = await rootBundle.loadString('assets/l10n/en.json');
          Map<String, dynamic> fallbackJsonMap = json.decode(fallbackJsonString);
          _localizedStrings = fallbackJsonMap.map((key, value) {
            return MapEntry(key, value.toString());
          });
          return true;
        } catch (fallbackError) {
          return false;
        }
      }
      return false;
    }
  }

  String translate(String key, {Map<String, String>? args}) {
    String? translation = _localizedStrings[key];
    
    // Try fallback if translation not found
    if (translation == null && _fallbackStrings.isNotEmpty) {
      translation = _fallbackStrings[key];
    }
    
    // If still not found, return a formatted key
    if (translation == null) {
      return '[${key}]'; // Make missing translations obvious in development
    }

    if (args != null && args.isNotEmpty) {
      args.forEach((argKey, argValue) {
        translation = translation!.replaceAll('{$argKey}', argValue);
      });
    }
    return translation!;
  }

  /// Convenience method for pluralization
  String plural(String singularKey, String pluralKey, int count, {Map<String, String>? args}) {
    final key = count == 1 ? singularKey : pluralKey;
    final Map<String, String> countArgs = {'count': count.toString()};
    if (args != null) {
      countArgs.addAll(args);
    }
    return translate(key, args: countArgs);
  }

  /// Convenience getters for commonly used strings
  String get appTitle => translate('app_title');
  String get ok => translate('ok');
  String get cancel => translate('cancel');
  String get save => translate('save');
  String get delete => translate('delete');
  String get retry => translate('retry');
  String get close => translate('close');
  String get loading => translate('loading');
  String get errorOccurred => translate('error_occurred');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'de', 'fr', 'es'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}