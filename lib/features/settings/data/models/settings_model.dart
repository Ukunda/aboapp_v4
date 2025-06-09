// lib/features/settings/data/models/settings_model.dart

import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart';

// --- Custom converters ---
class AppUIStyleConverter implements JsonConverter<AppUIStyle, String> {
  const AppUIStyleConverter();
  @override
  AppUIStyle fromJson(String json) =>
      AppUIStyle.values.firstWhere((e) => e.toString() == json,
          orElse: () => AppUIStyle.classic);
  @override
  String toJson(AppUIStyle object) => object.toString();
}

class ThemeModeConverter implements JsonConverter<ThemeMode, String> {
  const ThemeModeConverter();
  @override
  ThemeMode fromJson(String json) => ThemeMode.values
      .firstWhere((e) => e.toString() == json, orElse: () => ThemeMode.system);
  @override
  String toJson(ThemeMode object) => object.toString();
}

class LocaleConverter implements JsonConverter<Locale, String> {
  const LocaleConverter();
  @override
  Locale fromJson(String json) {
    final parts = json.split('_');
    return parts.length == 2 ? Locale(parts[0], parts[1]) : Locale(parts[0]);
  }

  @override
  String toJson(Locale object) => object.toLanguageTag().replaceAll('-', '_');
}
// --- End of converters ---

@freezed
class SettingsModel with _$SettingsModel {
  const SettingsModel._();

  const factory SettingsModel({
    @AppUIStyleConverter() required AppUIStyle uiStyle,
    @ThemeModeConverter() required ThemeMode themeMode,
    @LocaleConverter() required Locale locale,
    required String currencyCode,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  factory SettingsModel.fromEntity(SettingsEntity entity) {
    return SettingsModel(
      uiStyle: entity.uiStyle,
      themeMode: entity.themeMode,
      locale: entity.locale,
      currencyCode: entity.currencyCode,
    );
  }

  SettingsEntity toEntity() {
    return SettingsEntity(
      uiStyle: uiStyle,
      themeMode: themeMode,
      locale: locale,
      currencyCode: currencyCode,
    );
  }
}
