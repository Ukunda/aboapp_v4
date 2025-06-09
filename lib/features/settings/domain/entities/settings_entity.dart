// lib/features/settings/domain/entities/settings_entity.dart
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_entity.freezed.dart';

enum AppUIStyle {
  classic,
  modern,
}

@freezed
class SettingsEntity with _$SettingsEntity {
  const factory SettingsEntity({
    required AppUIStyle uiStyle,
    required ThemeMode themeMode,
    required Locale locale,
    required String currencyCode,
  }) = _SettingsEntity;

  factory SettingsEntity.defaultSettings() => const SettingsEntity(
        uiStyle: AppUIStyle.classic, // Default to classic
        themeMode: ThemeMode.system,
        locale: Locale('en', 'US'),
        currencyCode: 'USD',
      );
}
