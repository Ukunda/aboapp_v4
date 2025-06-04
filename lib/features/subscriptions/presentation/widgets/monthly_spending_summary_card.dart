import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For number formatting

// Assuming you'll have a shared animated counter widget.
// If not, this would be a simpler Text widget.
import 'package:aboapp/widgets/animated_counter_widget.dart'; // We'll create this shared widget next

class MonthlySpendingSummaryCard extends StatelessWidget {
  final List<SubscriptionEntity> activeSubscriptions;

  const MonthlySpendingSummaryCard({
    super.key,
    required this.activeSubscriptions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // TODO: Replace 'de_DE' and '€' with locale/currency from SettingsCubit/Provider
    final currencyFormat = NumberFormat.currency(locale: 'de_DE', symbol: '€', decimalDigits: 2);

    final double totalMonthlySpending = activeSubscriptions.fold(
      0.0,
      (sum, sub) => sum + sub.monthlyEquivalentPrice,
    );

    final double yearlySpending = totalMonthlySpending * 12;
    final double dailyAverage = activeSubscriptions.isNotEmpty
        ? totalMonthlySpending / 30.4375 // Average days in a month
        : 0.0;

    return Card(
      elevation: 2.0, // Subtle elevation
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primaryContainer.withOpacity(0.6),
              theme.colorScheme.primaryContainer.withOpacity(0.9),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Monthly Spending', // TODO: Localize
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${activeSubscriptions.length} Active', // TODO: Localize
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            AnimatedCounterWidget(
              value: totalMonthlySpending,
              formatter: (value) => currencyFormat.format(value),
              style: theme.textTheme.displaySmall!.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
              duration: const Duration(milliseconds: 700),
            ),
            Text(
              'per month', // TODO: Localize
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onPrimaryContainer.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStatItem(
                  context,
                  theme,
                  currencyFormat,
                  label: 'Yearly Total', // TODO: Localize
                  value: yearlySpending,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
                _buildStatItem(
                  context,
                  theme,
                  currencyFormat,
                  label: 'Daily Average', // TODO: Localize
                  value: dailyAverage,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    ThemeData theme,
    NumberFormat currencyFormat, {
    required String label,
    required double value,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: color.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 2.0),
        AnimatedCounterWidget(
          value: value,
          formatter: (val) => currencyFormat.format(val),
          style: theme.textTheme.titleSmall!.copyWith(
            fontWeight: FontWeight.w600,
            color: color,
          ),
          duration: const Duration(milliseconds: 600),
        ),
      ],
    );
  }
}