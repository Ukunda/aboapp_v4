#!/usr/bin/env dart

import 'dart:io';

/// Migrationsskript für die Lokalisierung
/// 
/// Dieses Skript hilft dabei, von dem alten translate() System
/// zu dem neuen offiziellen Flutter Lokalisierungssystem zu migrieren.
/// 
/// Verwendung:
/// dart run scripts/migrate_localization.dart [--dry-run] [--verbose]
/// 
/// Optionen:
/// --dry-run: Zeigt nur an, was geändert werden würde
/// --verbose: Zeigt detaillierte Ausgabe
void main(List<String> args) async {
  final dryRun = args.contains('--dry-run');
  final verbose = args.contains('--verbose');

  if (dryRun) {
    
  }
  
  final migrator = LocalizationMigrator(
    dryRun: dryRun,
    verbose: verbose,
  );
  
  await migrator.migrate();
  
  if (dryRun) {
    
  }
}

class LocalizationMigrator {
  final bool dryRun;
  final bool verbose;
  
  int filesProcessed = 0;
  int simpleReplacements = 0;
  int complexReplacements = 0;
  int manualReviewRequired = 0;
  
  LocalizationMigrator({
    required this.dryRun,
    required this.verbose,
  });
  
  Future<void> migrate() async {
    
    final dartFiles = await _findDartFiles();
    
    for (final file in dartFiles) {
      await _processFile(file);
      filesProcessed++;
    }
    
    _printSummary();
  }
  
  Future<List<File>> _findDartFiles() async {
    final files = <File>[];
    final libDirectory = Directory('lib');
    
    if (!libDirectory.existsSync()) {
      return files;
    }
    
    await for (final entity in libDirectory.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.dart')) {
        // Ignoriere generierte Dateien
        if (!entity.path.contains('generated') &&
            !entity.path.contains('.g.dart') &&
            !entity.path.contains('.freezed.dart')) {
          files.add(entity);
        }
      }
    }
    
    return files;
  }
  
  Future<void> _processFile(File file) async {
    if (verbose) {
    }
    
    final content = await file.readAsString();
    String updatedContent = content;
    
    // Prüfe ob die Datei translate() verwendet
    if (!content.contains('translate(')) {
      if (verbose) {
      }
      return;
    }
    
    // Einfache Ersetzungen ohne Parameter
    updatedContent = _replaceSimpleTranslations(updatedContent);
    
    // Parametrisierte Ersetzungen
    updatedContent = _replaceParametrizedTranslations(updatedContent);
    
    // Prüfe auf noch vorhandene translate() Aufrufe
    final remainingTranslates = RegExp(r'translate\(').allMatches(updatedContent).length;
    if (remainingTranslates > 0) {
      manualReviewRequired++;
    }
    
    // Schreibe die Datei nur wenn sich etwas geändert hat
    if (updatedContent != content) {
      if (!dryRun) {
        await file.writeAsString(updatedContent);
      }
      if (verbose) {
      }
    }
  }
  
  String _replaceSimpleTranslations(String content) {
    // Einfache Ersetzungen: translate('key') -> key
    final simplePattern = RegExp(r"context\.l10n\.translate\('([^']+)'\)");
    final matches = simplePattern.allMatches(content);
    
    String result = content;
    for (final match in matches) {
      final key = match.group(1)!;
      final replacement = 'context.l10n.$key';
      result = result.replaceAll(match.group(0)!, replacement);
      simpleReplacements++;
    }
    
    return result;
  }
  
  String _replaceParametrizedTranslations(String content) {
    // Komplexere Ersetzungen für häufige Muster
    final replacements = <String, String>{
      // Häufige parametrisierte Aufrufe
      r"context\.l10n\.translate\('home_active_count',\s*args:\s*\{'count':\s*([^}]+)\}\)": 
        r'context.l10n.home_active_count($1)',
      
      r"context\.l10n\.translate\('settings_app_version',\s*args:\s*\{'version':\s*([^}]+)\}\)": 
        r'context.l10n.settings_app_version($1)',
      
      r"context\.l10n\.translate\('subscription_delete_confirm_message',\s*args:\s*\{'name':\s*([^}]+)\}\)": 
        r'context.l10n.subscription_delete_confirm_message($1)',
      
      r"context\.l10n\.translate\('subscription_deleted_snackbar',\s*args:\s*\{'name':\s*([^}]+)\}\)": 
        r'context.l10n.subscription_deleted_snackbar($1)',
      
      r"context\.l10n\.translate\('stats_spending_trend_title',\s*args:\s*\{'year':\s*([^}]+)\}\)": 
        r'context.l10n.stats_spending_trend_title($1)',
      
      r"context\.l10n\.translate\('stats_spending_trend_empty_message',\s*args:\s*\{'year':\s*([^}]+)\}\)": 
        r'context.l10n.stats_spending_trend_empty_message($1)',
    };
    
    String result = content;
    for (final entry in replacements.entries) {
      final pattern = RegExp(entry.key);
      final matches = pattern.allMatches(result);
      
      for (final match in matches) {
        result = result.replaceAll(match.group(0)!, entry.value.replaceAll(r'$1', match.group(1)!));
        complexReplacements++;
      }
    }
    
    return result;
  }
  
  void _printSummary() {
  }
}

/// Hilfsfunktionen für häufige Migrationsmuster
class MigrationPatterns {
  static final Map<String, String> commonPatterns = {
    // Einfache Buttons
    'cancel': 'cancel',
    'confirm': 'confirm',
    'delete': 'delete',
    'retry': 'retry',
    'close': 'close',
    'save': 'save',
    
    // Navigation
    'bottom_nav_subscriptions': 'bottom_nav_subscriptions',
    'bottom_nav_statistics': 'bottom_nav_statistics',
    'bottom_nav_settings': 'bottom_nav_settings',
    'bottom_nav_import': 'bottom_nav_import',
    
    // Billing Cycles
    'billing_cycle_weekly': 'billing_cycle_weekly',
    'billing_cycle_monthly': 'billing_cycle_monthly',
    'billing_cycle_quarterly': 'billing_cycle_quarterly',
    'billing_cycle_biAnnual': 'billing_cycle_biAnnual',
    'billing_cycle_yearly': 'billing_cycle_yearly',
    'billing_cycle_custom': 'billing_cycle_custom',
    
    // Kategorien
    'category_streaming': 'category_streaming',
    'category_software': 'category_software',
    'category_gaming': 'category_gaming',
    'category_fitness': 'category_fitness',
    'category_music': 'category_music',
    'category_news': 'category_news',
    'category_cloud': 'category_cloud',
    'category_utilities': 'category_utilities',
    'category_education': 'category_education',
    'category_other': 'category_other',
  };
  
  static final Map<String, String> parametrizedPatterns = {
    'home_active_count': 'home_active_count(count)',
    'settings_app_version': 'settings_app_version(version)',
    'subscription_delete_confirm_message': 'subscription_delete_confirm_message(name)',
    'subscription_deleted_snackbar': 'subscription_deleted_snackbar(name)',
    'stats_salary_contribution_message': 'stats_salary_contribution_message(percentage, salary)',
    'stats_spending_trend_title': 'stats_spending_trend_title(year)',
    'stats_spending_trend_empty_message': 'stats_spending_trend_empty_message(year)',
  };
}