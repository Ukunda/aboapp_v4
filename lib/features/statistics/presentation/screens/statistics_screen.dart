import 'package:aboapp/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:aboapp/features/statistics/presentation/widgets/billing_type_breakdown_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/category_spending_pie_chart_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/overall_spending_summary_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/salary_insight_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/spending_trend_line_chart_card.dart';
import 'package:aboapp/features/statistics/presentation/widgets/top_subscriptions_list_card.dart';
import 'package:aboapp/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:aboapp/core/localization/l10n_extensions.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StatisticsCubit>().generateStatistics();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: BlocBuilder<StatisticsCubit, StatisticsState>(
        builder: (context, statsState) {
          return statsState.when(
            initial: () =>
                const Center(child: CircularProgressIndicator.adaptive()),
            loading: () =>
                const Center(child: CircularProgressIndicator.adaptive()),
            empty: (message) => EmptyStateWidget(
              icon: Icons.insights_rounded,
              title: context.l10n.stats_empty_title,
              message: message,
            ),
            error: (message) => EmptyStateWidget(
              icon: Icons.error_outline_rounded,
              title: context.l10n.stats_error_title,
              message: message,
              onRetry: () =>
                  context.read<StatisticsCubit>().generateStatistics(),
              retryText: context.l10n.retry,
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
              final List<Widget> statWidgets = [
                if (yearlySalary != null && percentageOfSalary != null)
                  SalaryInsightCard(
                    percentageOfSalary: percentageOfSalary,
                    yearlySalary: yearlySalary,
                  ),
                OverallSpendingSummaryCard(
                  totalMonthlySpending: totalMonthlyEquivalentSpending,
                  totalYearlySpending: totalYearlyEquivalentSpending,
                ),
                CategorySpendingPieChartCard(
                  categorySpendingData: categorySpendingData,
                ),
                SpendingTrendLineChartCard(
                  spendingTrendData: spendingTrendData,
                ),
                BillingTypeBreakdownCard(
                  billingTypeSpendingData: billingTypeSpendingData,
                ),
                TopSubscriptionsListCard(
                  topSubscriptions: topSpendingSubscriptions,
                ),
              ];

              return RefreshIndicator(
                onRefresh: () async =>
                    context.read<StatisticsCubit>().generateStatistics(),
                child: AnimationLimiter(
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        title: Text(context.l10n.stats_title),
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
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                child: SlideAnimation(
                                  verticalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16.0),
                                      child: statWidgets[index],
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: statWidgets.length,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildYearSelector(
      BuildContext context, ThemeData theme, int currentYear) {
    return PopupMenuButton<int>(
      onSelected: (newYear) {
        if (newYear != currentYear) {
          context.read<StatisticsCubit>().changeTrendYear(newYear);
        }
      },
      itemBuilder: (context) {
        return List.generate(5, (index) => DateTime.now().year - index)
            .map((year) => PopupMenuItem<int>(
                  value: year,
                  child: Text(year.toString()),
                ))
            .toList();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              currentYear.toString(),
              style: theme.textTheme.titleMedium
                  ?.copyWith(color: theme.colorScheme.primary),
            ),
            const SizedBox(width: 4),
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}