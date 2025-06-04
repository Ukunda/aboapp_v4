import 'package:aboapp/features/settings/data/datasources/settings_local_datasource.dart';
import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:aboapp/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter/material.dart'; 
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
      // print('Error in SettingsRepositoryImpl.getSettings: $e'); // Avoid print
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