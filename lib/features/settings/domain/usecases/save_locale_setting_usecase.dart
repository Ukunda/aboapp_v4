import 'package:aboapp/features/settings/domain/repositories/settings_repository.dart';
import 'package:flutter/material.dart'; // For Locale
import 'package:injectable/injectable.dart';

@lazySingleton
class SaveLocaleSettingUseCase {
  final SettingsRepository repository;

  SaveLocaleSettingUseCase(this.repository);

  Future<void> call(Locale locale) async {
    return await repository.saveLocale(locale);
  }
}