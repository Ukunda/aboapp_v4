import 'package:aboapp/core/utils/currency_formatter.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:aboapp/core/localization/l10n_extensions.dart';

class SpendingTrendLineChartCard extends StatelessWidget {
  final MonthlySpendingTrendData spendingTrendData;

  const SpendingTrendLineChartCard({
    super.key,
    required this.spendingTrendData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingsState = context.watch<SettingsCubit>().state;

    if (spendingTrendData.spots.isEmpty) {
      return Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              context.l10n.stats_spending_trend_empty_message(spendingTrendData.year.toString()),
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.stats_spending_trend_title(spendingTrendData.year.toString()),
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 900),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  final int animatedSpotsCount =
                      (spendingTrendData.spots.length * value).ceil();
                  final animatedSpots =
                      spendingTrendData.spots.sublist(0, animatedSpotsCount);

                  return LineChart(
                    LineChartData(
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        horizontalInterval:
                            (spendingTrendData.maxSpendingInYear > 0
                                    ? spendingTrendData.maxSpendingInYear / 4
                                    : 50.0)
                                .clamp(10.0, double.infinity),
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: theme.dividerColor.withAlpha((255 * 0.5).round()),
                            strokeWidth: 0.5,
                          );
                        },
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false)),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            interval: 2,
                            getTitlesWidget: (value, meta) {
                              final int monthIndex = value.toInt();
                              if (monthIndex >= 1 && monthIndex <= 12) {
                                final monthName = DateFormat.MMM(
                                        settingsState.locale.toLanguageTag())
                                    .format(DateTime(2020, monthIndex));
                                return SideTitleWidget(
                                  axisSide: meta.axisSide,
                                  space: 8.0,
                                  child: Text(monthName,
                                      style: theme.textTheme.bodySmall),
                                );
                              }
                              return const Text('');
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 48,
                            getTitlesWidget: (value, meta) {
                              if (value == meta.max || value == meta.min) {
                                return const Text('');
                              }
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 4.0,
                                child: Text(
                                    CurrencyFormatter.format(
                                      value,
                                      currencyCode: settingsState.currencyCode,
                                      locale: settingsState.locale,
                                      decimalDigits: 0,
                                    ),
                                    style: theme.textTheme.bodySmall),
                              );
                            },
                          ),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      minX: 1,
                      maxX: 12,
                      minY: 0,
                      maxY: spendingTrendData.maxSpendingInYear > 0
                          ? spendingTrendData.maxSpendingInYear * 1.1
                          : 100,
                      lineBarsData: [
                        LineChartBarData(
                          spots: animatedSpots,
                          isCurved: true,
                          gradient: LinearGradient(
                            colors: [
                              theme.colorScheme.primary,
                              theme.colorScheme.secondary
                            ],
                          ),
                          barWidth: 3.5,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) =>
                                FlDotCirclePainter(
                              radius: 4,
                              color: Color.lerp(
                                      theme.colorScheme.primary,
                                      theme.colorScheme.secondary,
                                      percent / 100) ??
                                  theme.colorScheme.primary,
                              strokeWidth: 1.5,
                              strokeColor: theme.cardColor,
                            ),
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                theme.colorScheme.primary.withAlpha((255 * 0.2).round()),
                                theme.colorScheme.secondary.withAlpha((255 * 0.05).round()),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                      lineTouchData: LineTouchData(
                        handleBuiltInTouches: true,
                        touchTooltipData: LineTouchTooltipData(
                          getTooltipColor: (spot) =>
                              theme.colorScheme.surfaceContainerHighest,
                          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                            return touchedBarSpots.map((barSpot) {
                              final flSpot = barSpot;
                              final monthName = DateFormat.MMMM(
                                      settingsState.locale.toLanguageTag())
                                  .format(DateTime(spendingTrendData.year,
                                      flSpot.x.toInt()));
                              return LineTooltipItem(
                                '$monthName: ${CurrencyFormatter.format(flSpot.y, currencyCode: settingsState.currencyCode, locale: settingsState.locale, decimalDigits: 0)}\n',
                                TextStyle(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }).toList();
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
