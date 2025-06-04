import 'package:aboapp/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:aboapp/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter/material.dart'; // For ThemeMode and Locale
import 'package:injectable/injectable.dart';

@LazySingleton(as: SettingsRepository)
class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl(this.localDataSource);

  @override
  Future<SettingsEntity> getSettings() async {
    try {
      final settingsModel = await localDataSource.getSettings();
      return settingsModel.toEntity();
    } catch (e) {
      // In case of an error (e.g., parsing), return default settings
      // The local data source should ideally handle this and provide a default model
      print('Error in SettingsRepositoryImpl.getSettings: $e');
      return SettingsEntity.defaultSettings();
    }
  }

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    await localDataSource.saveThemeMode(themeMode);
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    await localDataSource.saveLocale(locale);
  }

  @override
  Future<void> saveCurrencyCode(String currencyCode) async {
    await localDataSource.saveCurrencyCode(currencyCode);
  }
}