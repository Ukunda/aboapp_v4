import 'package:flutter/widgets.dart';
import 'package:aboapp/l10n/generated/app_localizations.dart';

/// Extension für einfachen Zugriff auf Lokalisierung
extension AppLocalizationsX on BuildContext {
  /// Shortcut für AppLocalizations.of(context)
  AppLocalizations get l10n => AppLocalizations.of(this);
}

/// Globale Hilfsfunktionen für Lokalisierung
class L10nHelpers {
  /// Prüft ob die aktuelle Sprache Deutsch ist
  static bool isGerman(BuildContext context) {
    return AppLocalizations.of(context).localeName == 'de';
  }
  
  /// Prüft ob die aktuelle Sprache Englisch ist
  static bool isEnglish(BuildContext context) {
    return AppLocalizations.of(context).localeName == 'en';
  }
  
  /// Gibt den aktuellen Sprachcode zurück
  static String getCurrentLanguageCode(BuildContext context) {
    return AppLocalizations.of(context).localeName;
  }
  
  /// Formatiert eine Anzahl mit entsprechender Pluralisierung
  static String formatSubscriptionCount(BuildContext context, int count) {
    final l10n = AppLocalizations.of(context);
    return l10n.home_active_count(count);
  }
  
  /// Formatiert Salary Contribution Message
  static String formatSalaryContribution(BuildContext context, String percentage, String salary) {
    final l10n = AppLocalizations.of(context);
    return l10n.stats_salary_contribution_message(percentage, salary);
  }
  
  /// Formatiert App Version
  static String formatAppVersion(BuildContext context, String version) {
    final l10n = AppLocalizations.of(context);
    return l10n.settings_app_version(version);
  }
  
  /// Formatiert Delete Confirmation Message
  static String formatDeleteConfirmation(BuildContext context, String name) {
    final l10n = AppLocalizations.of(context);
    return l10n.subscription_delete_confirm_message(name);
  }
  
  /// Formatiert Deleted Snackbar Message
  static String formatDeletedSnackbar(BuildContext context, String name) {
    final l10n = AppLocalizations.of(context);
    return l10n.subscription_deleted_snackbar(name);
  }
  
  /// Formatiert Spending Trend Title
  static String formatSpendingTrendTitle(BuildContext context, String year) {
    final l10n = AppLocalizations.of(context);
    return l10n.stats_spending_trend_title(year);
  }
  
  /// Formatiert Spending Trend Empty Message
  static String formatSpendingTrendEmptyMessage(BuildContext context, String year) {
    final l10n = AppLocalizations.of(context);
    return l10n.stats_spending_trend_empty_message(year);
  }
}

/// Migration Guide für die Lokalisierung
///
/// ALT: context.l10n.key
/// NEU: context.l10n.key
///
/// ALT: context.l10n.translate('key', args: {'param': 'value'})
/// NEU: context.l10n.key(value)
///
/// Beispiele:
/// - context.l10n.app_title → context.l10n.app_title
/// - context.l10n.home_active_count(5) → context.l10n.home_active_count(5)
/// - context.l10n.settings_app_version('1.0') → context.l10n.settings_app_version('1.0')
