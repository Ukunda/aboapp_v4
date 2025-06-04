import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;
  Map<String, String> _localizedStrings = {}; // Initialize with an empty map

  AppLocalizations(this.locale);

  // Helper method to keep the boilerplate Flutter.
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  Future<bool> load() async {
    // Load the language JSON file from the "assets/l10n" folder
    String jsonString = await rootBundle.loadString('assets/l10n/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key, {Map<String, String>? args}) {
    String? translation = _localizedStrings[key];
    if (translation == null) {
      // Fallback or error handling
      print('Localization Error: Key "$key" not found for locale "${locale.languageCode}"');
      return key; // Return the key itself as a fallback
    }

    if (args != null && args.isNotEmpty) {
      args.forEach((argKey, argValue) {
        translation = translation!.replaceAll('{$argKey}', argValue);
      });
    }
    return translation!;
  }
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  // This delegate never rebuilds (it's stateless), so return false.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'de'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}