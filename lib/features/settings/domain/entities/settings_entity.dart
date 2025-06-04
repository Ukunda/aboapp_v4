import 'package:flutter/material.dart'; // For ThemeMode and Locale
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_entity.freezed.dart';

@freezed
class SettingsEntity with _$SettingsEntity {
  const factory SettingsEntity({
    required ThemeMode themeMode,
    required Locale locale,
    required String currencyCode, // e.g., "USD", "EUR"
    // Add other app-wide settings here if needed
    // Example: bool enableNotificationsGlobally,
  }) = _SettingsEntity;

  // Default settings
  factory SettingsEntity.defaultSettings() => const SettingsEntity(
        themeMode: ThemeMode.system,
        locale: Locale('en', 'US'), // Default to English (US)
        currencyCode: 'USD', // Default to USD
      );
}