// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'AboApp V4';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get retry => 'Retry';

  @override
  String get close => 'Close';

  @override
  String get error_occurred => 'An Error Occurred';

  @override
  String get loading => 'Loading...';

  @override
  String get confirm => 'Confirm';

  @override
  String get bottom_nav_subscriptions => 'Subscriptions';

  @override
  String get bottom_nav_statistics => 'Statistics';

  @override
  String get bottom_nav_settings => 'Settings';

  @override
  String get bottom_nav_about => 'About';

  @override
  String get bottom_nav_import => 'Import';

  @override
  String get home_my_subscriptions => 'My Subscriptions';

  @override
  String get home_search_subscriptions_hint => 'Search subscriptions...';

  @override
  String get home_search_tooltip => 'Search';

  @override
  String get home_close_search_tooltip => 'Close Search';

  @override
  String get home_add_subscription_tooltip => 'Add Subscription';

  @override
  String get home_no_subscriptions_title => 'No Subscriptions Yet';

  @override
  String get home_no_subscriptions_message =>
      'Tap the \'+\' button to add your first one!';

  @override
  String get home_no_results_title => 'No Results Found';

  @override
  String get home_no_results_message => 'Try adjusting your search or filters.';

  @override
  String get home_clear_filters_button => 'Clear Filters';

  @override
  String get home_sort_by_label => 'Sort by:';

  @override
  String get home_filter_all_categories => 'All Categories';

  @override
  String get home_filter_all_cycles => 'All Cycles';

  @override
  String get home_monthly_spending_title => 'Monthly Spending';

  @override
  String home_active_count(int count) {
    return '$count Active';
  }

  @override
  String get home_filter_sort_tooltip => 'Filter & Sort';

  @override
  String get home_no_subscriptions_found_title => 'No Subscriptions Found';

  @override
  String get filter_sheet_title => 'Sort & Filter';

  @override
  String get filter_sheet_reset => 'Reset';

  @override
  String get filter_sheet_sort_by => 'Sort by';

  @override
  String get filter_sheet_categories => 'Categories';

  @override
  String get filter_sheet_billing_cycles => 'Billing Cycles';

  @override
  String get filter_sheet_apply => 'Apply Filters';

  @override
  String get sort_option_nameAsc => 'Name (A-Z)';

  @override
  String get sort_option_nameDesc => 'Name (Z-A)';

  @override
  String get sort_option_priceAsc => 'Price (Low-High)';

  @override
  String get sort_option_priceDesc => 'Price (High-Low)';

  @override
  String get sort_option_nextBillingDateAsc => 'Next Billing (Soonest)';

  @override
  String get sort_option_nextBillingDateDesc => 'Next Billing (Latest)';

  @override
  String get sort_option_category => 'Category';

  @override
  String get subscription_card_trial_badge => 'TRIAL';

  @override
  String get subscription_card_days_until_label_prefix => '';

  @override
  String get subscription_card_days_until_label_suffix => 'days';

  @override
  String get subscription_card_days_until_label_today => 'Today';

  @override
  String get subscription_card_days_until_label_tomorrow => 'Tomorrow';

  @override
  String get subscription_card_days_until_label_overdue_prefix => '';

  @override
  String get subscription_card_days_until_label_overdue_suffix => 'days ago';

  @override
  String get subscription_action_edit => 'Edit Subscription';

  @override
  String get subscription_action_pause => 'Pause Subscription';

  @override
  String get subscription_action_resume => 'Resume Subscription';

  @override
  String get subscription_action_disable_notifications =>
      'Disable Notifications';

  @override
  String get subscription_action_enable_notifications => 'Enable Notifications';

  @override
  String get subscription_action_delete => 'Delete Subscription';

  @override
  String get subscription_delete_confirm_title => 'Confirm Delete';

  @override
  String subscription_delete_confirm_message(String name) {
    return 'Are you sure you want to delete \"$name\"? This action cannot be undone.';
  }

  @override
  String subscription_deleted_snackbar(String name) {
    return '\"$name\" deleted.';
  }

  @override
  String get subscription_undo_snackbar_action => 'Undo';

  @override
  String get add_edit_screen_title_add => 'Add Subscription';

  @override
  String get add_edit_screen_title_edit => 'Edit Subscription';

  @override
  String get add_edit_screen_save_tooltip => 'Save Subscription';

  @override
  String get add_edit_screen_section_basic => 'Basic Information';

  @override
  String get add_edit_screen_label_name => 'Name';

  @override
  String get add_edit_screen_error_name_required => 'Name is required.';

  @override
  String get add_edit_screen_label_price => 'Price';

  @override
  String get add_edit_screen_error_price_required => 'Price is required.';

  @override
  String get add_edit_screen_error_price_invalid => 'Invalid price format.';

  @override
  String get add_edit_screen_label_category => 'Category';

  @override
  String get add_edit_screen_label_description => 'Description (Optional)';

  @override
  String get add_edit_screen_section_billing => 'Billing Details';

  @override
  String get add_edit_screen_label_billing_cycle => 'Billing Cycle';

  @override
  String get add_edit_screen_label_custom_cycle_days =>
      'Custom Cycle (in days)';

  @override
  String get add_edit_screen_error_custom_cycle_days_required =>
      'Cycle days are required for custom cycle.';

  @override
  String get add_edit_screen_error_custom_cycle_days_invalid =>
      'Must be greater than 0 days.';

  @override
  String get add_edit_screen_label_next_billing_date => 'Next Billing Date';

  @override
  String get add_edit_screen_label_start_date => 'Subscription Start Date';

  @override
  String get add_edit_screen_date_not_set => 'Not Set';

  @override
  String get add_edit_screen_date_please_select => 'Please select a date';

  @override
  String get add_edit_screen_section_optional => 'Optional Details';

  @override
  String get add_edit_screen_label_is_active => 'Active Subscription';

  @override
  String get add_edit_screen_label_is_trial => 'In Trial Period';

  @override
  String get add_edit_screen_label_trial_end_date => 'Trial End Date';

  @override
  String get add_edit_screen_label_notifications => 'Enable Notifications';

  @override
  String get add_edit_screen_label_notify_days_before =>
      'Notify Days Before Renewal';

  @override
  String get add_edit_screen_label_logo_url => 'Logo URL (Optional)';

  @override
  String get add_edit_screen_label_notes => 'Notes (Optional)';

  @override
  String get add_edit_screen_button_add => 'Add Subscription';

  @override
  String get add_edit_screen_button_update => 'Update Subscription';

  @override
  String get add_edit_screen_snackbar_invalid_custom_cycle =>
      'Invalid custom cycle days. Please correct.';

  @override
  String get billing_cycle_weekly => 'Weekly';

  @override
  String get billing_cycle_monthly => 'Monthly';

  @override
  String get billing_cycle_quarterly => 'Quarterly';

  @override
  String get billing_cycle_biAnnual => 'Every 6 Months';

  @override
  String get billing_cycle_yearly => 'Yearly';

  @override
  String get billing_cycle_custom => 'Custom (Days)';

  @override
  String get billing_cycle_short_weekly => 'wk';

  @override
  String get billing_cycle_short_monthly => 'mo';

  @override
  String get billing_cycle_short_quarterly => 'qtr';

  @override
  String get billing_cycle_short_biAnnual => '6mo';

  @override
  String get billing_cycle_short_yearly => 'yr';

  @override
  String get billing_cycle_short_custom => 'cust';

  @override
  String get category_streaming => 'Streaming';

  @override
  String get category_software => 'Software';

  @override
  String get category_gaming => 'Gaming';

  @override
  String get category_fitness => 'Fitness';

  @override
  String get category_music => 'Music';

  @override
  String get category_news => 'News';

  @override
  String get category_cloud => 'Cloud';

  @override
  String get category_utilities => 'Utilities';

  @override
  String get category_education => 'Education';

  @override
  String get category_other => 'Other';

  @override
  String get settings_title => 'Settings';

  @override
  String get settings_section_appearance => 'Appearance';

  @override
  String get settings_theme_title => 'Theme';

  @override
  String get settings_theme_system => 'System Default';

  @override
  String get settings_theme_light => 'Light';

  @override
  String get settings_theme_dark => 'Dark';

  @override
  String get settings_dialog_select_theme_title => 'Select Theme';

  @override
  String get settings_section_regional => 'Regional';

  @override
  String get settings_language_title => 'Language';

  @override
  String get settings_language_english => 'English';

  @override
  String get settings_language_german => 'Deutsch (German)';

  @override
  String get settings_dialog_select_language_title => 'Select Language';

  @override
  String get settings_currency_title => 'Currency';

  @override
  String get settings_dialog_select_currency_title => 'Select Currency';

  @override
  String get settings_section_about => 'About';

  @override
  String get settings_about_app_title => 'About AboApp';

  @override
  String settings_app_version(String version) {
    return 'Version $version';
  }

  @override
  String get settings_app_description_long =>
      'Subscription management made easy, keeping you in control of your recurring expenses.';

  @override
  String get settings_section_salary => 'Salary Insights';

  @override
  String get settings_section_advanced => 'Advanced';

  @override
  String get settings_rerun_onboarding_title => 'Rerun Welcome Screen?';

  @override
  String get settings_rerun_onboarding_message =>
      'This will show the welcome screen the next time you open the app. Your existing subscriptions and settings will not be deleted.';

  @override
  String get settings_rerun_onboarding_subtitle =>
      'Shows the initial setup screens again';

  @override
  String get settings_salary_title => 'Your Salary';

  @override
  String get settings_salary_description =>
      'This is optional and helps generate personal spending statistics. The data is stored only on your device.';

  @override
  String get settings_salary_amount_label => 'Salary Amount';

  @override
  String get settings_salary_13th_checkbox => 'I receive a 13th salary';

  @override
  String get stats_title => 'Statistics';

  @override
  String get stats_year_selector_tooltip => 'Select Year';

  @override
  String get stats_empty_title => 'No Statistics Yet';

  @override
  String get stats_error_title => 'Error Loading Statistics';

  @override
  String get stats_overall_spending_title => 'Spending Overview';

  @override
  String get stats_monthly_total_label => 'Monthly Total';

  @override
  String get stats_yearly_total_label => 'Yearly Total';

  @override
  String get stats_category_spending_title => 'Spending by Category';

  @override
  String get stats_category_empty_message =>
      'No category spending data available.';

  @override
  String get stats_category_empty_significant_message =>
      'No significant category spending.';

  @override
  String get stats_billing_type_title => 'Breakdown by Billing Cycle';

  @override
  String get stats_billing_type_subtitle =>
      '(Based on Monthly Equivalent Cost)';

  @override
  String get stats_billing_type_empty_message =>
      'No billing type data available.';

  @override
  String stats_spending_trend_title(String year) {
    return 'Spending Trend - $year';
  }

  @override
  String stats_spending_trend_empty_message(String year) {
    return 'No spending trend data available for $year.';
  }

  @override
  String get stats_top_subscriptions_title => 'Top Spending Subscriptions';

  @override
  String get stats_top_subscriptions_subtitle =>
      '(Based on Monthly Equivalent Cost)';

  @override
  String get stats_top_subscriptions_empty_message =>
      'No subscriptions to display in top list.';

  @override
  String get stats_per_month_label => 'per month';

  @override
  String get stats_subscription_abbrev_single => 'sub';

  @override
  String get stats_subscription_abbrev_multiple => 'subs';

  @override
  String get stats_salary_contribution_title => 'Salary Contribution';

  @override
  String stats_salary_contribution_message(String percentage, String salary) {
    return 'You\'re spending $percentage% of your yearly salary ($salary) on subscriptions.';
  }

  @override
  String get onboarding_page1_title => 'Welcome to AboApp!';

  @override
  String get onboarding_page1_desc =>
      'Track your subscriptions and save money effortlessly.';

  @override
  String get onboarding_page2_title => 'Add Subscriptions Easily';

  @override
  String get onboarding_page2_desc =>
      'Quickly add all your recurring payments from various services.';

  @override
  String get onboarding_page3_title => 'Stay on Top of Costs';

  @override
  String get onboarding_page3_desc =>
      'See clear summaries of your monthly and yearly expenses.';

  @override
  String get onboarding_page4_title => 'Never Miss a Payment';

  @override
  String get onboarding_page4_desc =>
      'Get timely reminders before your subscriptions are due.';

  @override
  String get onboarding_skip_button => 'Skip';

  @override
  String get onboarding_next_button => 'Next';

  @override
  String get onboarding_get_started_button => 'Get Started';

  @override
  String get onboarding_salary_optional_title => 'Optional: Salary Insights';

  @override
  String get onboarding_salary_optional_desc =>
      'Enter your salary to see what percentage of it goes to subscriptions. This is optional and stored only on your device.';

  @override
  String get onboarding_salary_hint => 'e.g., 5000';

  @override
  String get suggestions_title => 'Email Suggestions';

  @override
  String get suggestions_empty => 'No suggestions found';

  @override
  String get suggestions_start_scan => 'Scan Emails';

  @override
  String get page_not_found_title => 'Page Not Found';
}
