import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/widgets/animated_counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:aboapp/core/localization/l10n_extensions.dart';

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
    final currencyFormat = NumberFormat.currency(
      locale: settingsState.locale.toLanguageTag(),
      symbol: NumberFormat.simpleCurrency(
              locale: settingsState.locale.toLanguageTag())
          .currencySymbol,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.l10n.translate('stats_overall_spending_title'),
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                _buildMetric(
                  context: context,
                  currencyFormat: currencyFormat,
                  label: context.l10n.translate('billing_cycle_monthly'),
                  value: totalMonthlySpending,
                  style: theme.textTheme.headlineMedium!.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  labelStyle: theme.textTheme.bodySmall!,
                ),
                const SizedBox(width: 24),
                _buildMetric(
                  context: context,
                  currencyFormat: currencyFormat,
                  label: context.l10n.translate('billing_cycle_yearly'),
                  value: totalYearlySpending,
                  style: theme.textTheme.headlineMedium!.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
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

  Widget _buildMetric({
    required BuildContext context,
    required NumberFormat currencyFormat,
    required String label,
    required double value,
    required TextStyle style,
    required TextStyle labelStyle,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: AnimatedCounterWidget(
              value: value,
              formatter: (val) => currencyFormat.format(val),
              style: style,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: labelStyle.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
