import 'package:aboapp/features/statistics/presentation/cubit/statistics_cubit.dart'; 
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SpendingTrendLineChartCard extends StatelessWidget {
  final MonthlySpendingTrendData spendingTrendData;

  const SpendingTrendLineChartCard({
    super.key,
    required this.spendingTrendData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // TODO: Use locale/currency from SettingsCubit
    final currencyFormat = NumberFormat.currency(locale: 'de_DE', symbol: '€', decimalDigits: 0);

    if (spendingTrendData.spots.isEmpty) {
       return Card(
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'No spending trend data available for ${spendingTrendData.year}.', // TODO: Localize
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 20, 20), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spending Trend - ${spendingTrendData.year}', // TODO: Localize
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: (spendingTrendData.maxSpendingInYear > 0 ? spendingTrendData.maxSpendingInYear / 4 : 50.0).clamp(10.0, double.infinity), // Ensure double
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: theme.dividerColor.withOpacity(0.5), // Kept withOpacity for dynamic non-const color
                        strokeWidth: 0.5,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        interval: 2, 
                        getTitlesWidget: (value, meta) {
                          // TODO: Localize month abbreviations
                          const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                          final int monthIndex = value.toInt() - 1;
                          if (monthIndex >= 0 && monthIndex < months.length) {
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              space: 8.0,
                              child: Text(months[monthIndex], style: theme.textTheme.bodySmall),
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
                          if (value == meta.max || value == meta.min) return const Text(''); 
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            space: 4.0,
                            child: Text(currencyFormat.format(value), style: theme.textTheme.bodySmall),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  minX: 1,
                  maxX: 12,
                  minY: 0,
                  maxY: spendingTrendData.maxSpendingInYear > 0 ? spendingTrendData.maxSpendingInYear * 1.1 : 100, 
                  lineBarsData: [
                    LineChartBarData(
                      spots: spendingTrendData.spots,
                      isCurved: true,
                      gradient: LinearGradient(
                        colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
                      ),
                      barWidth: 3.5,
                      isStrokeCapRound: true,
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                                radius: 4,
                                color: Color.lerp(theme.colorScheme.primary, theme.colorScheme.secondary, percent / 100) ?? theme.colorScheme.primary,
                                strokeWidth: 1.5,
                                strokeColor: theme.cardColor, 
                        ),
                      ),
                      belowBarData: BarAreaData(
                        show: true,
                        gradient: LinearGradient(
                          colors: [
                            theme.colorScheme.primary.withOpacity(0.2),    // Kept withOpacity
                            theme.colorScheme.secondary.withOpacity(0.05), // Kept withOpacity
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
                      getTooltipColor: (spot) => theme.colorScheme.surfaceContainerHighest, // Corrected: was tooltipBgColor
                      getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                        return touchedBarSpots.map((barSpot) {
                          final flSpot = barSpot;
                          // TODO: Localize month name and currency
                          final monthName = DateFormat.MMMM().format(DateTime(spendingTrendData.year, flSpot.x.toInt()));
                          return LineTooltipItem(
                            '$monthName: ${currencyFormat.format(flSpot.y)}\n',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}