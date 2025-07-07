// lib/features/subscriptions/presentation/widgets/monthly_spending_summary_card.dart

import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/widgets/animated_counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:aboapp/core/localization/l10n_extensions.dart';

class MonthlySpendingSummaryCard extends StatelessWidget {
  final List<SubscriptionEntity> activeSubscriptions;

  const MonthlySpendingSummaryCard({
    super.key,
    required this.activeSubscriptions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingsState = context.watch<SettingsCubit>().state;

    // Dynamically format currency based on user settings
    final currencyFormat = NumberFormat.currency(
      locale: settingsState.locale.toLanguageTag(),
      symbol: NumberFormat.simpleCurrency(
              locale: settingsState.locale.toLanguageTag())
          .currencySymbol,
      decimalDigits: 2,
    );

    final double totalMonthlySpending = activeSubscriptions.fold(
      0.0,
      (sum, sub) => sum + sub.monthlyEquivalentPrice,
    );

    final double yearlySpending = totalMonthlySpending * 12;

    return Card(
      // The card's appearance is now mainly controlled by the global ModernTheme/ClassicTheme
      // This makes it consistent across the app.
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: theme.cardTheme.elevation,
      shape: theme.cardTheme.shape,
      color: theme.cardTheme.color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for Title and Active Count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.home_monthly_spending_title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    context.l10n.home_active_count(activeSubscriptions.length),
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),

            // Main spending amount (the "Hero" element)
            AnimatedCounterWidget(
              value: totalMonthlySpending,
              formatter: (value) => currencyFormat.format(value),
              style: theme.textTheme.displayMedium!.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              duration: const Duration(milliseconds: 700),
            ),
            const SizedBox(height: 16.0),

            // Divider
            Divider(
              color: theme.dividerColor.withValues(alpha: 128),
              height: 1,
            ),
            const SizedBox(height: 16.0),

            // Secondary info (Yearly Total)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.l10n.stats_yearly_total_label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                AnimatedCounterWidget(
                  value: yearlySpending,
                  formatter: (val) => currencyFormat.format(val),
                  style: theme.textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                  duration: const Duration(milliseconds: 600),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
