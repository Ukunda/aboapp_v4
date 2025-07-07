import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../localization/localization_extension.dart';

/// Context-aware date formatter that automatically uses app locale and translations
class ContextDateFormatter {
  static String formatDate(BuildContext context, DateTime? date) {
    if (date == null) return 'N/A'; 
    final locale = Localizations.localeOf(context);
    final String localeString = locale.toLanguageTag().replaceAll('-', '_');
    return DateFormat('dd MMM, yyyy', localeString).format(date);
  }

  static String formatShortDate(BuildContext context, DateTime? date) {
    if (date == null) return 'N/A';
    final locale = Localizations.localeOf(context);
    final String localeString = locale.toLanguageTag().replaceAll('-', '_');
    return DateFormat.yMd(localeString).format(date); 
  }
  
  static String formatMonthYear(BuildContext context, DateTime? date) {
    if (date == null) return 'N/A';
    final locale = Localizations.localeOf(context);
    final String localeString = locale.toLanguageTag().replaceAll('-', '_');
    return DateFormat.yMMMM(localeString).format(date); 
  }

  static String formatDaysUntil(BuildContext context, DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDay = DateTime(date.year, date.month, date.day);
    final differenceInDays = targetDay.difference(today).inDays;

    // Use localized strings from translations
    final todayText = context.tr('subscription_card_days_until_label_today');
    final tomorrowText = context.tr('subscription_card_days_until_label_tomorrow');
    final daysAgoPrefix = context.tr('subscription_card_days_until_label_overdue_prefix');
    final daysAgoSuffix = context.tr('subscription_card_days_until_label_overdue_suffix');
    final daysFuturePrefix = context.tr('subscription_card_days_until_label_prefix');
    final daysFutureSuffix = context.tr('subscription_card_days_until_label_suffix');

    if (differenceInDays < 0) {
      return '$daysAgoPrefix${differenceInDays.abs()}$daysAgoSuffix';
    } else if (differenceInDays == 0) {
      return todayText;
    } else if (differenceInDays == 1) {
      return tomorrowText;
    } else {
      return '$daysFuturePrefix$differenceInDays$daysFutureSuffix';
    }
  }

  static String formatTime(BuildContext context, DateTime? time) {
    if (time == null) return 'N/A';
    final locale = Localizations.localeOf(context);
    final String localeString = locale.toLanguageTag().replaceAll('-', '_');
    return DateFormat.jm(localeString).format(time); 
  }

  static String formatDateTime(BuildContext context, DateTime? dateTime) {
    if (dateTime == null) return 'N/A';
    final locale = Localizations.localeOf(context);
    final String localeString = locale.toLanguageTag().replaceAll('-', '_');
    return DateFormat.yMMMMEEEEd(localeString).add_jm().format(dateTime); 
  }
}