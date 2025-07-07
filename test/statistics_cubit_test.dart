import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:aboapp/features/settings/domain/repositories/settings_repository.dart';
import 'package:aboapp/features/settings/domain/usecases/get_settings_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_theme_setting_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_locale_setting_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_currency_setting_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_salary_settings_usecase.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/get_all_subscriptions_usecase.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/add_subscription_usecase.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/update_subscription_usecase.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/delete_subscription_usecase.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';
import 'package:aboapp/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:uuid/uuid.dart';

class FakeSubscriptionRepository implements SubscriptionRepository {
  List<SubscriptionEntity> subs;
  FakeSubscriptionRepository({required this.subs});

  @override
  Future<void> addSubscription(SubscriptionEntity subscription) async {
    subs.add(subscription);
  }

  @override
  Future<void> deleteSubscription(String id) async {
    subs.removeWhere((s) => s.id == id);
  }

  @override
  Future<List<SubscriptionEntity>> getAllSubscriptions() async => List.from(subs);

  @override
  Future<SubscriptionEntity?> getSubscriptionById(String id) async {
    try {
      return subs.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveAllSubscriptions(List<SubscriptionEntity> subscriptions) async {
    subs = subscriptions;
  }

  @override
  Future<void> updateSubscription(SubscriptionEntity subscription) async {
    final index = subs.indexWhere((s) => s.id == subscription.id);
    if (index != -1) {
      subs[index] = subscription;
    } else {
      subs.add(subscription);
    }
  }
}

class FakeSettingsRepository implements SettingsRepository {
  SettingsEntity settings;
  FakeSettingsRepository({required this.settings});

  @override
  Future<SettingsEntity> getSettings() async => settings;

  @override
  Future<void> saveThemeMode(ThemeMode themeMode) async {
    settings = settings.copyWith(themeMode: themeMode);
  }

  @override
  Future<void> saveLocale(Locale locale) async {
    settings = settings.copyWith(locale: locale);
  }

  @override
  Future<void> saveCurrencyCode(String currencyCode) async {
    settings = settings.copyWith(currencyCode: currencyCode);
  }

  @override
  Future<void> saveSalarySettings({
    required double? salary,
    required SalaryCycle salaryCycle,
    required bool hasThirteenthSalary,
  }) async {
    settings = settings.copyWith(
      salary: salary,
      salaryCycle: salaryCycle,
      hasThirteenthSalary: hasThirteenthSalary,
    );
  }
}

void main() {
  group('StatisticsCubit', () {
    late SubscriptionCubit subscriptionCubit;
    late SettingsCubit settingsCubit;
    late StatisticsCubit statisticsCubit;

    setUp(() {
      final subRepo = FakeSubscriptionRepository(subs: []);
      subscriptionCubit = SubscriptionCubit(
        GetAllSubscriptionsUseCase(subRepo),
        AddSubscriptionUseCase(subRepo),
        UpdateSubscriptionUseCase(subRepo),
        DeleteSubscriptionUseCase(subRepo),
        const Uuid(),
      );

      final settingsRepo = FakeSettingsRepository(
        settings: const SettingsEntity(
          themeMode: ThemeMode.system,
          locale: Locale('en', 'US'),
          currencyCode: 'USD',
          salary: 1200,
          salaryCycle: SalaryCycle.monthly,
          hasThirteenthSalary: true,
        ),
      );
      settingsCubit = SettingsCubit(
        GetSettingsUseCase(settingsRepo),
        SaveThemeSettingUseCase(settingsRepo),
        SaveLocaleSettingUseCase(settingsRepo),
        SaveCurrencySettingUseCase(settingsRepo),
        SaveSalarySettingsUseCase(settingsRepo),
      );
    });

    test('generateStatistics emits empty when no active subscriptions', () {
      subscriptionCubit.emit(const SubscriptionState.loaded(
        allSubscriptions: [],
        filteredSubscriptions: [],
        currentSortOption: SortOption.nextBillingDateAsc,
        filterCategories: [],
        filterBillingCycles: [],
        searchTerm: null,
      ));
      settingsCubit.emit(settingsCubit.state.copyWith(
        salary: 1200,
        salaryCycle: SalaryCycle.monthly,
        hasThirteenthSalary: true,
        isLoading: false,
      ));

      statisticsCubit = StatisticsCubit(
        subscriptionCubit: subscriptionCubit,
        settingsCubit: settingsCubit,
      );

      statisticsCubit.generateStatistics();

      statisticsCubit.state.maybeWhen(
        empty: (msg) => expect(msg, isNotEmpty),
        orElse: () => fail('State should be empty'),
      );
    });

    test('generateStatistics computes totals from active subscriptions', () {
      final sub1 = SubscriptionEntity(
        id: '1',
        name: 'A',
        price: 10,
        billingCycle: BillingCycle.monthly,
        nextBillingDate: DateTime(2025, 1, 1),
        category: SubscriptionCategory.streaming,
      );
      final sub2 = SubscriptionEntity(
        id: '2',
        name: 'B',
        price: 120,
        billingCycle: BillingCycle.yearly,
        nextBillingDate: DateTime(2025, 2, 1),
        category: SubscriptionCategory.software,
      );

      subscriptionCubit.emit(SubscriptionState.loaded(
        allSubscriptions: [sub1, sub2],
        filteredSubscriptions: [sub1, sub2],
        currentSortOption: SortOption.nextBillingDateAsc,
        filterCategories: [],
        filterBillingCycles: [],
        searchTerm: null,
      ));
      settingsCubit.emit(settingsCubit.state.copyWith(
        salary: 1200,
        salaryCycle: SalaryCycle.monthly,
        hasThirteenthSalary: true,
        isLoading: false,
      ));

      statisticsCubit = StatisticsCubit(
        subscriptionCubit: subscriptionCubit,
        settingsCubit: settingsCubit,
      );

      statisticsCubit.generateStatistics();

      statisticsCubit.state.maybeWhen(
        loaded: (
          active,
          category,
          billing,
          top,
          trend,
          monthly,
          yearly,
          selectedYear,
          salary,
          percent,
        ) {
          expect(active.length, 2);
          expect(monthly, closeTo(20, 0.001));
          expect(yearly, closeTo(240, 0.001));
          expect(percent, isNotNull);
        },
        orElse: () => fail('State should be loaded'),
      );
    });

    test('changeTrendYear updates selected year', () {
      subscriptionCubit.emit(const SubscriptionState.loaded(
        allSubscriptions: [],
        filteredSubscriptions: [],
        currentSortOption: SortOption.nextBillingDateAsc,
        filterCategories: [],
        filterBillingCycles: [],
        searchTerm: null,
      ));
      settingsCubit.emit(settingsCubit.state.copyWith(
        salary: 1200,
        salaryCycle: SalaryCycle.monthly,
        hasThirteenthSalary: true,
        isLoading: false,
      ));
      statisticsCubit = StatisticsCubit(
        subscriptionCubit: subscriptionCubit,
        settingsCubit: settingsCubit,
      );

      statisticsCubit.generateStatistics();

      expect(() => statisticsCubit.changeTrendYear(2023), returnsNormally);
    });
  });
}
