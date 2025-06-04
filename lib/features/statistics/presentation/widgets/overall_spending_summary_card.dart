import 'package:aboapp/widgets/animated_counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OverallSpendingSummaryCard extends StatelessWidget {
  final double totalMonthlySpending;
  final double totalYearlySpending;

  const OverallSpendingSummaryCard({
    super.key,
    required this.totalMonthlySpending,
    required this.totalYearlySpending,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // TODO: Use locale/currency from SettingsCubit
    final currencyFormat = NumberFormat.currency(locale: 'de_DE', symbol: '€', decimalDigits: 2);

    return Card(
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spending Overview', // TODO: Localize
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetric(
                  context,
                  label: 'Monthly Total', // TODO: Localize
                  value: totalMonthlySpending,
                  currencyFormat: currencyFormat,
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  labelStyle: theme.textTheme.bodySmall!,
                ),
                _buildMetric(
                  context,
                  label: 'Yearly Total', // TODO: Localize
                  value: totalYearlySpending,
                  currencyFormat: currencyFormat,
                  style: theme.textTheme.titleLarge!.copyWith(
                    color: theme.colorScheme.secondary,
                     fontWeight: FontWeight.w600,
                  ),
                   labelStyle: theme.textTheme.bodySmall!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(
    BuildContext context, {
    required String label,
    required double value,
    required NumberFormat currencyFormat,
    required TextStyle style,
    required TextStyle labelStyle,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedCounterWidget(
          value: value,
          formatter: (val) => currencyFormat.format(val),
          style: style,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: labelStyle.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}