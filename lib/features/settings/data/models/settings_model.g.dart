// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SettingsModelImpl _$$SettingsModelImplFromJson(Map<String, dynamic> json) =>
    _$SettingsModelImpl(
      themeMode:
          const ThemeModeConverter().fromJson(json['themeMode'] as String),
      locale: const LocaleConverter().fromJson(json['locale'] as String),
      currencyCode: json['currencyCode'] as String,
    );

Map<String, dynamic> _$$SettingsModelImplToJson(_$SettingsModelImpl instance) =>
    <String, dynamic>{
      'themeMode': const ThemeModeConverter().toJson(instance.themeMode),
      'locale': const LocaleConverter().toJson(instance.locale),
      'currencyCode': instance.currencyCode,
    };
