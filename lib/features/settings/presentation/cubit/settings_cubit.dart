// lib/features/settings/presentation/cubit/settings_cubit.dart

import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:aboapp/features/settings/domain/usecases/get_settings_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_currency_setting_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_locale_setting_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_salary_settings_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_theme_setting_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'settings_state.dart';
part 'settings_cubit.freezed.dart';

@injectable
class SettingsCubit extends Cubit<SettingsState> {
  final GetSettingsUseCase _getSettings;
  final SaveThemeSettingUseCase _saveThemeSetting;
  final SaveLocaleSettingUseCase _saveLocaleSetting;
  final SaveCurrencySettingUseCase _saveCurrencySetting;
  final SaveSalarySettingsUseCase _saveSalarySettings;

  SettingsCubit(
    this._getSettings,
    this._saveThemeSetting,
    this._saveLocaleSetting,
    this._saveCurrencySetting,
    this._saveSalarySettings,
  ) : super(SettingsState.initial());

  Future<void> loadSettings() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final settingsEntity = await _getSettings();
      emit(state.copyWith(
        themeMode: settingsEntity.themeMode,
        locale: settingsEntity.locale,
        currencyCode: settingsEntity.currencyCode,
        salary: settingsEntity.salary,
        salaryCycle: settingsEntity.salaryCycle,
        hasThirteenthSalary: settingsEntity.hasThirteenthSalary,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> updateSalarySettings({
    double? salary,
    SalaryCycle? salaryCycle,
    bool? hasThirteenthSalary,
  }) async {
    // Wenn ein Wert null ist, den aktuellen State-Wert verwenden
    final newSalary = salary ?? state.salary;
    final newCycle = salaryCycle ?? state.salaryCycle;
    final newHasThirteenth = hasThirteenthSalary ?? state.hasThirteenthSalary;

    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _saveSalarySettings(
        salary: newSalary,
        salaryCycle: newCycle,
        hasThirteenthSalary: newHasThirteenth,
      );
      emit(state.copyWith(
        salary: newSalary,
        salaryCycle: newCycle,
        hasThirteenthSalary: newHasThirteenth,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> updateThemeMode(ThemeMode newThemeMode) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _saveThemeSetting(newThemeMode);
      emit(state.copyWith(themeMode: newThemeMode, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> updateLocale(Locale newLocale) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _saveLocaleSetting(newLocale);
      emit(state.copyWith(locale: newLocale, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> updateCurrencyCode(String newCurrencyCode) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _saveCurrencySetting(newCurrencyCode);
      emit(state.copyWith(currencyCode: newCurrencyCode, isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
