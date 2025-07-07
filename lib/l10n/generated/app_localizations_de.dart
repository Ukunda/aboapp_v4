// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get app_title => 'AboApp V4';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get save => 'Speichern';

  @override
  String get delete => 'Löschen';

  @override
  String get retry => 'Erneut versuchen';

  @override
  String get close => 'Schließen';

  @override
  String get error_occurred => 'Ein Fehler ist aufgetreten';

  @override
  String get loading => 'Lädt...';

  @override
  String get confirm => 'Bestätigen';

  @override
  String get bottom_nav_subscriptions => 'Abos';

  @override
  String get bottom_nav_statistics => 'Statistik';

  @override
  String get bottom_nav_settings => 'Einstellungen';

  @override
  String get bottom_nav_about => 'Über';

  @override
  String get bottom_nav_import => 'Import';

  @override
  String get home_my_subscriptions => 'Meine Abos';

  @override
  String get home_search_subscriptions_hint => 'Abos suchen...';

  @override
  String get home_search_tooltip => 'Suchen';

  @override
  String get home_close_search_tooltip => 'Suche schließen';

  @override
  String get home_add_subscription_tooltip => 'Abo hinzufügen';

  @override
  String get home_no_subscriptions_title => 'Noch keine Abos';

  @override
  String get home_no_subscriptions_message =>
      'Tippe auf \'+\' um dein erstes Abo hinzuzufügen!';

  @override
  String get home_no_results_title => 'Keine Ergebnisse';

  @override
  String get home_no_results_message => 'Passe deine Suche oder Filter an.';

  @override
  String get home_clear_filters_button => 'Filter löschen';

  @override
  String get home_sort_by_label => 'Sortieren nach:';

  @override
  String get home_filter_all_categories => 'Alle Kategorien';

  @override
  String get home_filter_all_cycles => 'Alle Zyklen';

  @override
  String get home_monthly_spending_title => 'Monatliche Ausgaben';

  @override
  String home_active_count(int count) {
    return '$count Aktiv';
  }

  @override
  String get home_filter_sort_tooltip => 'Filtern & Sortieren';

  @override
  String get home_no_subscriptions_found_title => 'Keine Abos gefunden';

  @override
  String get filter_sheet_title => 'Sortieren & Filtern';

  @override
  String get filter_sheet_reset => 'Zurücksetzen';

  @override
  String get filter_sheet_sort_by => 'Sortieren nach';

  @override
  String get filter_sheet_categories => 'Kategorien';

  @override
  String get filter_sheet_billing_cycles => 'Zahlungszyklen';

  @override
  String get filter_sheet_apply => 'Filter anwenden';

  @override
  String get sort_option_nameAsc => 'Name (A-Z)';

  @override
  String get sort_option_nameDesc => 'Name (Z-A)';

  @override
  String get sort_option_priceAsc => 'Preis (Gering-Hoch)';

  @override
  String get sort_option_priceDesc => 'Preis (Hoch-Gering)';

  @override
  String get sort_option_nextBillingDateAsc => 'Nächste Zahlung (Früheste)';

  @override
  String get sort_option_nextBillingDateDesc => 'Nächste Zahlung (Späteste)';

  @override
  String get sort_option_category => 'Kategorie';

  @override
  String get subscription_card_trial_badge => 'PROBE';

  @override
  String get subscription_card_days_until_label_prefix => 'in ';

  @override
  String get subscription_card_days_until_label_suffix => 'Tagen';

  @override
  String get subscription_card_days_until_label_today => 'Heute';

  @override
  String get subscription_card_days_until_label_tomorrow => 'Morgen';

  @override
  String get subscription_card_days_until_label_overdue_prefix => 'vor ';

  @override
  String get subscription_card_days_until_label_overdue_suffix => 'Tagen';

  @override
  String get subscription_action_edit => 'Abo bearbeiten';

  @override
  String get subscription_action_pause => 'Abo pausieren';

  @override
  String get subscription_action_resume => 'Abo fortsetzen';

  @override
  String get subscription_action_disable_notifications =>
      'Benachrichtigungen deaktivieren';

  @override
  String get subscription_action_enable_notifications =>
      'Benachrichtigungen aktivieren';

  @override
  String get subscription_action_delete => 'Abo löschen';

  @override
  String get subscription_delete_confirm_title => 'Löschen bestätigen';

  @override
  String subscription_delete_confirm_message(String name) {
    return 'Möchtest du \"$name\" wirklich löschen? Diese Aktion kann nicht rückgängig gemacht werden.';
  }

  @override
  String subscription_deleted_snackbar(String name) {
    return '\"$name\" gelöscht.';
  }

  @override
  String get subscription_undo_snackbar_action => 'Rückgängig';

  @override
  String get add_edit_screen_title_add => 'Abo hinzufügen';

  @override
  String get add_edit_screen_title_edit => 'Abo bearbeiten';

  @override
  String get add_edit_screen_save_tooltip => 'Abo speichern';

  @override
  String get add_edit_screen_section_basic => 'Basisinformationen';

  @override
  String get add_edit_screen_label_name => 'Name';

  @override
  String get add_edit_screen_error_name_required => 'Name ist erforderlich.';

  @override
  String get add_edit_screen_label_price => 'Preis';

  @override
  String get add_edit_screen_error_price_required => 'Preis ist erforderlich.';

  @override
  String get add_edit_screen_error_price_invalid => 'Ungültiges Preisformat.';

  @override
  String get add_edit_screen_label_category => 'Kategorie';

  @override
  String get add_edit_screen_label_description => 'Beschreibung (Optional)';

  @override
  String get add_edit_screen_section_billing => 'Zahlungsdetails';

  @override
  String get add_edit_screen_label_billing_cycle => 'Zahlungszyklus';

  @override
  String get add_edit_screen_label_custom_cycle_days =>
      'Eigener Zyklus (in Tagen)';

  @override
  String get add_edit_screen_error_custom_cycle_days_required =>
      'Zyklustage für eigenen Zyklus erforderlich.';

  @override
  String get add_edit_screen_error_custom_cycle_days_invalid =>
      'Muss größer als 0 Tage sein.';

  @override
  String get add_edit_screen_label_next_billing_date =>
      'Nächstes Zahlungsdatum';

  @override
  String get add_edit_screen_label_start_date => 'Startdatum des Abos';

  @override
  String get add_edit_screen_date_not_set => 'Nicht festgelegt';

  @override
  String get add_edit_screen_date_please_select => 'Bitte Datum wählen';

  @override
  String get add_edit_screen_section_optional => 'Optionale Details';

  @override
  String get add_edit_screen_label_is_active => 'Aktives Abonnement';

  @override
  String get add_edit_screen_label_is_trial => 'In Probezeit';

  @override
  String get add_edit_screen_label_trial_end_date => 'Ende der Probezeit';

  @override
  String get add_edit_screen_label_notifications =>
      'Benachrichtigungen aktivieren';

  @override
  String get add_edit_screen_label_notify_days_before =>
      'Benachrichtige Tage vorher';

  @override
  String get add_edit_screen_label_logo_url => 'Logo URL (Optional)';

  @override
  String get add_edit_screen_label_notes => 'Notizen (Optional)';

  @override
  String get add_edit_screen_button_add => 'Abo hinzufügen';

  @override
  String get add_edit_screen_button_update => 'Abo aktualisieren';

  @override
  String get add_edit_screen_snackbar_invalid_custom_cycle =>
      'Ungültige Zyklustage. Bitte korrigieren.';

  @override
  String get billing_cycle_weekly => 'Wöchentlich';

  @override
  String get billing_cycle_monthly => 'Monatlich';

  @override
  String get billing_cycle_quarterly => 'Vierteljährlich';

  @override
  String get billing_cycle_biAnnual => 'Halbjährlich';

  @override
  String get billing_cycle_yearly => 'Jährlich';

  @override
  String get billing_cycle_custom => 'Benutzerdefiniert (Tage)';

  @override
  String get billing_cycle_short_weekly => 'Wo';

  @override
  String get billing_cycle_short_monthly => 'Mo';

  @override
  String get billing_cycle_short_quarterly => 'Qt';

  @override
  String get billing_cycle_short_biAnnual => '6Mo';

  @override
  String get billing_cycle_short_yearly => 'Jr';

  @override
  String get billing_cycle_short_custom => 'Ind';

  @override
  String get category_streaming => 'Streaming';

  @override
  String get category_software => 'Software';

  @override
  String get category_gaming => 'Gaming';

  @override
  String get category_fitness => 'Fitness';

  @override
  String get category_music => 'Musik';

  @override
  String get category_news => 'Nachrichten';

  @override
  String get category_cloud => 'Cloud';

  @override
  String get category_utilities => 'Haushalt';

  @override
  String get category_education => 'Bildung';

  @override
  String get category_other => 'Sonstiges';

  @override
  String get settings_title => 'Einstellungen';

  @override
  String get settings_section_appearance => 'Erscheinungsbild';

  @override
  String get settings_theme_title => 'Design';

  @override
  String get settings_theme_system => 'Systemstandard';

  @override
  String get settings_theme_light => 'Hell';

  @override
  String get settings_theme_dark => 'Dunkel';

  @override
  String get settings_dialog_select_theme_title => 'Design wählen';

  @override
  String get settings_section_regional => 'Regionale Einstellungen';

  @override
  String get settings_language_title => 'Sprache';

  @override
  String get settings_language_english => 'English (Englisch)';

  @override
  String get settings_language_german => 'Deutsch';

  @override
  String get settings_dialog_select_language_title => 'Sprache wählen';

  @override
  String get settings_currency_title => 'Währung';

  @override
  String get settings_dialog_select_currency_title => 'Währung wählen';

  @override
  String get settings_section_about => 'Über';

  @override
  String get settings_about_app_title => 'Über AboApp';

  @override
  String settings_app_version(String version) {
    return 'Version $version';
  }

  @override
  String get settings_app_description_long =>
      'Abo-Verwaltung leicht gemacht, damit du deine wiederkehrenden Kosten im Griff hast.';

  @override
  String get settings_section_salary => 'Gehaltsinformationen';

  @override
  String get settings_section_advanced => 'Erweitert';

  @override
  String get settings_rerun_onboarding_title =>
      'Willkommensbildschirm erneut anzeigen?';

  @override
  String get settings_rerun_onboarding_message =>
      'Der Willkommensbildschirm wird beim nächsten Start der App erneut angezeigt. Deine bestehenden Abos und Einstellungen bleiben erhalten.';

  @override
  String get settings_rerun_onboarding_subtitle =>
      'Zeigt die Einführung erneut';

  @override
  String get settings_salary_title => 'Dein Gehalt';

  @override
  String get settings_salary_description =>
      'Optional, hilft persönliche Ausgabenstatistiken zu erstellen. Die Daten werden nur auf deinem Gerät gespeichert.';

  @override
  String get settings_salary_amount_label => 'Gehaltsbetrag';

  @override
  String get settings_salary_13th_checkbox =>
      'Ich erhalte einen 13. Monatslohn';

  @override
  String get stats_title => 'Statistiken';

  @override
  String get stats_year_selector_tooltip => 'Jahr auswählen';

  @override
  String get stats_empty_title => 'Noch keine Statistiken';

  @override
  String get stats_error_title => 'Fehler beim Laden der Statistiken';

  @override
  String get stats_overall_spending_title => 'Ausgabenübersicht';

  @override
  String get stats_monthly_total_label => 'Monatlich Gesamt';

  @override
  String get stats_yearly_total_label => 'Jährlich Gesamt';

  @override
  String get stats_category_spending_title => 'Ausgaben nach Kategorie';

  @override
  String get stats_category_empty_message =>
      'Keine Kategorie-Ausgabedaten verfügbar.';

  @override
  String get stats_category_empty_significant_message =>
      'Keine nennenswerten Kategorie-Ausgaben.';

  @override
  String get stats_billing_type_title => 'Aufschlüsselung nach Zahlungszyklus';

  @override
  String get stats_billing_type_subtitle =>
      '(Basierend auf monatlichen Äquivalentkosten)';

  @override
  String get stats_billing_type_empty_message =>
      'Keine Daten zu Zahlungszyklen verfügbar.';

  @override
  String stats_spending_trend_title(String year) {
    return 'Ausgabentrend - $year';
  }

  @override
  String stats_spending_trend_empty_message(String year) {
    return 'Keine Ausgabentrend-Daten für $year verfügbar.';
  }

  @override
  String get stats_top_subscriptions_title => 'Top Ausgaben Abos';

  @override
  String get stats_top_subscriptions_subtitle =>
      '(Basierend auf monatlichen Äquivalentkosten)';

  @override
  String get stats_top_subscriptions_empty_message =>
      'Keine Abos in der Top-Liste anzuzeigen.';

  @override
  String get stats_per_month_label => 'pro Monat';

  @override
  String get stats_subscription_abbrev_single => 'Abo';

  @override
  String get stats_subscription_abbrev_multiple => 'Abos';

  @override
  String get stats_salary_contribution_title => 'Gehaltsanteil';

  @override
  String stats_salary_contribution_message(String percentage, String salary) {
    return 'Du gibst $percentage% deines Jahresgehalts ($salary) für Abos aus.';
  }

  @override
  String get onboarding_page1_title => 'Willkommen bei AboApp!';

  @override
  String get onboarding_page1_desc =>
      'Verwalte deine Abonnements und spare mühelos Geld.';

  @override
  String get onboarding_page2_title => 'Abos einfach hinzufügen';

  @override
  String get onboarding_page2_desc =>
      'Füge schnell alle deine wiederkehrenden Zahlungen von verschiedenen Diensten hinzu.';

  @override
  String get onboarding_page3_title => 'Behalte Kosten im Blick';

  @override
  String get onboarding_page3_desc =>
      'Sieh klare Zusammenfassungen deiner monatlichen und jährlichen Ausgaben.';

  @override
  String get onboarding_page4_title => 'Verpasse keine Zahlung';

  @override
  String get onboarding_page4_desc =>
      'Erhalte rechtzeitige Erinnerungen bevor deine Abonnements fällig werden.';

  @override
  String get onboarding_skip_button => 'Überspringen';

  @override
  String get onboarding_next_button => 'Weiter';

  @override
  String get onboarding_get_started_button => 'Loslegen';

  @override
  String get onboarding_salary_optional_title =>
      'Optional: Gehaltsinformationen';

  @override
  String get onboarding_salary_optional_desc =>
      'Gib dein Gehalt ein, um zu sehen, welcher Anteil für Abos ausgegeben wird. Diese Angabe ist optional und wird nur auf deinem Gerät gespeichert.';

  @override
  String get onboarding_salary_hint => 'z.B. 5000';

  @override
  String get suggestions_title => 'E-Mail-Vorschläge';

  @override
  String get suggestions_empty => 'Keine Vorschläge gefunden';

  @override
  String get suggestions_start_scan => 'E-Mails scannen';

  @override
  String get page_not_found_title => 'Seite nicht gefunden';
}
