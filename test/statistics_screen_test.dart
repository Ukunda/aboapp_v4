import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aboapp/features/statistics/presentation/screens/statistics_screen.dart';
import 'package:aboapp/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/add_subscription_usecase.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/delete_subscription_usecase.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/get_all_subscriptions_usecase.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/update_subscription_usecase.dart';
import 'package:aboapp/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:aboapp/features/settings/domain/repositories/settings_repository.dart';
import 'package:aboapp/features/settings/domain/usecases/get_settings_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_theme_setting_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_locale_setting_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_currency_setting_usecase.dart';
import 'package:aboapp/features/settings/domain/usecases/save_salary_settings_usecase.dart';
import 'package:aboapp/core/localization/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
  Future<void> saveThemeMode(ThemeMode themeMode) async {}

  @override
  Future<void> saveLocale(Locale locale) async {}

  @override
  Future<void> saveCurrencyCode(String currencyCode) async {}

  @override
  Future<void> saveSalarySettings({
    required double? salary,
    required SalaryCycle salaryCycle,
    required bool hasThirteenthSalary,
  }) async {}
}

void main() {
  testWidgets('StatisticsScreen displays stats data', (tester) async {
    final subRepo = FakeSubscriptionRepository(subs: [
      SubscriptionEntity(
        id: '1',
        name: 'A',
        price: 10,
        billingCycle: BillingCycle.monthly,
        nextBillingDate: DateTime(2025, 1, 1),
        category: SubscriptionCategory.streaming,
      ),
    ]);
    final subscriptionCubit = SubscriptionCubit(
      GetAllSubscriptionsUseCase(subRepo),
      AddSubscriptionUseCase(subRepo),
      UpdateSubscriptionUseCase(subRepo),
      DeleteSubscriptionUseCase(subRepo),
      const Uuid(),
    );
    subscriptionCubit.emit(SubscriptionState.loaded(
      allSubscriptions: subRepo.subs,
      filteredSubscriptions: subRepo.subs,
      currentSortOption: SortOption.nextBillingDateAsc,
      filterCategories: const [],
      filterBillingCycles: const [],
      searchTerm: null,
    ));

    final settingsCubit = SettingsCubit(
      GetSettingsUseCase(FakeSettingsRepository(
          settings: const SettingsEntity(
        themeMode: ThemeMode.system,
        locale: Locale('en', 'US'),
        currencyCode: 'USD',
      ))),
      SaveThemeSettingUseCase(FakeSettingsRepository(
          settings: const SettingsEntity(
        themeMode: ThemeMode.system,
        locale: Locale('en', 'US'),
        currencyCode: 'USD',
      ))),
      SaveLocaleSettingUseCase(FakeSettingsRepository(
          settings: const SettingsEntity(
        themeMode: ThemeMode.system,
        locale: Locale('en', 'US'),
        currencyCode: 'USD',
      ))),
      SaveCurrencySettingUseCase(FakeSettingsRepository(
          settings: const SettingsEntity(
        themeMode: ThemeMode.system,
        locale: Locale('en', 'US'),
        currencyCode: 'USD',
      ))),
      SaveSalarySettingsUseCase(FakeSettingsRepository(
          settings: const SettingsEntity(
        themeMode: ThemeMode.system,
        locale: Locale('en', 'US'),
        currencyCode: 'USD',
      ))),
    );
    settingsCubit.emit(settingsCubit.state.copyWith(isLoading: false));

    final statisticsCubit = StatisticsCubit(
      subscriptionCubit: subscriptionCubit,
      settingsCubit: settingsCubit,
    );
    statisticsCubit.generateStatistics();

    await tester.pumpWidget(MultiBlocProvider(
      providers: [
        BlocProvider.value(value: subscriptionCubit),
        BlocProvider.value(value: settingsCubit),
        BlocProvider.value(value: statisticsCubit),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('en', 'US')],
        home: const StatisticsScreen(),
      ),
    ));

    await tester.pumpAndSettle();

    expect(find.text('Statistics'), findsOneWidget);
  });
}
