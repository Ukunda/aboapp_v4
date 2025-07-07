// lib/features/settings/data/datasources/settings_local_datasource.dart

import 'dart:convert';
import 'dart:io'; // For Platform.localeName
import 'package:aboapp/features/settings/data/models/settings_model.dart';
import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart'; // For NumberFormat
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SettingsLocalDataSource {
  Future<SettingsModel> getSettings();
  Future<void> saveThemeMode(ThemeMode themeMode);
  Future<void> saveLocale(Locale locale);
  Future<void> saveCurrencyCode(String currencyCode);
  Future<void> saveSalarySettings({
    required double? salary,
    required SalaryCycle salaryCycle,
    required bool hasThirteenthSalary,
  });
}

const String settingsKey = 'APP_SETTINGS';
const Set<String> _supportedLanguages = {'en', 'de'};
const Set<String> _supportedCurrencies = {'USD', 'EUR', 'GBP', 'JPY', 'CHF'};

@LazySingleton(as: SettingsLocalDataSource)
class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  final FlutterSecureStorage secureStorage;

  SettingsLocalDataSourceImpl(this.secureStorage);

  @override
  Future<SettingsModel> getSettings() async {
    final jsonString = await secureStorage.read(key: settingsKey);
    if (jsonString != null) {
      try {
        return SettingsModel.fromJson(
            jsonDecode(jsonString) as Map<String, dynamic>);
      } catch (e) {
        // Data is corrupted, remove it and create fresh defaults
        await secureStorage.delete(key: settingsKey);
        return await _createDefaultSettingsWithAutoDetect();
      }
    } else {
      // No settings found, create initial defaults with auto-detection
      return await _createDefaultSettingsWithAutoDetect();
    }
  }

  /// Creates a default settings model, attempting to use the device's
  /// locale to determine a sensible default currency and language.
  Future<SettingsModel> _createDefaultSettingsWithAutoDetect() async {
    var defaultSettings = SettingsEntity.defaultSettings();

    try {
      final String deviceLocaleStr = Platform.localeName;

      // --- Auto-detect and set Currency ---
      // CORRECTION: Use `currencyName` which returns the ISO 4217 code.
      final format = NumberFormat.simpleCurrency(locale: deviceLocaleStr);
      final detectedCurrencyCode = format.currencyName;

      if (detectedCurrencyCode != null &&
          _supportedCurrencies.contains(detectedCurrencyCode)) {
        defaultSettings =
            defaultSettings.copyWith(currencyCode: detectedCurrencyCode);
      }

      // --- Auto-detect and set Locale ---
      final localeParts = deviceLocaleStr.split(RegExp(r'[_-]'));
      if (localeParts.isNotEmpty) {
        final langCode = localeParts[0].toLowerCase();
        if (_supportedLanguages.contains(langCode)) {
          final countryCode = localeParts.length > 1 ? localeParts[1] : null;
          defaultSettings =
              defaultSettings.copyWith(locale: Locale(langCode, countryCode));
        }
      }
    } catch (e) {
      // Silently fail, the hardcoded defaults ('USD', 'en_US') from
      // SettingsEntity.defaultSettings() will be used.
    }

    final model = SettingsModel.fromEntity(defaultSettings);
    // Save these new defaults so auto-detection only runs once.
    await _saveSettingsModel(model);
    return model;
  }

  Future<void> _saveSettingsModel(SettingsModel settings) async {
    await secureStorage.write(
      key: settingsKey,
      value: jsonEncode(settings.toJson()),
    );
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