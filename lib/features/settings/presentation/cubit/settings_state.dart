// lib/features/settings/presentation/cubit/settings_state.dart
part of 'settings_cubit.dart';

@freezed
class SettingsState with _$SettingsState {
  const factory SettingsState({
    required ThemeMode themeMode,
    required Locale locale,
    required String currencyCode,
    double? salary,
    @Default(SalaryCycle.monthly) SalaryCycle salaryCycle,
    @Default(false) bool hasThirteenthSalary,
    @Default(false) bool isLoading,
    String? error,
  }) = _SettingsState;

  factory SettingsState.initial() => const SettingsState(
        themeMode: ThemeMode.system,
        locale: Locale('en', 'US'),
        currencyCode: 'USD',
        salary: null,
        salaryCycle: SalaryCycle.monthly,
        hasThirteenthSalary: false,
      );
}
