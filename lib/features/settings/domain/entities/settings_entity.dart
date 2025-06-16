// lib/features/settings/domain/entities/settings_entity.dart
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_entity.freezed.dart';

// NEU: Enum zur Unterscheidung des Gehaltszyklus
enum SalaryCycle { monthly, yearly }

@freezed
class SettingsEntity with _$SettingsEntity {
  const factory SettingsEntity({
    required ThemeMode themeMode,
    required Locale locale,
    required String currencyCode,
    // --- NEUE FELDER FÜR GEHALT ---
    double? salary,
    @Default(SalaryCycle.monthly) SalaryCycle salaryCycle,
    @Default(false) bool hasThirteenthSalary,
  }) = _SettingsEntity;

  factory SettingsEntity.defaultSettings() => const SettingsEntity(
        themeMode: ThemeMode.system,
        locale: Locale('en', 'US'),
        currencyCode: 'USD',
        salary: null,
        salaryCycle: SalaryCycle.monthly,
        hasThirteenthSalary: false,
      );
}
