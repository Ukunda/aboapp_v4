import 'package:intl/intl.dart';
import 'package:flutter/material.dart'; // For Locale

class DateFormatter {
  static String formatDate(DateTime? date, {Locale? locale}) {
    if (date == null) return 'N/A'; 
    final String localeString = locale?.toLanguageTag().replaceAll('-', '_') ?? 'en_US'; 
    return DateFormat('dd MMM, yyyy', localeString).format(date);
  }

  static String formatShortDate(DateTime? date, {Locale? locale}) {
    if (date == null) return 'N/A';
    final String localeString = locale?.toLanguageTag().replaceAll('-', '_') ?? 'en_US';
    return DateFormat.yMd(localeString).format(date); 
  }
  
  static String formatMonthYear(DateTime? date, {Locale? locale}) {
    if (date == null) return 'N/A';
    final String localeString = locale?.toLanguageTag().replaceAll('-', '_') ?? 'en_US';
    return DateFormat.yMMMM(localeString).format(date); 
  }

  static String formatDaysUntil(DateTime date, {Locale? locale, String? overdueText, String? todayText, String? tomorrowText, String? daysAgoText, String? daysFutureText}) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDay = DateTime(date.year, date.month, date.day);
    final differenceInDays = targetDay.difference(today).inDays;

    // final String currentOverdueText = overdueText ?? '{days} days ago'; // Variable was unused
    final currentTodayText = todayText ?? 'Today';
    final currentTomorrowText = tomorrowText ?? 'Tomorrow';
    final currentDaysAgoText = daysAgoText ?? '{days} days ago'; 
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

  static String formatTime(DateTime? time, {Locale? locale}) {
    if (time == null) return 'N/A';
    final String localeString = locale?.toLanguageTag().replaceAll('-', '_') ?? 'en_US';
    return DateFormat.jm(localeString).format(time); 
  }

  static String formatDateTime(DateTime? dateTime, {Locale? locale}) {
    if (dateTime == null) return 'N/A';
    final String localeString = locale?.toLanguageTag().replaceAll('-', '_') ?? 'en_US';
    return DateFormat.yMMMMEEEEd(localeString).add_jm().format(dateTime); 
  }
}