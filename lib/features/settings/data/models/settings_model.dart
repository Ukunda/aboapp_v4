import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:flutter/material.dart'; // For ThemeMode and Locale
import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_model.freezed.dart';
part 'settings_model.g.dart'; // For JSON serialization

// Custom converter for ThemeMode
class ThemeModeConverter implements JsonConverter<ThemeMode, String> {
  const ThemeModeConverter();

  @override
  ThemeMode fromJson(String json) {
    return ThemeMode.values.firstWhere((e) => e.toString() == json, orElse: () => ThemeMode.system);
  }

  @override
  String toJson(ThemeMode object) {
    return object.toString();
  }
}

// Custom converter for Locale
class LocaleConverter implements JsonConverter<Locale, String> {
  const LocaleConverter();

  @override
  Locale fromJson(String json) {
    final parts = json.split('_');
    if (parts.length == 2) {
      return Locale(parts[0], parts[1]);
    }
    return Locale(parts[0]);
  }

  @override
  String toJson(Locale object) {
    return object.toLanguageTag().replaceAll('-', '_'); // Ensure consistent format
  }
}


@freezed
class SettingsModel with _$SettingsModel {
  const SettingsModel._(); // For toEntity method

  @JsonSerializable(explicitToJson: true)
  const factory SettingsModel({
    @ThemeModeConverter() required ThemeMode themeMode,
    @LocaleConverter() required Locale locale,
    required String currencyCode,
  }) = _SettingsModel;

  factory SettingsModel.fromJson(Map<String, dynamic> json) =>
      _$SettingsModelFromJson(json);

  // Conversion to Domain Entity
  SettingsEntity toEntity() {
    return SettingsEntity(
      themeMode: themeMode,
      locale: locale,
      currencyCode: currencyCode,
    );
  }

  // Conversion from Domain Entity
  factory SettingsModel.fromEntity(SettingsEntity entity) {
    return SettingsModel(
      themeMode: entity.themeMode,
      locale: entity.locale,
      currencyCode: entity.currencyCode,
    );
  }
}