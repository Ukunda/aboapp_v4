import 'dart:async';
import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:collection/collection.dart';

part 'statistics_state.dart';
part 'statistics_cubit.freezed.dart';

class StatisticsCubit extends Cubit<StatisticsState> {
  final SubscriptionCubit _subscriptionCubit;
  final SettingsCubit _settingsCubit;
  late final StreamSubscription _subscriptionSubscription;
  late final StreamSubscription _settingsSubscription;

  List<SubscriptionEntity> _latestSubscriptions = [];
  late SettingsEntity _latestSettings;

  StatisticsCubit({
    required SubscriptionCubit subscriptionCubit,
    required SettingsCubit settingsCubit,
  })  : _subscriptionCubit = subscriptionCubit,
        _settingsCubit = settingsCubit,
        super(const StatisticsState.initial()) {
    _updateLatestStates();

    _subscriptionSubscription = _subscriptionCubit.stream.listen((_) {
      _updateLatestStatesAndRecalculate();
    });
    _settingsSubscription = _settingsCubit.stream.listen((_) {
      _updateLatestStatesAndRecalculate();
    });
  }

  void _updateLatestStates() {
    _subscriptionCubit.state.whenOrNull(
      loaded: (all, _, __, ___, ____, _____) {
        _latestSubscriptions = all;
      },
    );
    final settingsState = _settingsCubit.state;
    _latestSettings = SettingsEntity(
      themeMode: settingsState.themeMode,
      locale: settingsState.locale,
      currencyCode: settingsState.currencyCode,
      salary: settingsState.salary,
      salaryCycle: settingsState.salaryCycle,
      hasThirteenthSalary: settingsState.hasThirteenthSalary,
    );
  }

  void _updateLatestStatesAndRecalculate() {
    _updateLatestStates();
    generateStatistics();
  }

  @override
  Future<void> close() {
    _subscriptionSubscription.cancel();
    _settingsSubscription.cancel();
    return super.close();
  }

  void generateStatistics({int? yearForTrend}) {
    emit(const StatisticsState.loading());

    final allSubscriptions = _latestSubscriptions;
    final settings = _latestSettings;

    final activeSubscriptions =
        allSubscriptions.where((s) => s.isActive).toList();

    if (activeSubscriptions.isEmpty) {
      emit(const StatisticsState.empty(
          message: 'No active subscriptions to generate statistics.'));
      return;
    }

    try {
      final totalMonthlyEquivalent =
          activeSubscriptions.sumByDouble((s) => s.monthlyEquivalentPrice);
      final totalYearlyEquivalent = totalMonthlyEquivalent * 12;

      final Map<SubscriptionCategory, double> categoryTotals = {};
      for (var sub in activeSubscriptions) {
        categoryTotals.update(
          sub.category,
          (value) => value + sub.monthlyEquivalentPrice,
          ifAbsent: () => sub.monthlyEquivalentPrice,
        );
      }
      final List<CategorySpending> categorySpendingData = categoryTotals.entries
          .map((entry) => CategorySpending(
                category: entry.key,
                totalAmount: entry.value,
                percentage: totalMonthlyEquivalent > 0
                    ? (entry.value / totalMonthlyEquivalent)
                    : 0.0,
              ))
          .sortedBy<num>((cs) => cs.totalAmount)
          .reversed
          .toList();

      final Map<BillingCycle, List<SubscriptionEntity>> subsByBillingCycle = {};
      for (var sub in activeSubscriptions) {
        subsByBillingCycle.putIfAbsent(sub.billingCycle, () => []).add(sub);
      }
      final List<BillingTypeSpending> billingTypeSpendingData =
          subsByBillingCycle.entries
              .map((entry) {
                final cycleTotalMonthlyEquiv =
                    entry.value.sumByDouble((s) => s.monthlyEquivalentPrice);
                return BillingTypeSpending(
                  billingCycle: entry.key,
                  totalAmount: cycleTotalMonthlyEquiv,
                  subscriptionCount: entry.value.length,
                  percentageOfTotal: totalMonthlyEquivalent > 0
                      ? (cycleTotalMonthlyEquiv / totalMonthlyEquivalent)
                      : 0.0,
                );
              })
              .sortedBy<num>((bs) => bs.totalAmount)
              .reversed
              .toList();

      final List<SubscriptionEntity> topSpendingSubscriptions =
          List.from(activeSubscriptions)
            ..sort((a, b) =>
                b.monthlyEquivalentPrice.compareTo(a.monthlyEquivalentPrice));
      final topN = topSpendingSubscriptions.take(5).toList();

      final int trendYear = yearForTrend ??
          state.maybeWhen(
              loaded: (
                _,
                __,
                ___,
                ____,
                _____,
                ______,
                _______,
                trendYear,
                ________,
                _________,
              ) =>
                  trendYear,
              orElse: () => DateTime.now().year);

      final List<FlSpot> spots = [];
      double maxSpendingInYear = 0.0;
      for (int month = 1; month <= 12; month++) {
        double monthlyTotalForTrend = 0.0;
        for (final sub in activeSubscriptions) {
          if (sub.startDate != null &&
              (sub.startDate!.year < trendYear ||
                  (sub.startDate!.year == trendYear &&
                      sub.startDate!.month <= month))) {
            monthlyTotalForTrend += sub.monthlyEquivalentPrice;
          }
        }
        spots.add(FlSpot(month.toDouble(), monthlyTotalForTrend));
        if (monthlyTotalForTrend > maxSpendingInYear) {
          maxSpendingInYear = monthlyTotalForTrend;
        }
      }
      final spendingTrendData = MonthlySpendingTrendData(
        year: trendYear,
        spots: spots,
        maxSpendingInYear: maxSpendingInYear,
      );

      double? percentageOfSalary;
      double yearlySalary = 0;
      if (settings.salary != null && settings.salary! > 0) {
        if (settings.salaryCycle == SalaryCycle.yearly) {
          yearlySalary = settings.salary!;
        } else {
          yearlySalary =
              settings.salary! * (settings.hasThirteenthSalary ? 13 : 12);
        }
      }
      if (yearlySalary > 0) {
        percentageOfSalary = (totalYearlyEquivalent / yearlySalary);
      }

      emit(StatisticsState.loaded(
        activeSubscriptions: activeSubscriptions,
        categorySpendingData: categorySpendingData,
        billingTypeSpendingData: billingTypeSpendingData,
        topSpendingSubscriptions: topN,
        spendingTrendData: spendingTrendData,
        totalMonthlyEquivalentSpending: totalMonthlyEquivalent,
        totalYearlyEquivalentSpending: totalYearlyEquivalent,
        selectedYearForTrend: trendYear,
        yearlySalary: yearlySalary > 0 ? yearlySalary : null,
        percentageOfSalary: percentageOfSalary,
      ));
    } catch (e) {
      emit(StatisticsState.error(
          message: "Failed to generate statistics: ${e.toString()}"));
    }
  }

  void changeTrendYear(int newYear) {
    generateStatistics(yearForTrend: newYear);
  }
}

extension SumByDouble<T> on Iterable<T> {
  double sumByDouble(double Function(T element) f) {
    double sum = 0;
    for (var element in this) {
      sum += f(element);
    }
    return sum;
  }
}
