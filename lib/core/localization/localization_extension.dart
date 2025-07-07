import 'package:flutter/material.dart';
import 'app_localizations.dart';

/// Extension to make accessing translations easier throughout the app
extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n {
    final localization = AppLocalizations.of(this);
    if (localization == null) {
      throw FlutterError('AppLocalizations not found in context. Make sure to include AppLocalizations.delegate in your MaterialApp.');
    }
    return localization;
  }

  /// Quick access to translate method
  String tr(String key, {Map<String, String>? args}) {
    return l10n.translate(key, args: args);
  }

  /// Quick access to plural method
  String plural(String singularKey, String pluralKey, int count, {Map<String, String>? args}) {
    return l10n.plural(singularKey, pluralKey, count, args: args);
  }
}

/// Helper class for commonly used translations to reduce typos
class L10nKeys {
  // Navigation
  static const String bottomNavSubscriptions = 'bottom_nav_subscriptions';
  static const String bottomNavStatistics = 'bottom_nav_statistics';
  static const String bottomNavSettings = 'bottom_nav_settings';
  static const String bottomNavAbout = 'bottom_nav_about';

  // Home Screen
  static const String homeMySubscriptions = 'home_my_subscriptions';
  static const String homeSearchHint = 'home_search_subscriptions_hint';
  static const String homeSearchTooltip = 'home_search_tooltip';
  static const String homeCloseSearchTooltip = 'home_close_search_tooltip';
  static const String homeAddSubscriptionTooltip = 'home_add_subscription_tooltip';
  static const String homeNoSubscriptionsTitle = 'home_no_subscriptions_title';
  static const String homeNoSubscriptionsMessage = 'home_no_subscriptions_message';
  static const String homeNoResultsTitle = 'home_no_results_title';
  static const String homeNoResultsMessage = 'home_no_results_message';
  static const String homeClearFiltersButton = 'home_clear_filters_button';
  static const String homeSortByLabel = 'home_sort_by_label';
  static const String homeFilterAllCategories = 'home_filter_all_categories';
  static const String homeFilterAllCycles = 'home_filter_all_cycles';

  // Sort Options
  static const String sortOptionNameAsc = 'sort_option_nameAsc';
  static const String sortOptionNameDesc = 'sort_option_nameDesc';
  static const String sortOptionPriceAsc = 'sort_option_priceAsc';
  static const String sortOptionPriceDesc = 'sort_option_priceDesc';
  static const String sortOptionNextBillingDateAsc = 'sort_option_nextBillingDateAsc';
  static const String sortOptionNextBillingDateDesc = 'sort_option_nextBillingDateDesc';
  static const String sortOptionCategory = 'sort_option_category';

  // Subscription Actions
  static const String subscriptionActionEdit = 'subscription_action_edit';
  static const String subscriptionActionPause = 'subscription_action_pause';
  static const String subscriptionActionResume = 'subscription_action_resume';
  static const String subscriptionActionDelete = 'subscription_action_delete';
  static const String subscriptionDeleteConfirmTitle = 'subscription_delete_confirm_title';
  static const String subscriptionDeleteConfirmMessage = 'subscription_delete_confirm_message';

  // Settings
  static const String settingsTitle = 'settings_title';
  static const String settingsSectionAppearance = 'settings_section_appearance';
  static const String settingsThemeTitle = 'settings_theme_title';
  static const String settingsThemeSystem = 'settings_theme_system';
  static const String settingsThemeLight = 'settings_theme_light';
  static const String settingsThemeDark = 'settings_theme_dark';
  static const String settingsSectionRegional = 'settings_section_regional';
  static const String settingsLanguageTitle = 'settings_language_title';
  static const String settingsCurrencyTitle = 'settings_currency_title';

  // Statistics
  static const String statsTitle = 'stats_title';
  static const String statsEmptyTitle = 'stats_empty_title';
  static const String statsErrorTitle = 'stats_error_title';

  // Onboarding
  static const String onboardingPage1Title = 'onboarding_page1_title';
  static const String onboardingPage1Desc = 'onboarding_page1_desc';
  static const String onboardingPage2Title = 'onboarding_page2_title';
  static const String onboardingPage2Desc = 'onboarding_page2_desc';
  static const String onboardingPage3Title = 'onboarding_page3_title';
  static const String onboardingPage3Desc = 'onboarding_page3_desc';
  static const String onboardingPage4Title = 'onboarding_page4_title';
  static const String onboardingPage4Desc = 'onboarding_page4_desc';
  static const String onboardingSkipButton = 'onboarding_skip_button';
  static const String onboardingNextButton = 'onboarding_next_button';
  static const String onboardingGetStartedButton = 'onboarding_get_started_button';

  // Categories
  static const String categoryStreaming = 'category_streaming';
  static const String categorySoftware = 'category_software';
  static const String categoryGaming = 'category_gaming';
  static const String categoryFitness = 'category_fitness';
  static const String categoryMusic = 'category_music';
  static const String categoryNews = 'category_news';
  static const String categoryCloud = 'category_cloud';
  static const String categoryUtilities = 'category_utilities';
  static const String categoryEducation = 'category_education';
  static const String categoryOther = 'category_other';

  // Billing Cycles
  static const String billingCycleWeekly = 'billing_cycle_weekly';
  static const String billingCycleMonthly = 'billing_cycle_monthly';
  static const String billingCycleQuarterly = 'billing_cycle_quarterly';
  static const String billingCycleBiAnnual = 'billing_cycle_biAnnual';
  static const String billingCycleYearly = 'billing_cycle_yearly';
  static const String billingCycleCustom = 'billing_cycle_custom';
}