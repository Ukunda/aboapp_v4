// lib/features/statistics/presentation/widgets/salary_insight_card.dart
import 'package:aboapp/core/utils/currency_formatter.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:aboapp/core/localization/l10n_extensions.dart';

class SalaryInsightCard extends StatelessWidget {
  final double percentageOfSalary;
  final double yearlySalary;

  const SalaryInsightCard({
    super.key,
    required this.percentageOfSalary,
    required this.yearlySalary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingsState = context.watch<SettingsCubit>().state;
    final formattedPercentage = (percentageOfSalary * 100).toStringAsFixed(2);
    final formattedSalary = CurrencyFormatter.format(
      yearlySalary,
      currencyCode: settingsState.currencyCode,
      locale: settingsState.locale,
      decimalDigits: 0,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircularPercentIndicator(
              radius: 40.0,
              lineWidth: 9.0,
              percent: percentageOfSalary.clamp(0.0, 1.0),
              center: Text(
                "$formattedPercentage%",
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              progressColor: theme.colorScheme.primary,
              backgroundColor: theme.dividerColor.withAlpha(128),
              circularStrokeCap: CircularStrokeCap.round,
              animation: true,
              animationDuration: 800,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.l10n.stats_salary_contribution_title,
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    context.l10n.stats_salary_contribution_message('$formattedPercentage%', formattedSalary),
                    style: theme.textTheme.bodyMedium
                        ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
