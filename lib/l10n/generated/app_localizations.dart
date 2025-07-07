import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('de'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'AboApp V4'**
  String get app_title;

  /// Standard OK button text
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Standard Cancel button text
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Standard Save button text
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Standard Delete button text
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Standard Retry button text
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Standard Close button text
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'An Error Occurred'**
  String get error_occurred;

  /// Loading indicator text
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Standard Confirm button text
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Bottom navigation label for subscriptions
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get bottom_nav_subscriptions;

  /// Bottom navigation label for statistics
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get bottom_nav_statistics;

  /// Bottom navigation label for settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get bottom_nav_settings;

  /// Bottom navigation label for about
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get bottom_nav_about;

  /// Bottom navigation label for import
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get bottom_nav_import;

  /// Header text for subscriptions list
  ///
  /// In en, this message translates to:
  /// **'My Subscriptions'**
  String get home_my_subscriptions;

  /// Hint text for subscription search field
  ///
  /// In en, this message translates to:
  /// **'Search subscriptions...'**
  String get home_search_subscriptions_hint;

  /// Tooltip for search button
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get home_search_tooltip;

  /// Tooltip for close search button
  ///
  /// In en, this message translates to:
  /// **'Close Search'**
  String get home_close_search_tooltip;

  /// Tooltip for add subscription button
  ///
  /// In en, this message translates to:
  /// **'Add Subscription'**
  String get home_add_subscription_tooltip;

  /// Title when no subscriptions exist
  ///
  /// In en, this message translates to:
  /// **'No Subscriptions Yet'**
  String get home_no_subscriptions_title;

  /// Message when no subscriptions exist
  ///
  /// In en, this message translates to:
  /// **'Tap the \'+\' button to add your first one!'**
  String get home_no_subscriptions_message;

  /// Title when search returns no results
  ///
  /// In en, this message translates to:
  /// **'No Results Found'**
  String get home_no_results_title;

  /// Message when search returns no results
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search or filters.'**
  String get home_no_results_message;

  /// Button to clear all filters
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get home_clear_filters_button;

  /// Label for sort dropdown
  ///
  /// In en, this message translates to:
  /// **'Sort by:'**
  String get home_sort_by_label;

  /// Option to show all categories in filter
  ///
  /// In en, this message translates to:
  /// **'All Categories'**
  String get home_filter_all_categories;

  /// Option to show all billing cycles in filter
  ///
  /// In en, this message translates to:
  /// **'All Cycles'**
  String get home_filter_all_cycles;

  /// Title for monthly spending summary
  ///
  /// In en, this message translates to:
  /// **'Monthly Spending'**
  String get home_monthly_spending_title;

  /// Shows number of active subscriptions
  ///
  /// In en, this message translates to:
  /// **'{count} Active'**
  String home_active_count(int count);

  /// Tooltip for filter and sort button
  ///
  /// In en, this message translates to:
  /// **'Filter & Sort'**
  String get home_filter_sort_tooltip;

  /// Title when no subscriptions match the filter
  ///
  /// In en, this message translates to:
  /// **'No Subscriptions Found'**
  String get home_no_subscriptions_found_title;

  /// Title for filter bottom sheet
  ///
  /// In en, this message translates to:
  /// **'Sort & Filter'**
  String get filter_sheet_title;

  /// Button to reset all filters
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get filter_sheet_reset;

  /// Section header for sort options
  ///
  /// In en, this message translates to:
  /// **'Sort by'**
  String get filter_sheet_sort_by;

  /// Section header for category filters
  ///
  /// In en, this message translates to:
  /// **'Categories'**
  String get filter_sheet_categories;

  /// Section header for billing cycle filters
  ///
  /// In en, this message translates to:
  /// **'Billing Cycles'**
  String get filter_sheet_billing_cycles;

  /// Button to apply selected filters
  ///
  /// In en, this message translates to:
  /// **'Apply Filters'**
  String get filter_sheet_apply;

  /// Sort option: Name ascending
  ///
  /// In en, this message translates to:
  /// **'Name (A-Z)'**
  String get sort_option_nameAsc;

  /// Sort option: Name descending
  ///
  /// In en, this message translates to:
  /// **'Name (Z-A)'**
  String get sort_option_nameDesc;

  /// Sort option: Price ascending
  ///
  /// In en, this message translates to:
  /// **'Price (Low-High)'**
  String get sort_option_priceAsc;

  /// Sort option: Price descending
  ///
  /// In en, this message translates to:
  /// **'Price (High-Low)'**
  String get sort_option_priceDesc;

  /// Sort option: Next billing date ascending
  ///
  /// In en, this message translates to:
  /// **'Next Billing (Soonest)'**
  String get sort_option_nextBillingDateAsc;

  /// Sort option: Next billing date descending
  ///
  /// In en, this message translates to:
  /// **'Next Billing (Latest)'**
  String get sort_option_nextBillingDateDesc;

  /// Sort option: By category
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get sort_option_category;

  /// Badge text for trial subscriptions
  ///
  /// In en, this message translates to:
  /// **'TRIAL'**
  String get subscription_card_trial_badge;

  /// Text before days until billing
  ///
  /// In en, this message translates to:
  /// **''**
  String get subscription_card_days_until_label_prefix;

  /// Text after days until billing
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get subscription_card_days_until_label_suffix;

  /// Text for today's billing
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get subscription_card_days_until_label_today;

  /// Text for tomorrow's billing
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get subscription_card_days_until_label_tomorrow;

  /// Text before overdue days
  ///
  /// In en, this message translates to:
  /// **''**
  String get subscription_card_days_until_label_overdue_prefix;

  /// Text after overdue days
  ///
  /// In en, this message translates to:
  /// **'days ago'**
  String get subscription_card_days_until_label_overdue_suffix;

  /// Action menu item to edit subscription
  ///
  /// In en, this message translates to:
  /// **'Edit Subscription'**
  String get subscription_action_edit;

  /// Action menu item to pause subscription
  ///
  /// In en, this message translates to:
  /// **'Pause Subscription'**
  String get subscription_action_pause;

  /// Action menu item to resume subscription
  ///
  /// In en, this message translates to:
  /// **'Resume Subscription'**
  String get subscription_action_resume;

  /// Action menu item to disable notifications
  ///
  /// In en, this message translates to:
  /// **'Disable Notifications'**
  String get subscription_action_disable_notifications;

  /// Action menu item to enable notifications
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get subscription_action_enable_notifications;

  /// Action menu item to delete subscription
  ///
  /// In en, this message translates to:
  /// **'Delete Subscription'**
  String get subscription_action_delete;

  /// Title for delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get subscription_delete_confirm_title;

  /// Message for delete confirmation dialog
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete \"{name}\"? This action cannot be undone.'**
  String subscription_delete_confirm_message(String name);

  /// Snackbar message after successful deletion
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" deleted.'**
  String subscription_deleted_snackbar(String name);

  /// Action button in snackbar to undo deletion
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get subscription_undo_snackbar_action;

  /// Title for add subscription screen
  ///
  /// In en, this message translates to:
  /// **'Add Subscription'**
  String get add_edit_screen_title_add;

  /// Title for edit subscription screen
  ///
  /// In en, this message translates to:
  /// **'Edit Subscription'**
  String get add_edit_screen_title_edit;

  /// Tooltip for save button
  ///
  /// In en, this message translates to:
  /// **'Save Subscription'**
  String get add_edit_screen_save_tooltip;

  /// Section header for basic information
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get add_edit_screen_section_basic;

  /// Label for name input field
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get add_edit_screen_label_name;

  /// Error message when name is empty
  ///
  /// In en, this message translates to:
  /// **'Name is required.'**
  String get add_edit_screen_error_name_required;

  /// Label for price input field
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get add_edit_screen_label_price;

  /// Error message when price is empty
  ///
  /// In en, this message translates to:
  /// **'Price is required.'**
  String get add_edit_screen_error_price_required;

  /// Error message when price format is invalid
  ///
  /// In en, this message translates to:
  /// **'Invalid price format.'**
  String get add_edit_screen_error_price_invalid;

  /// Label for category selection
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get add_edit_screen_label_category;

  /// Label for description input field
  ///
  /// In en, this message translates to:
  /// **'Description (Optional)'**
  String get add_edit_screen_label_description;

  /// Section header for billing information
  ///
  /// In en, this message translates to:
  /// **'Billing Details'**
  String get add_edit_screen_section_billing;

  /// Label for billing cycle selection
  ///
  /// In en, this message translates to:
  /// **'Billing Cycle'**
  String get add_edit_screen_label_billing_cycle;

  /// Label for custom cycle days input
  ///
  /// In en, this message translates to:
  /// **'Custom Cycle (in days)'**
  String get add_edit_screen_label_custom_cycle_days;

  /// Error message when custom cycle days are empty
  ///
  /// In en, this message translates to:
  /// **'Cycle days are required for custom cycle.'**
  String get add_edit_screen_error_custom_cycle_days_required;

  /// Error message when custom cycle days are invalid
  ///
  /// In en, this message translates to:
  /// **'Must be greater than 0 days.'**
  String get add_edit_screen_error_custom_cycle_days_invalid;

  /// Label for next billing date selection
  ///
  /// In en, this message translates to:
  /// **'Next Billing Date'**
  String get add_edit_screen_label_next_billing_date;

  /// Label for subscription start date
  ///
  /// In en, this message translates to:
  /// **'Subscription Start Date'**
  String get add_edit_screen_label_start_date;

  /// Text when date is not set
  ///
  /// In en, this message translates to:
  /// **'Not Set'**
  String get add_edit_screen_date_not_set;

  /// Placeholder text for date selection
  ///
  /// In en, this message translates to:
  /// **'Please select a date'**
  String get add_edit_screen_date_please_select;

  /// Section header for optional information
  ///
  /// In en, this message translates to:
  /// **'Optional Details'**
  String get add_edit_screen_section_optional;

  /// Label for active subscription toggle
  ///
  /// In en, this message translates to:
  /// **'Active Subscription'**
  String get add_edit_screen_label_is_active;

  /// Label for trial period toggle
  ///
  /// In en, this message translates to:
  /// **'In Trial Period'**
  String get add_edit_screen_label_is_trial;

  /// Label for trial end date selection
  ///
  /// In en, this message translates to:
  /// **'Trial End Date'**
  String get add_edit_screen_label_trial_end_date;

  /// Label for notifications toggle
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get add_edit_screen_label_notifications;

  /// Label for notification days before renewal
  ///
  /// In en, this message translates to:
  /// **'Notify Days Before Renewal'**
  String get add_edit_screen_label_notify_days_before;

  /// Label for logo URL input
  ///
  /// In en, this message translates to:
  /// **'Logo URL (Optional)'**
  String get add_edit_screen_label_logo_url;

  /// Label for notes input field
  ///
  /// In en, this message translates to:
  /// **'Notes (Optional)'**
  String get add_edit_screen_label_notes;

  /// Button text to add new subscription
  ///
  /// In en, this message translates to:
  /// **'Add Subscription'**
  String get add_edit_screen_button_add;

  /// Button text to update existing subscription
  ///
  /// In en, this message translates to:
  /// **'Update Subscription'**
  String get add_edit_screen_button_update;

  /// Snackbar message for invalid custom cycle
  ///
  /// In en, this message translates to:
  /// **'Invalid custom cycle days. Please correct.'**
  String get add_edit_screen_snackbar_invalid_custom_cycle;

  /// Weekly billing cycle option
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get billing_cycle_weekly;

  /// Monthly billing cycle option
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get billing_cycle_monthly;

  /// Quarterly billing cycle option
  ///
  /// In en, this message translates to:
  /// **'Quarterly'**
  String get billing_cycle_quarterly;

  /// Bi-annual billing cycle option
  ///
  /// In en, this message translates to:
  /// **'Every 6 Months'**
  String get billing_cycle_biAnnual;

  /// Yearly billing cycle option
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get billing_cycle_yearly;

  /// Custom billing cycle option
  ///
  /// In en, this message translates to:
  /// **'Custom (Days)'**
  String get billing_cycle_custom;

  /// Short form for weekly billing cycle
  ///
  /// In en, this message translates to:
  /// **'wk'**
  String get billing_cycle_short_weekly;

  /// Short form for monthly billing cycle
  ///
  /// In en, this message translates to:
  /// **'mo'**
  String get billing_cycle_short_monthly;

  /// Short form for quarterly billing cycle
  ///
  /// In en, this message translates to:
  /// **'qtr'**
  String get billing_cycle_short_quarterly;

  /// Short form for bi-annual billing cycle
  ///
  /// In en, this message translates to:
  /// **'6mo'**
  String get billing_cycle_short_biAnnual;

  /// Short form for yearly billing cycle
  ///
  /// In en, this message translates to:
  /// **'yr'**
  String get billing_cycle_short_yearly;

  /// Short form for custom billing cycle
  ///
  /// In en, this message translates to:
  /// **'cust'**
  String get billing_cycle_short_custom;

  /// Streaming category
  ///
  /// In en, this message translates to:
  /// **'Streaming'**
  String get category_streaming;

  /// Software category
  ///
  /// In en, this message translates to:
  /// **'Software'**
  String get category_software;

  /// Gaming category
  ///
  /// In en, this message translates to:
  /// **'Gaming'**
  String get category_gaming;

  /// Fitness category
  ///
  /// In en, this message translates to:
  /// **'Fitness'**
  String get category_fitness;

  /// Music category
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get category_music;

  /// News category
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get category_news;

  /// Cloud storage category
  ///
  /// In en, this message translates to:
  /// **'Cloud'**
  String get category_cloud;

  /// Utilities category
  ///
  /// In en, this message translates to:
  /// **'Utilities'**
  String get category_utilities;

  /// Education category
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get category_education;

  /// Other category
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get category_other;

  /// Title for settings screen
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings_title;

  /// Section header for appearance settings
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settings_section_appearance;

  /// Label for theme setting
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settings_theme_title;

  /// System default theme option
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get settings_theme_system;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settings_theme_light;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settings_theme_dark;

  /// Title for theme selection dialog
  ///
  /// In en, this message translates to:
  /// **'Select Theme'**
  String get settings_dialog_select_theme_title;

  /// Section header for regional settings
  ///
  /// In en, this message translates to:
  /// **'Regional'**
  String get settings_section_regional;

  /// Label for language setting
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settings_language_title;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settings_language_english;

  /// German language option
  ///
  /// In en, this message translates to:
  /// **'Deutsch (German)'**
  String get settings_language_german;

  /// Title for language selection dialog
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get settings_dialog_select_language_title;

  /// Label for currency setting
  ///
  /// In en, this message translates to:
  /// **'Currency'**
  String get settings_currency_title;

  /// Title for currency selection dialog
  ///
  /// In en, this message translates to:
  /// **'Select Currency'**
  String get settings_dialog_select_currency_title;

  /// Section header for about information
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get settings_section_about;

  /// Title for about app section
  ///
  /// In en, this message translates to:
  /// **'About AboApp'**
  String get settings_about_app_title;

  /// App version display text
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String settings_app_version(String version);

  /// Long description of the app
  ///
  /// In en, this message translates to:
  /// **'Subscription management made easy, keeping you in control of your recurring expenses.'**
  String get settings_app_description_long;

  /// Section header for salary settings
  ///
  /// In en, this message translates to:
  /// **'Salary Insights'**
  String get settings_section_salary;

  /// Section header for advanced settings
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get settings_section_advanced;

  /// Title for rerun onboarding option
  ///
  /// In en, this message translates to:
  /// **'Rerun Welcome Screen?'**
  String get settings_rerun_onboarding_title;

  /// Message explaining what rerun onboarding does
  ///
  /// In en, this message translates to:
  /// **'This will show the welcome screen the next time you open the app. Your existing subscriptions and settings will not be deleted.'**
  String get settings_rerun_onboarding_message;

  /// Subtitle for rerun onboarding option
  ///
  /// In en, this message translates to:
  /// **'Shows the initial setup screens again'**
  String get settings_rerun_onboarding_subtitle;

  /// Title for salary settings
  ///
  /// In en, this message translates to:
  /// **'Your Salary'**
  String get settings_salary_title;

  /// Description for salary settings
  ///
  /// In en, this message translates to:
  /// **'This is optional and helps generate personal spending statistics. The data is stored only on your device.'**
  String get settings_salary_description;

  /// Label for salary amount input
  ///
  /// In en, this message translates to:
  /// **'Salary Amount'**
  String get settings_salary_amount_label;

  /// Checkbox label for 13th salary
  ///
  /// In en, this message translates to:
  /// **'I receive a 13th salary'**
  String get settings_salary_13th_checkbox;

  /// Title for statistics screen
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get stats_title;

  /// Tooltip for year selector
  ///
  /// In en, this message translates to:
  /// **'Select Year'**
  String get stats_year_selector_tooltip;

  /// Title when no statistics are available
  ///
  /// In en, this message translates to:
  /// **'No Statistics Yet'**
  String get stats_empty_title;

  /// Title for statistics loading error
  ///
  /// In en, this message translates to:
  /// **'Error Loading Statistics'**
  String get stats_error_title;

  /// Title for overall spending section
  ///
  /// In en, this message translates to:
  /// **'Spending Overview'**
  String get stats_overall_spending_title;

  /// Label for monthly total spending
  ///
  /// In en, this message translates to:
  /// **'Monthly Total'**
  String get stats_monthly_total_label;

  /// Label for yearly total spending
  ///
  /// In en, this message translates to:
  /// **'Yearly Total'**
  String get stats_yearly_total_label;

  /// Title for category spending section
  ///
  /// In en, this message translates to:
  /// **'Spending by Category'**
  String get stats_category_spending_title;

  /// Message when no category data is available
  ///
  /// In en, this message translates to:
  /// **'No category spending data available.'**
  String get stats_category_empty_message;

  /// Message when no significant category spending exists
  ///
  /// In en, this message translates to:
  /// **'No significant category spending.'**
  String get stats_category_empty_significant_message;

  /// Title for billing cycle breakdown section
  ///
  /// In en, this message translates to:
  /// **'Breakdown by Billing Cycle'**
  String get stats_billing_type_title;

  /// Subtitle for billing cycle breakdown
  ///
  /// In en, this message translates to:
  /// **'(Based on Monthly Equivalent Cost)'**
  String get stats_billing_type_subtitle;

  /// Message when no billing type data is available
  ///
  /// In en, this message translates to:
  /// **'No billing type data available.'**
  String get stats_billing_type_empty_message;

  /// Title for spending trend section
  ///
  /// In en, this message translates to:
  /// **'Spending Trend - {year}'**
  String stats_spending_trend_title(String year);

  /// Message when no spending trend data is available
  ///
  /// In en, this message translates to:
  /// **'No spending trend data available for {year}.'**
  String stats_spending_trend_empty_message(String year);

  /// Title for top subscriptions section
  ///
  /// In en, this message translates to:
  /// **'Top Spending Subscriptions'**
  String get stats_top_subscriptions_title;

  /// Subtitle for top subscriptions section
  ///
  /// In en, this message translates to:
  /// **'(Based on Monthly Equivalent Cost)'**
  String get stats_top_subscriptions_subtitle;

  /// Message when no top subscriptions are available
  ///
  /// In en, this message translates to:
  /// **'No subscriptions to display in top list.'**
  String get stats_top_subscriptions_empty_message;

  /// Label for per month indication
  ///
  /// In en, this message translates to:
  /// **'per month'**
  String get stats_per_month_label;

  /// Abbreviation for single subscription
  ///
  /// In en, this message translates to:
  /// **'sub'**
  String get stats_subscription_abbrev_single;

  /// Abbreviation for multiple subscriptions
  ///
  /// In en, this message translates to:
  /// **'subs'**
  String get stats_subscription_abbrev_multiple;

  /// Title for salary contribution section
  ///
  /// In en, this message translates to:
  /// **'Salary Contribution'**
  String get stats_salary_contribution_title;

  /// Message showing salary contribution percentage
  ///
  /// In en, this message translates to:
  /// **'You\'re spending {percentage}% of your yearly salary ({salary}) on subscriptions.'**
  String stats_salary_contribution_message(String percentage, String salary);

  /// Title for first onboarding page
  ///
  /// In en, this message translates to:
  /// **'Welcome to AboApp!'**
  String get onboarding_page1_title;

  /// Description for first onboarding page
  ///
  /// In en, this message translates to:
  /// **'Track your subscriptions and save money effortlessly.'**
  String get onboarding_page1_desc;

  /// Title for second onboarding page
  ///
  /// In en, this message translates to:
  /// **'Add Subscriptions Easily'**
  String get onboarding_page2_title;

  /// Description for second onboarding page
  ///
  /// In en, this message translates to:
  /// **'Quickly add all your recurring payments from various services.'**
  String get onboarding_page2_desc;

  /// Title for third onboarding page
  ///
  /// In en, this message translates to:
  /// **'Stay on Top of Costs'**
  String get onboarding_page3_title;

  /// Description for third onboarding page
  ///
  /// In en, this message translates to:
  /// **'See clear summaries of your monthly and yearly expenses.'**
  String get onboarding_page3_desc;

  /// Title for fourth onboarding page
  ///
  /// In en, this message translates to:
  /// **'Never Miss a Payment'**
  String get onboarding_page4_title;

  /// Description for fourth onboarding page
  ///
  /// In en, this message translates to:
  /// **'Get timely reminders before your subscriptions are due.'**
  String get onboarding_page4_desc;

  /// Button to skip onboarding
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboarding_skip_button;

  /// Button to go to next onboarding page
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboarding_next_button;

  /// Button to complete onboarding
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboarding_get_started_button;

  /// Title for salary onboarding page
  ///
  /// In en, this message translates to:
  /// **'Optional: Salary Insights'**
  String get onboarding_salary_optional_title;

  /// Description for salary onboarding page
  ///
  /// In en, this message translates to:
  /// **'Enter your salary to see what percentage of it goes to subscriptions. This is optional and stored only on your device.'**
  String get onboarding_salary_optional_desc;

  /// Hint text for salary input
  ///
  /// In en, this message translates to:
  /// **'e.g., 5000'**
  String get onboarding_salary_hint;

  /// Title for email suggestions screen
  ///
  /// In en, this message translates to:
  /// **'Email Suggestions'**
  String get suggestions_title;

  /// Message when no email suggestions are found
  ///
  /// In en, this message translates to:
  /// **'No suggestions found'**
  String get suggestions_empty;

  /// Button to start scanning emails
  ///
  /// In en, this message translates to:
  /// **'Scan Emails'**
  String get suggestions_start_scan;

  /// Title for page not found error
  ///
  /// In en, this message translates to:
  /// **'Page Not Found'**
  String get page_not_found_title;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
