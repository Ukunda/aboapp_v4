// lib/features/statistics/presentation/cubit/statistics_state.dart
part of 'statistics_cubit.dart';

// ... (Data structures for charts remain the same)
class CategorySpending {
  final SubscriptionCategory category;
  final double totalAmount;
  final double percentage;
  CategorySpending(
      {required this.category,
      required this.totalAmount,
      required this.percentage});
}

class BillingTypeSpending {
  final BillingCycle billingCycle;
  final double totalAmount;
  final int subscriptionCount;
  final double percentageOfTotal;
  BillingTypeSpending(
      {required this.billingCycle,
      required this.totalAmount,
      required this.subscriptionCount,
      required this.percentageOfTotal});
}

class MonthlySpendingTrendData {
  final int year;
  final List<FlSpot> spots;
  final double maxSpendingInYear;
  MonthlySpendingTrendData(
      {required this.year,
      required this.spots,
      required this.maxSpendingInYear});
}

@freezed
class StatisticsState with _$StatisticsState {
  const factory StatisticsState.initial() = _Initial;
  const factory StatisticsState.loading() = _Loading;
  const factory StatisticsState.loaded({
    required List<SubscriptionEntity> activeSubscriptions,
    required List<CategorySpending> categorySpendingData,
    required List<BillingTypeSpending> billingTypeSpendingData,
    required List<SubscriptionEntity> topSpendingSubscriptions,
    required MonthlySpendingTrendData spendingTrendData,
    required double totalMonthlyEquivalentSpending,
    required double totalYearlyEquivalentSpending,
    required int selectedYearForTrend,
    // --- NEUE PARAMETER ---
    double? yearlySalary,
    double? percentageOfSalary,
  }) = _Loaded;
  const factory StatisticsState.error({required String message}) = _Error;
  const factory StatisticsState.empty({required String message}) = _Empty;
}
