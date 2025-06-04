part of 'statistics_cubit.dart';

// Data structures for charts (can be classes or records)
class CategorySpending {
  final SubscriptionCategory category;
  final double totalAmount;
  final double percentage; // Percentage of total spending

  CategorySpending({
    required this.category,
    required this.totalAmount,
    required this.percentage,
  });
}

class BillingTypeSpending {
  final BillingCycle billingCycle;
  final double totalAmount; // Monthly equivalent
  final int subscriptionCount;
  final double percentageOfTotal; // Percentage of total monthly equivalent spending

  BillingTypeSpending({
    required this.billingCycle,
    required this.totalAmount,
    required this.subscriptionCount,
    required this.percentageOfTotal,
  });
}

class MonthlySpendingTrendData {
  final int year;
  final List<FlSpot> spots; // x: month (1-12), y: total spending
  final double maxSpendingInYear;

  MonthlySpendingTrendData({
    required this.year,
    required this.spots,
    required this.maxSpendingInYear,
  });
}

@freezed
class StatisticsState with _$StatisticsState {
  const factory StatisticsState.initial() = _Initial;
  const factory StatisticsState.loading() = _Loading;
  const factory StatisticsState.loaded({
    required List<SubscriptionEntity> activeSubscriptions, // Source data
    required List<CategorySpending> categorySpendingData,
    required List<BillingTypeSpending> billingTypeSpendingData,
    required List<SubscriptionEntity> topSpendingSubscriptions, // Top N subscriptions by monthly equiv.
    required MonthlySpendingTrendData spendingTrendData,
    required double totalMonthlyEquivalentSpending,
    required double totalYearlyEquivalentSpending,
    required int selectedYearForTrend, // The year currently displayed in the trend chart
  }) = _Loaded;
  const factory StatisticsState.error({required String message}) = _Error;
  const factory StatisticsState.empty({required String message}) = _Empty;
}