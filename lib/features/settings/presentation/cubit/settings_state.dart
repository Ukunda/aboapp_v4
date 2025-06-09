// lib/features/settings/presentation/cubit/settings_state.dart
part of 'settings_cubit.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required AppUIStyle uiStyle,
    required ThemeMode themeMode,
    required Locale locale,
    required String currencyCode,
    @Default(false) bool isLoading,
    String? error,
  }) = _SettingsState;

  factory SettingsState.initial() => const SettingsState(
        uiStyle: AppUIStyle.classic,
        themeMode: ThemeMode.system,
        locale: Locale('en', 'US'),
        currencyCode: 'USD',
      );
}
