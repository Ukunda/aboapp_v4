import 'package:aboapp/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter/material.dart'; // For ThemeMode
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveThemeSettingUseCase {
  final SettingsRepository repository;

  SaveThemeSettingUseCase(this.repository);

  Future<void> call(ThemeMode themeMode) async {
    return await repository.saveThemeMode(themeMode);
  }
}