import 'package:intl/intl.dart';
import 'package:flutter/material.dart'; // For Locale, though intl handles most locale-specific formatting

class DateFormatter {
  // Default date format, e.g., "15 Oct, 2023"
  static String formatDate(DateTime? date, {Locale? locale}) {
    if (date == null) return 'N/A'; // Or handle as an error, or return empty string
    // The locale string for DateFormat can be like 'en_US', 'de_DE'
    final String localeString = locale?.toLanguageTag().replaceAll('-', '_') ?? 'en_US'; // Default if no locale
    return DateFormat('dd MMM, yyyy', localeString).format(date);
  }

  // Short date format, e.g., "10/15/2023" (US) or "15.10.2023" (DE)
  static String formatShortDate(DateTime? date, {Locale? locale}) {
    if (date == null) return 'N/A';
    final String localeString = locale?.toLanguageTag().replaceAll('-', '_') ?? 'en_US';
    return DateFormat.yMd(localeString).format(date); // yMd is locale-aware
  }
  
  // Month and Year, e.g., "October 2023"
  static String formatMonthYear(DateTime? date, {Locale? locale}) {
    if (date == null) return 'N/A';
    final String localeString = locale?.toLanguageTag().replaceAll('-', '_') ?? 'en_US';
    return DateFormat.yMMMM(localeString).format(date); // yMMMM for full month name and year
  }

  // Relative date for "days until" or "days ago" logic
  // This is a simplified version. For more complex relative time, consider a package like `timeago`.
  static String formatDaysUntil(DateTime date, {Locale? locale, String? overdueText, String? todayText, String? tomorrowText, String? daysAgoText, String? daysFutureText}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDay = DateTime(date.year, date.month, date.day);
    final differenceInDays = targetDay.difference(today).inDays;

    // TODO: Use AppLocalizations for these default texts
    final currentOverdueText = overdueText ?? '{days} days ago';
    final currentTodayText = todayText ?? 'Today';
    final currentTomorrowText = tomorrowText ?? 'Tomorrow';
    final currentDaysAgoText = daysAgoText ?? '{days} days ago'; // For past dates beyond yesterday
    final currentDaysFutureText = daysFutureText ?? 'in {days} days';

    if (differenceInDays < 0) {
      return currentDaysAgoText.replaceAll('{days}', differenceInDays.abs().toString());
    } else if (differenceInDays == 0) {
      return currentTodayText;
    } else if (differenceInDays == 1) {
      return currentTomorrowText;
    } else {
      return currentDaysFutureText.replaceAll('{days}', differenceInDays.toString());
    }
  }

  // Time format, e.g., "10:30 AM"
  static String formatTime(DateTime? time, {Locale? locale}) {
    if (time == null) return 'N/A';
    final String localeString = locale?.toLanguageTag().replaceAll('-', '_') ?? 'en_US';
    return DateFormat.jm(localeString).format(time); // jm is locale-aware for time (e.g., 10:30 AM / 10:30 Uhr)
  }

  // Full date and time
  static String formatDateTime(DateTime? dateTime, {Locale? locale}) {
    if (dateTime == null) return 'N/A';
    final String localeString = locale?.toLanguageTag().replaceAll('-', '_') ?? 'en_US';
    return DateFormat.yMMMMEEEEd(localeString).add_jm().format(dateTime); // Example: "Wed, Oct 15, 2023, 10:30 AM"
  }
}