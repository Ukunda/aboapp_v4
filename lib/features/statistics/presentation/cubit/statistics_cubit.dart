import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:fl_chart/fl_chart.dart'; // For FlSpot
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:collection/collection.dart'; // For sumBy

part 'statistics_state.dart';
part 'statistics_cubit.freezed.dart';

@injectable
class StatisticsCubit extends Cubit<StatisticsState> {
  // No direct repository needed if it processes data from subscriptions.
  // It could listen to SubscriptionCubit or receive data.
  // For simplicity, let's assume it takes a list of subscriptions to process.

  StatisticsCubit() : super(const StatisticsState.initial());

  void generateStatistics(List<SubscriptionEntity> allSubscriptions, {int? yearForTrend}) {
    emit(const StatisticsState.loading());

    final activeSubscriptions = allSubscriptions.where((s) => s.isActive).toList();

    if (activeSubscriptions.isEmpty) {
      emit(const StatisticsState.empty(message: 'No active subscriptions to generate statistics.')); // TODO: Localize
      return;
    }

    try {
      // 1. Calculate Total Monthly and Yearly Equivalent Spending
      final totalMonthlyEquivalent = activeSubscriptions.sumByDouble((s) => s.monthlyEquivalentPrice);
      final totalYearlyEquivalent = totalMonthlyEquivalent * 12;

      // 2. Category Spending
      final Map<SubscriptionCategory, double> categoryTotals = {};
      for (var sub in activeSubscriptions) {
        categoryTotals.update(
          sub.category,
          (value) => value + sub.monthlyEquivalentPrice,
          ifAbsent: () => sub.monthlyEquivalentPrice,
        );
      }
      final List<CategorySpending> categorySpendingData = categoryTotals.entries.map((entry) {
        return CategorySpending(
          category: entry.key,
          totalAmount: entry.value,
          percentage: totalMonthlyEquivalent > 0 ? (entry.value / totalMonthlyEquivalent) : 0.0,
        );
      }).sortedBy<num>((cs) => cs.totalAmount).reversed.toList(); // Sort descending

      // 3. Billing Type Spending
      final Map<BillingCycle, List<SubscriptionEntity>> subsByBillingCycle = {};
      for (var sub in activeSubscriptions) {
        subsByBillingCycle.putIfAbsent(sub.billingCycle, () => []).add(sub);
      }
      final List<BillingTypeSpending> billingTypeSpendingData = subsByBillingCycle.entries.map((entry) {
        final cycleTotalMonthlyEquiv = entry.value.sumByDouble((s) => s.monthlyEquivalentPrice);
        return BillingTypeSpending(
          billingCycle: entry.key,
          totalAmount: cycleTotalMonthlyEquiv,
          subscriptionCount: entry.value.length,
          percentageOfTotal: totalMonthlyEquivalent > 0 ? (cycleTotalMonthlyEquiv / totalMonthlyEquivalent) : 0.0,
        );
      }).sortedBy<num>((bs) => bs.totalAmount).reversed.toList(); // Sort descending


      // 4. Top Spending Subscriptions (e.g., Top 5)
      final List<SubscriptionEntity> topSpendingSubscriptions = List.from(activeSubscriptions)
        ..sort((a, b) => b.monthlyEquivalentPrice.compareTo(a.monthlyEquivalentPrice));
      final topN = topSpendingSubscriptions.take(5).toList();

      // 5. Spending Trend Data
      final int trendYear = yearForTrend ?? DateTime.now().year;
      final List<FlSpot> spots = [];
      double maxSpendingInYear = 0.0;
      for (int month = 1; month <= 12; month++) {
        double monthlyTotalForTrend = 0.0;
        for (final sub in activeSubscriptions) {
          if (sub.startDate != null &&
              (sub.startDate!.year < trendYear || (sub.startDate!.year == trendYear && sub.startDate!.month <= month))) {
            // This logic assumes continuous subscription. More complex if pauses/ends.
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

      emit(StatisticsState.loaded(
        activeSubscriptions: activeSubscriptions,
        categorySpendingData: categorySpendingData,
        billingTypeSpendingData: billingTypeSpendingData,
        topSpendingSubscriptions: topN,
        spendingTrendData: spendingTrendData,
        totalMonthlyEquivalentSpending: totalMonthlyEquivalent,
        totalYearlyEquivalentSpending: totalYearlyEquivalent,
        selectedYearForTrend: trendYear,
      ));
    } catch (e) {
      emit(StatisticsState.error(message: "Failed to generate statistics: ${e.toString()}"));
    }
  }
  
  // Call this method if the year for the trend chart changes
  void changeTrendYear(List<SubscriptionEntity> allSubscriptions, int newYear) {
    generateStatistics(allSubscriptions, yearForTrend: newYear);
  }
}

// Helper extension for sumByDouble
extension SumByDouble<T> on Iterable<T> {
  double sumByDouble(double Function(T element) f) {
    double sum = 0;
    for (var element in this) {
      sum += f(element);
    }
    return sum;
  }
}