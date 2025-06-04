import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:flutter/material.dart'; // For ThemeMode and Locale

abstract class SettingsRepository {
  Future<SettingsEntity> getSettings();
  Future<void> saveThemeMode(ThemeMode themeMode);
  Future<void> saveLocale(Locale locale);
  Future<void> saveCurrencyCode(String currencyCode);
  // Future<void> saveSettings(SettingsEntity settings); // Alternative: save all at once
}