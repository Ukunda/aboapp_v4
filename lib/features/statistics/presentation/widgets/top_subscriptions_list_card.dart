// lib/features/statistics/presentation/widgets/top_subscriptions_list_card.dart

import 'package:aboapp/core/utils/currency_formatter.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/widgets/subscription_card_widget.dart'; // For CategoryDisplayHelpers
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aboapp/core/localization/l10n_extensions.dart';

class TopSubscriptionsListCard extends StatelessWidget {
  final List<SubscriptionEntity> topSubscriptions;

  const TopSubscriptionsListCard({
    super.key,
    required this.topSubscriptions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingsState = context.watch<SettingsCubit>().state;

    if (topSubscriptions.isEmpty) {
      return Card(
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              context.l10n.stats_top_subscriptions_empty_message,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0, top: 8.0, right: 16.0, bottom: 4.0),
              child: Text(
                context.l10n.stats_top_subscriptions_title,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: Text(
                context.l10n.stats_top_subscriptions_subtitle,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: topSubscriptions.length,
              itemBuilder: (context, index) {
                final sub = topSubscriptions[index];
                final rank = index + 1;
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(
                      '$rank',
                      style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  title: Text(
                    sub.name,
                    style: theme.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    sub.category.displayName(context),
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        CurrencyFormatter.format(sub.monthlyEquivalentPrice,
                            currencyCode: settingsState.currencyCode,
                            locale: settingsState.locale),
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        context.l10n.stats_per_month_label,
                        style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) =>
                  const Divider(height: 1, indent: 16, endIndent: 16),
            ),
          ],
        ),
      ),
    );
  }
}
