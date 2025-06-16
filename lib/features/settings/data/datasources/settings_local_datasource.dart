// lib/features/settings/data/datasources/settings_local_datasource.dart

import 'dart:convert';
import 'package:aboapp/features/settings/data/models/settings_model.dart';
import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsLocalDataSource {
  Future<SettingsModel> getSettings();
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

const String settingsKey = 'APP_SETTINGS';

@LazySingleton(as: SettingsLocalDataSource)
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final SharedPreferences sharedPreferences;

  SettingsLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<SettingsModel> getSettings() async {
    final jsonString = sharedPreferences.getString(settingsKey);
    if (jsonString != null) {
      try {
        return SettingsModel.fromJson(
            jsonDecode(jsonString) as Map<String, dynamic>);
      } catch (e) {
        await sharedPreferences.remove(settingsKey);
        return SettingsModel.fromEntity(SettingsEntity.defaultSettings());
      }
    } else {
      return SettingsModel.fromEntity(SettingsEntity.defaultSettings());
    }
  }

  Future<void> _saveSettingsModel(SettingsModel settings) async {
    await sharedPreferences.setString(
        settingsKey, jsonEncode(settings.toJson()));
  }

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    final currentSettings = await getSettings();
    await _saveSettingsModel(currentSettings.copyWith(themeMode: themeMode));
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    final currentSettings = await getSettings();
    await _saveSettingsModel(currentSettings.copyWith(locale: locale));
  }

  @override
  Future<void> saveCurrencyCode(String currencyCode) async {
    final currentSettings = await getSettings();
    await _saveSettingsModel(
        currentSettings.copyWith(currencyCode: currencyCode));
  }

  // NEU
  @override
  Future<void> saveSalarySettings(
      {required double? salary,
      required SalaryCycle salaryCycle,
      required bool hasThirteenthSalary}) async {
    final currentSettings = await getSettings();
    await _saveSettingsModel(currentSettings.copyWith(
      salary: salary,
      salaryCycle: salaryCycle,
      hasThirteenthSalary: hasThirteenthSalary,
    ));
  }
}
