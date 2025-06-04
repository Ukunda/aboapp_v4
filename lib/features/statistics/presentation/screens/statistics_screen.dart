import 'package:aboapp/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:aboapp/features/statistics/presentation/widgets/billing_type_breakdown_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/category_spending_pie_chart_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/overall_spending_summary_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/spending_trend_line_chart_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/top_subscriptions_list_card.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart' hide Error; // Hide SubscriptionCubit's Error state
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
    // Listen to SubscriptionCubit to get the latest subscriptions
    // and trigger statistics generation.
    final subscriptionState = context.read<SubscriptionCubit>().state;
    subscriptionState.whenOrNull(
      loaded: (allSubs, _, __, ___, ____, _____) {
        if (mounted) {
          context.read<StatisticsCubit>().generateStatistics(allSubs, yearForTrend: _selectedYearForTrend);
        }
      },
      // Handle other states of SubscriptionCubit if necessary, e.g., if it's still loading
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final localizations = AppLocalizations.of(context);

    return Scaffold(
      // AppBar is part of MainContainerScreen for shell routes.
      // If this screen needs a specific AppBar when pushed independently, add it here.
      // appBar: AppBar(title: Text('Statistics')), // localizations.translate('statistics_title'))),
      body: MultiBlocListener(
        listeners: [
          // Listen to SubscriptionCubit for changes in subscriptions
          BlocListener<SubscriptionCubit, SubscriptionState>(
            listener: (context, subState) {
              subState.whenOrNull(
                loaded: (allSubs, _, __, ___, ____, _____) {
                  // Regenerate statistics when subscriptions change
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
                title: 'No Statistics Yet', // localizations.translate('no_stats_title'),
                message: message,
              ),
              error: (message) => EmptyStateWidget(
                icon: Icons.error_outline_rounded,
                title: 'Error Loading Statistics', // localizations.translate('stats_error_title'),
                message: message,
                onRetry: () {
                  final subCubitState = context.read<SubscriptionCubit>().state;
                  subCubitState.whenOrNull(
                     loaded: (allSubs, _, __, ___, ____, _____) => 
                        context.read<StatisticsCubit>().generateStatistics(allSubs, yearForTrend: _selectedYearForTrend),
                  );
                },
                retryText: 'Retry', // localizations.translate('retry'),
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
                // Update local state if cubit's selected year changes (e.g. via another trigger)
                if (_selectedYearForTrend != selectedYearForTrend) {
                   _selectedYearForTrend = selectedYearForTrend;
                }
                return RefreshIndicator(
                  onRefresh: () async {
                     final subCubitState = context.read<SubscriptionCubit>().state;
                     await subCubitState.maybeWhen(
                       loaded: (allSubs, _, __, ___, ____, _____) async => 
                          await context.read<StatisticsCubit>().generateStatistics(allSubs, yearForTrend: _selectedYearForTrend),
                       orElse: () async {}, // Do nothing if subs not loaded
                     );
                  },
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        // title: Text('Statistics Overview'), // localizations.translate('statistics_title')),
                        title: Text('Statistics'), // For individual screen AppBar
                        floating: true, // AppBar appears when scrolling up
                        snap: true,
                        // Pinned can be true if you want it always visible at the top
                        // pinned: true, 
                        actions: [
                          _buildYearSelector(context, theme, selectedYearForTrend),
                        ],
                        // backgroundColor: theme.colorScheme.surface.withOpacity(0.85), // Slight transparency
                        // elevation: 1.0,
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(12.0), // Reduced padding
                        sliver: SliverList(
                          delegate: SliverChildListDelegate.fixed([
                            OverallSpendingSummaryCard(
                              totalMonthlySpending: totalMonthlyEquivalentSpending,
                              totalYearlySpending: totalYearlyEquivalentSpending,
                            ),
                            const SizedBox(height: 12),
                            CategorySpendingPieChartCard(
                              categorySpendingData: categorySpendingData,
                            ),
                            const SizedBox(height: 12),
                            BillingTypeBreakdownCard(
                              billingTypeSpendingData: billingTypeSpendingData,
                            ),
                            const SizedBox(height: 12),
                            SpendingTrendLineChartCard(
                              spendingTrendData: spendingTrendData,
                            ),
                            const SizedBox(height: 12),
                            TopSubscriptionsListCard(
                              topSubscriptions: topSpendingSubscriptions,
                            ),
                            const SizedBox(height: 24), // Bottom padding
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
    // final localizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: currentYear,
          icon: Icon(Icons.calendar_today_rounded, size: 18, color: theme.colorScheme.onSurfaceVariant),
          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          dropdownColor: theme.colorScheme.surfaceVariant,
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