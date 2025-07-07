// lib/features/settings/domain/repositories/settings_repository.dart

import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:flutter/material.dart';

abstract class SettingsRepository {
  Future<SettingsEntity> getSettings();
  Future<void> saveThemeMode(ThemeMode themeMode);
  Future<void> saveLocale(Locale locale);
  Future<void> saveCurrencyCode(String currencyCode);
  // NEU
  Future<void> saveSalarySettings({
    required double? salary,
    required SalaryCycle salaryCycle,
    required bool hasThirteenthSalary,
  });
}
