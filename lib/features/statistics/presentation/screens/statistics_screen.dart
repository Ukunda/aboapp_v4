import 'package:aboapp/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:aboapp/features/statistics/presentation/widgets/billing_type_breakdown_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/category_spending_pie_chart_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/overall_spending_summary_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/spending_trend_line_chart_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/top_subscriptions_list_card.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart'; // Removed hide Error
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
    final subscriptionState = context.read<SubscriptionCubit>().state;
    subscriptionState.whenOrNull(
      loaded: (allSubs, _, __, ___, ____, _____) {
        if (mounted) {
          context.read<StatisticsCubit>().generateStatistics(allSubs, yearForTrend: _selectedYearForTrend);
        }
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
            listener: (context, subState) {
              subState.whenOrNull(
                loaded: (allSubs, _, __, ___, ____, _____) {
                  context.read<StatisticsCubit>().generateStatistics(allSubs, yearForTrend: _selectedYearForTrend);
                },
              );
            },
          ),
        ],
        child: BlocBuilder<StatisticsCubit, StatisticsState>(
          builder: (context, statsState) {
            return statsState.when(
              initial: () => const Center(child: CircularProgressIndicator.adaptive()),
              loading: () => const Center(child: CircularProgressIndicator.adaptive()),
              empty: (message) => EmptyStateWidget(
                icon: Icons.sentiment_dissatisfied_rounded,
                title: 'No Statistics Yet', 
                message: message,
              ),
              error: (message) => EmptyStateWidget(
                icon: Icons.error_outline_rounded,
                title: 'Error Loading Statistics', 
                message: message,
                onRetry: () {
                  final subCubitState = context.read<SubscriptionCubit>().state;
                  subCubitState.whenOrNull(
                     loaded: (allSubs, _, __, ___, ____, _____) => 
                        context.read<StatisticsCubit>().generateStatistics(allSubs, yearForTrend: _selectedYearForTrend),
                  );
                },
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
              ) {
                if (_selectedYearForTrend != selectedYearForTrend) {
                   _selectedYearForTrend = selectedYearForTrend;
                }
                return RefreshIndicator(
                  onRefresh: () async {
                     final subCubitState = context.read<SubscriptionCubit>().state;
                     // Removed await from void result
                     subCubitState.maybeWhen(
                       loaded: (allSubs, _, __, ___, ____, _____) {
                          context.read<StatisticsCubit>().generateStatistics(allSubs, yearForTrend: _selectedYearForTrend);
                       } ,
                       orElse: () {}, 
                     );
                  },
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        title: const Text('Statistics'), 
                        floating: true, 
                        snap: true,
                        actions: [
                          _buildYearSelector(context, theme, selectedYearForTrend),
                        ],
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(12.0), 
                        sliver: SliverList(
                          delegate: SliverChildListDelegate.fixed(const [ // Added const
                            OverallSpendingSummaryCard(
                              totalMonthlySpending: totalMonthlyEquivalentSpending, // These are already passed
                              totalYearlySpending: totalYearlyEquivalentSpending,
                            ),
                            SizedBox(height: 12),
                            CategorySpendingPieChartCard(
                              categorySpendingData: categorySpendingData, // Passed
                            ),
                            SizedBox(height: 12),
                            BillingTypeBreakdownCard(
                              billingTypeSpendingData: billingTypeSpendingData, // Passed
                            ),
                            SizedBox(height: 12),
                            SpendingTrendLineChartCard(
                              spendingTrendData: spendingTrendData, // Passed
                            ),
                            SizedBox(height: 12),
                            TopSubscriptionsListCard(
                              topSubscriptions: topSpendingSubscriptions, // Passed
                            ),
                            SizedBox(height: 24), 
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

  Widget _buildYearSelector(BuildContext context, ThemeData theme, int currentYear) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: currentYear,
          icon: Icon(Icons.calendar_today_rounded, size: 18, color: theme.colorScheme.onSurfaceVariant),
          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          dropdownColor: theme.colorScheme.surfaceContainerHighest, // Corrected deprecated member
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
                 loaded: (allSubs, _, __, ___, ____, _____) => 
                    context.read<StatisticsCubit>().changeTrendYear(allSubs, newYear),
              );
            }
          },
        ),
      ),
    );
  }
}