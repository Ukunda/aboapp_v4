// lib/features/statistics/presentation/widgets/billing_type_breakdown_card.dart

import 'package:aboapp/core/utils/currency_formatter.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/features/statistics/presentation/cubit/statistics_cubit.dart'; // For BillingTypeSpending
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart'; // For BillingCycle
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aboapp/core/localization/l10n_extensions.dart';

class BillingTypeBreakdownCard extends StatelessWidget {
  final List<BillingTypeSpending> billingTypeSpendingData;

  const BillingTypeBreakdownCard({
    super.key,
    required this.billingTypeSpendingData,
  });

  String _getBillingCycleLabel(BuildContext context, BillingCycle cycle) {
    switch (cycle) {
      case BillingCycle.weekly:
        return context.l10n.billing_cycle_weekly;
      case BillingCycle.monthly:
        return context.l10n.billing_cycle_monthly;
      case BillingCycle.quarterly:
        return context.l10n.billing_cycle_quarterly;
      case BillingCycle.biAnnual:
        return context.l10n.billing_cycle_biAnnual;
      case BillingCycle.yearly:
        return context.l10n.billing_cycle_yearly;
      case BillingCycle.custom:
        return context.l10n.billing_cycle_custom;
    }
  }

  Color _getBillingCycleColor(BuildContext context, BillingCycle cycle) {
    // Use a consistent color mapping, possibly from AppColors or theme extensions
    final colors = [
      Colors.blue.shade300,
      Colors.purple.shade300,
      Colors.teal.shade300,
      Colors.orange.shade300,
      Colors.red.shade300,
      Colors.grey.shade400
    ];
    return colors[cycle.index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingsState = context.watch<SettingsCubit>().state;

    if (billingTypeSpendingData.isEmpty) {
      return Card(
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              context.l10n.stats_billing_type_empty_message,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ),
      );
    }

    final totalMonthlyEquivalentSpending = billingTypeSpendingData.fold<double>(
        0, (sum, item) => sum + item.totalAmount);

    return Card(
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.stats_billing_type_title,
              style: theme.textTheme.titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              context.l10n.stats_billing_type_subtitle,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            if (totalMonthlyEquivalentSpending > 0)
              LayoutBuilder(builder: (context, constraints) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Row(
                    children: billingTypeSpendingData.map((item) {
                      final percentage = item.percentageOfTotal;
                      return Expanded(
                        flex: (percentage * 100).toInt().clamp(1, 100),
                        child: Container(
                          height: 24,
                          color:
                              _getBillingCycleColor(context, item.billingCycle),
                        ),
                      );
                    }).toList(),
                  ),
                );
              }),
            const SizedBox(height: 16),
            ...billingTypeSpendingData.map((item) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color:
                            _getBillingCycleColor(context, item.billingCycle),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      flex: 3,
                      child: Text(
                        _getBillingCycleLabel(context, item.billingCycle),
                        style: theme.textTheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '${item.subscriptionCount} ${item.subscriptionCount == 1
                                ? context.l10n.stats_subscription_abbrev_single
                                : context.l10n.stats_subscription_abbrev_multiple}',
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      flex: 3,
                      child: Text(
                        CurrencyFormatter.format(
                          item.totalAmount,
                          currencyCode: settingsState.currencyCode,
                          locale: settingsState.locale,
                          decimalDigits: 0,
                        ),
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.end,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      flex: 2,
                      child: Text(
                        '(${(item.percentageOfTotal * 100).toStringAsFixed(0)}%)',
                        style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
