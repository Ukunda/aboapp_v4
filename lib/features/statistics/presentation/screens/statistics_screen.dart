// lib/features/statistics/presentation/screens/statistics_screen.dart
import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:aboapp/features/statistics/presentation/widgets/billing_type_breakdown_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/category_spending_pie_chart_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/overall_spending_summary_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/salary_insight_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/spending_trend_line_chart_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/top_subscriptions_list_card.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';
import 'package:aboapp/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _selectedYearForTrend = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _generateStats();
    });
  }

  void _generateStats() {
    if (!mounted) return;
    final subscriptionState = context.read<SubscriptionCubit>().state;
    final settingsState = context.read<SettingsCubit>().state;

    final settingsEntity = SettingsEntity(
      themeMode: settingsState.themeMode,
      locale: settingsState.locale,
      currencyCode: settingsState.currencyCode,
      salary: settingsState.salary,
      salaryCycle: settingsState.salaryCycle,
      hasThirteenthSalary: settingsState.hasThirteenthSalary,
    );

    subscriptionState.whenOrNull(
      loaded: (allSubs, _, __, ___, ____, _____) {
        context.read<StatisticsCubit>().generateStatistics(
            allSubs, settingsEntity,
            yearForTrend: _selectedYearForTrend);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<SubscriptionCubit, SubscriptionState>(
            listener: (context, state) => _generateStats(),
          ),
          BlocListener<SettingsCubit, SettingsState>(
            listener: (context, state) => _generateStats(),
          ),
        ],
        child: BlocBuilder<StatisticsCubit, StatisticsState>(
          builder: (context, statsState) {
            return statsState.when(
              initial: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              loading: () =>
                  const Center(child: CircularProgressIndicator.adaptive()),
              empty: (message) => EmptyStateWidget(
                icon: Icons.insights_rounded,
                title: 'No Statistics Yet',
                message: message,
              ),
              error: (message) => EmptyStateWidget(
                icon: Icons.error_outline_rounded,
                title: 'Error Loading Statistics',
                message: message,
                onRetry: _generateStats,
                retryText: 'Retry',
              ),
              loaded: (
                activeSubscriptions,
                categorySpendingData,
                billingTypeSpendingData,
                topSpendingSubscriptions,
                spendingTrendData,
                totalMonthlyEquivalentSpending,
                totalYearlyEquivalentSpending,
                selectedYearForTrend,
                yearlySalary,
                percentageOfSalary,
              ) {
                if (_selectedYearForTrend != selectedYearForTrend) {
                  _selectedYearForTrend = selectedYearForTrend;
                }
                return RefreshIndicator(
                  onRefresh: () async => _generateStats(),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        title: const Text('Statistics'),
                        floating: true,
                        snap: true,
                        actions: [
                          _buildYearSelector(
                              context, theme, selectedYearForTrend),
                        ],
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate.fixed([
                            if (yearlySalary != null &&
                                percentageOfSalary != null) ...[
                              SalaryInsightCard(
                                percentageOfSalary: percentageOfSalary,
                                yearlySalary: yearlySalary,
                              ),
                              const SizedBox(height: 16),
                            ],
                            OverallSpendingSummaryCard(
                              totalMonthlySpending:
                                  totalMonthlyEquivalentSpending,
                              totalYearlySpending:
                                  totalYearlyEquivalentSpending,
                            ),
                            const SizedBox(height: 16),
                            CategorySpendingPieChartCard(
                              categorySpendingData: categorySpendingData,
                            ),
                            const SizedBox(height: 16),
                            SpendingTrendLineChartCard(
                              spendingTrendData: spendingTrendData,
                            ),
                            const SizedBox(height: 16),
                            BillingTypeBreakdownCard(
                              billingTypeSpendingData: billingTypeSpendingData,
                            ),
                            const SizedBox(height: 16),
                            TopSubscriptionsListCard(
                              topSubscriptions: topSpendingSubscriptions,
                            ),
                          ]),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildYearSelector(
      BuildContext context, ThemeData theme, int currentYear) {
    final settingsState = context.read<SettingsCubit>().state;
    final settingsEntity = SettingsEntity(
        themeMode: settingsState.themeMode,
        locale: settingsState.locale,
        currencyCode: settingsState.currencyCode,
        salary: settingsState.salary,
        salaryCycle: settingsState.salaryCycle,
        hasThirteenthSalary: settingsState.hasThirteenthSalary);

    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: currentYear,
          icon: Icon(Icons.calendar_today_rounded,
              size: 18, color: theme.colorScheme.onSurfaceVariant),
          style: theme.textTheme.bodySmall
              ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          dropdownColor: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.0),
          items: List.generate(5, (index) => DateTime.now().year - index)
              .map((year) => DropdownMenuItem<int>(
                    value: year,
                    child: Text(year.toString()),
                  ))
              .toList(),
          onChanged: (newYear) {
            if (newYear != null && newYear != currentYear) {
              setState(() {
                _selectedYearForTrend = newYear;
              });
              final subCubitState = context.read<SubscriptionCubit>().state;
              subCubitState.whenOrNull(
                loaded: (allSubs, _, __, ___, ____, _____) => context
                    .read<StatisticsCubit>()
                    .changeTrendYear(allSubs, settingsEntity, newYear),
              );
            }
          },
        ),
      ),
    );
  }
}
