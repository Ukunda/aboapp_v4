import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:aboapp/features/settings/domain/repositories/settings_repository.dart';
import 'package:aboapp/features/settings/domain/usecases/get_settings_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_theme_setting_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_locale_setting_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_currency_setting_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_salary_settings_usecase.dart';

class FakeSettingsRepository implements SettingsRepository {
  SettingsEntity settings;
  ThemeMode? savedThemeMode;
  Locale? savedLocale;
  String? savedCurrencyCode;
  double? savedSalary;
  SalaryCycle savedSalaryCycle;
  bool savedHasThirteenth;

  FakeSettingsRepository({required this.settings})
      : savedSalaryCycle = settings.salaryCycle,
        savedHasThirteenth = settings.hasThirteenthSalary,
        savedSalary = settings.salary;

  @override
  Future<SettingsEntity> getSettings() async => settings;

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    savedThemeMode = themeMode;
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    savedLocale = locale;
  }

  @override
  Future<void> saveCurrencyCode(String currencyCode) async {
    savedCurrencyCode = currencyCode;
  }

  @override
  Future<void> saveSalarySettings({
    required double? salary,
    required SalaryCycle salaryCycle,
    required bool hasThirteenthSalary,
  }) async {
    savedSalary = salary;
    savedSalaryCycle = salaryCycle;
    savedHasThirteenth = hasThirteenthSalary;
  }
}

void main() {
  group('SettingsCubit', () {
    late FakeSettingsRepository repository;
    late SettingsCubit cubit;

    setUp(() {
      repository = FakeSettingsRepository(
        settings: const SettingsEntity(
          themeMode: ThemeMode.dark,
          locale: Locale('de', 'DE'),
          currencyCode: 'EUR',
          salary: 1000,
          salaryCycle: SalaryCycle.monthly,
          hasThirteenthSalary: true,
        ),
      );

      cubit = SettingsCubit(
        GetSettingsUseCase(repository),
        SaveThemeSettingUseCase(repository),
        SaveLocaleSettingUseCase(repository),
        SaveCurrencySettingUseCase(repository),
        SaveSalarySettingsUseCase(repository),
      );
    });

    test('loadSettings updates state from repository', () async {
      await cubit.loadSettings();

      expect(cubit.state.themeMode, ThemeMode.dark);
      expect(cubit.state.locale, const Locale('de', 'DE'));
      expect(cubit.state.currencyCode, 'EUR');
      expect(cubit.state.salary, 1000);
      expect(cubit.state.hasThirteenthSalary, true);
      expect(cubit.state.isLoading, false);
      expect(cubit.state.error, isNull);
    });

    test('updateThemeMode persists value', () async {
      await cubit.updateThemeMode(ThemeMode.light);

      expect(cubit.state.themeMode, ThemeMode.light);
      expect(repository.savedThemeMode, ThemeMode.light);
    });
  });
}
