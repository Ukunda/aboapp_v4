// lib/features/statistics/presentation/widgets/overall_spending_summary_card.dart

import 'package:aboapp/core/utils/currency_formatter.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/widgets/animated_counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final settingsState = context.watch<SettingsCubit>().state;

    return Card(
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spending Overview', // TODO: Localize
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildMetric(
                  context,
                  settingsState: settingsState,
                  label: 'Monthly Total', // TODO: Localize
                  value: totalMonthlySpending,
                  style: theme.textTheme.headlineSmall!.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  labelStyle: theme.textTheme.bodySmall!,
                ),
                _buildMetric(
                  context,
                  settingsState: settingsState,
                  label: 'Yearly Total', // TODO: Localize
                  value: totalYearlySpending,
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
    required SettingsState settingsState,
    required String label,
    required double value,
    required TextStyle style,
    required TextStyle labelStyle,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedCounterWidget(
          value: value,
          formatter: (val) => CurrencyFormatter.format(val,
              currencyCode: settingsState.currencyCode,
              locale: settingsState.locale),
          style: style,
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: labelStyle.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
