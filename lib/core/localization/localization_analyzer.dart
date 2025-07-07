import 'dart:convert';
import 'dart:io';

/// Developer utility to analyze localization files and detect issues
class LocalizationAnalyzer {
  static const String l10nPath = 'assets/l10n';
  static const List<String> supportedLanguages = ['en', 'de', 'fr', 'es'];
  
  /// Analyzes all localization files and reports issues
  static Future<LocalizationReport> analyze() async {
    final report = LocalizationReport();
    
    // Load all translation files
    final Map<String, Map<String, String>> translations = {};
    
    for (final lang in supportedLanguages) {
      try {
        final file = File('$l10nPath/$lang.json');
        if (await file.exists()) {
          final content = await file.readAsString();
          final Map<String, dynamic> json = jsonDecode(content);
          translations[lang] = json.map((key, value) => MapEntry(key, value.toString()));
        } else {
          report.missingFiles.add(lang);
        }
      } catch (e) {
        report.invalidFiles[lang] = e.toString();
      }
    }
    
    if (translations.isEmpty) {
      return report;
    }
    
    // Use English as the base for comparison
    final baseKeys = translations['en']?.keys.toSet() ?? <String>{};
    
    // Check for missing keys in other languages
    for (final lang in supportedLanguages) {
      if (lang == 'en') continue;
      
      final langKeys = translations[lang]?.keys.toSet() ?? <String>{};
      final missingKeys = baseKeys.difference(langKeys);
      final extraKeys = langKeys.difference(baseKeys);
      
      if (missingKeys.isNotEmpty) {
        report.missingKeys[lang] = missingKeys.toList();
      }
      
      if (extraKeys.isNotEmpty) {
        report.extraKeys[lang] = extraKeys.toList();
      }
    }
    
    // Check for empty translations
    for (final lang in supportedLanguages) {
      final langTranslations = translations[lang];
      if (langTranslations != null) {
        final emptyKeys = langTranslations.entries
            .where((entry) => entry.value.trim().isEmpty)
            .map((entry) => entry.key)
            .toList();
        
        if (emptyKeys.isNotEmpty) {
          report.emptyTranslations[lang] = emptyKeys;
        }
      }
    }
    
    // Check for potentially untranslated strings (same as English)
    final englishTranslations = translations['en'];
    if (englishTranslations != null) {
      for (final lang in supportedLanguages) {
        if (lang == 'en') continue;
        
        final langTranslations = translations[lang];
        if (langTranslations != null) {
          final untranslatedKeys = <String>[];
          
          for (final key in baseKeys) {
            final englishValue = englishTranslations[key];
            final langValue = langTranslations[key];
            
            if (englishValue != null && 
                langValue != null && 
                englishValue == langValue &&
                !_isProperNoun(englishValue)) {
              untranslatedKeys.add(key);
            }
          }
          
          if (untranslatedKeys.isNotEmpty) {
            report.potentiallyUntranslated[lang] = untranslatedKeys;
          }
        }
      }
    }
    
    return report;
  }
  
  /// Checks if a string is likely a proper noun that shouldn't be translated
  static bool _isProperNoun(String value) {
    final properNouns = [
      'AboApp',
      'Flutter',
      'Dart',
      'USD',
      'EUR',
      'GBP',
      'JPY',
      'CHF',
      'CAD',
      'AUD',
    ];
    
    return properNouns.any((noun) => value.contains(noun));
  }
  
  /// Generates a missing keys template for a specific language
  static String generateMissingKeysTemplate(String language, List<String> missingKeys, Map<String, String> baseTranslations) {
    final buffer = StringBuffer();
    buffer.writeln('// Missing translations for $language:');
    buffer.writeln('{');
    
    for (final key in missingKeys) {
      final baseValue = baseTranslations[key] ?? '';
      buffer.writeln('  "$key": "TODO: Translate - $baseValue",');
    }
    
    buffer.writeln('}');
    return buffer.toString();
  }
  
  /// Prints a formatted report to console
  static void printReport(LocalizationReport report) {
    print('\n=== Localization Analysis Report ===\n');
    
    if (report.missingFiles.isNotEmpty) {
      print('❌ Missing translation files:');
      for (final file in report.missingFiles) {
        print('  - $file.json');
      }
      print('');
    }
    
    if (report.invalidFiles.isNotEmpty) {
      print('❌ Invalid translation files:');
      report.invalidFiles.forEach((file, error) {
        print('  - $file.json: $error');
      });
      print('');
    }
    
    if (report.missingKeys.isNotEmpty) {
      print('⚠️  Missing translation keys:');
      report.missingKeys.forEach((lang, keys) {
        print('  $lang: ${keys.length} missing keys');
        for (final key in keys) {
          print('    - $key');
        }
      });
      print('');
    }
    
    if (report.extraKeys.isNotEmpty) {
      print('⚠️  Extra translation keys (not in English):');
      report.extraKeys.forEach((lang, keys) {
        print('  $lang: ${keys.length} extra keys');
        for (final key in keys) {
          print('    - $key');
        }
      });
      print('');
    }
    
    if (report.emptyTranslations.isNotEmpty) {
      print('❌ Empty translations:');
      report.emptyTranslations.forEach((lang, keys) {
        print('  $lang: ${keys.length} empty translations');
        for (final key in keys) {
          print('    - $key');
        }
      });
      print('');
    }
    
    if (report.potentiallyUntranslated.isNotEmpty) {
      print('🤔 Potentially untranslated (same as English):');
      report.potentiallyUntranslated.forEach((lang, keys) {
        print('  $lang: ${keys.length} potentially untranslated');
        for (final key in keys) {
          print('    - $key');
        }
      });
      print('');
    }
    
    if (report.isValid) {
      print('✅ All translations are complete and valid!');
    }
  }
}

/// Report containing localization analysis results
class LocalizationReport {
  final List<String> missingFiles = [];
  final Map<String, String> invalidFiles = {};
  final Map<String, List<String>> missingKeys = {};
  final Map<String, List<String>> extraKeys = {};
  final Map<String, List<String>> emptyTranslations = {};
  final Map<String, List<String>> potentiallyUntranslated = {};
  
  bool get isValid => 
      missingFiles.isEmpty &&
      invalidFiles.isEmpty &&
      missingKeys.isEmpty &&
      emptyTranslations.isEmpty;
      
  bool get hasWarnings =>
      extraKeys.isNotEmpty ||
      potentiallyUntranslated.isNotEmpty;
}