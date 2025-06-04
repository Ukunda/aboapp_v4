import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/widgets/subscription_card_widget.dart'; // For CategoryDisplayHelpers
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TopSubscriptionsListCard extends StatelessWidget {
  final List<SubscriptionEntity> topSubscriptions;

  const TopSubscriptionsListCard({
    super.key,
    required this.topSubscriptions,
  });
  
  // _getBillingCycleShortLabel removed as it was unused in this file

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // TODO: Use locale/currency from SettingsCubit
    final currencyFormat = NumberFormat.currency(locale: 'de_DE', symbol: '€', decimalDigits: 2);

    if (topSubscriptions.isEmpty) {
      return Card(
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'No subscriptions to display in top list.', // TODO: Localize
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
              padding: const EdgeInsets.only(left: 16.0, top: 8.0, right: 16.0, bottom: 4.0),
              child: Text(
                'Top Spending Subscriptions', // TODO: Localize
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: Text(
                '(Based on Monthly Equivalent Cost)', // TODO: Localize
                 style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
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
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                  leading: CircleAvatar(
                    radius: 16,
                    backgroundColor: theme.colorScheme.primaryContainer,
                    child: Text(
                      '$rank',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  title: Text(
                    sub.name,
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    sub.category.displayName, // Use extension from subscription_card_widget
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        currencyFormat.format(sub.monthlyEquivalentPrice),
                        style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'per month', // TODO: Localize (as it's monthly equivalent)
                         style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(height: 1, indent: 16, endIndent: 16),
            ),
          ],
        ),
      ),
    );
  }
}