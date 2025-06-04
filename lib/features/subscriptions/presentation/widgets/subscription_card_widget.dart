import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SubscriptionCardWidget extends StatelessWidget {
  final SubscriptionEntity subscription;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const SubscriptionCardWidget({
    super.key,
    required this.subscription,
    this.onTap,
    this.onLongPress,
  });

  String _getBillingCycleShortLabel(BillingCycle cycle) {
    // TODO: Localize
    switch (cycle) {
      case BillingCycle.weekly: return 'wk';
      case BillingCycle.monthly: return 'mo';
      case BillingCycle.quarterly: return 'qtr';
      case BillingCycle.biAnnual: return '6mo';
      case BillingCycle.yearly: return 'yr';
      case BillingCycle.custom: return 'cust';
    }
  }

  Color _getDaysUntilBillingColor(BuildContext context, int days) {
    final theme = Theme.of(context);
    if (days < 0) return theme.colorScheme.error; // Overdue
    if (days <= 3) return theme.colorScheme.error.withOpacity(0.8);
    if (days <= 7) return theme.colorScheme.warning.withOpacity(0.9); // Or theme.colorScheme.tertiary
    return theme.colorScheme.onSurfaceVariant;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // TODO: Use locale from SettingsProvider
    final currencyFormat = NumberFormat.currency(locale: 'de_DE', symbol: '€', decimalDigits: 2);
    final dateFormat = DateFormat('dd MMM, yyyy'); // TODO: Localize

    final daysUntil = subscription.daysUntilBilling;
    final String daysLabel = daysUntil < 0
        ? '${daysUntil.abs()} days ago' // TODO: Localize
        : daysUntil == 0
            ? 'Today' // TODO: Localize
            : daysUntil == 1
                ? 'Tomorrow' // TODO: Localize
                : '$daysUntil days'; // TODO: Localize

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              // Logo or Initial
              _buildLogo(context, theme),
              const SizedBox(width: 12.0),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      subscription.name,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      subscription.categoryDisplayName, // From entity
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    if (subscription.isInTrial) ...[
                      const SizedBox(height: 4.0),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.tertiaryContainer,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'TRIAL', // TODO: Localize
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: theme.colorScheme.onTertiaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12.0),
              // Price and Due Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${currencyFormat.format(subscription.price)} / ${_getBillingCycleShortLabel(subscription.billingCycle)}',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_rounded,
                        size: 12,
                        color: _getDaysUntilBillingColor(context, daysUntil),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        dateFormat.format(subscription.nextBillingDate),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: _getDaysUntilBillingColor(context, daysUntil),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                   Text(
                      daysLabel,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: _getDaysUntilBillingColor(context, daysUntil),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context, ThemeData theme) {
    final hasRemoteLogo = subscription.logoUrl != null && subscription.logoUrl!.isNotEmpty;
    // final hasLocalLogo = subscription.localLogoPath != null && subscription.localLogoPath!.isNotEmpty; // If using local assets
    final Color bgColor = subscription.color ?? subscription.category.categoryDisplayIconColor(theme).withOpacity(0.1); // Use entity's color or category color
    final Color fgColor = subscription.color != null ? (ThemeData.estimateBrightnessForColor(subscription.color!) == Brightness.dark ? Colors.white : Colors.black) : subscription.category.categoryDisplayIconColor(theme);


    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect( // Ensure image is clipped to rounded corners
        borderRadius: BorderRadius.circular(10.0),
        child: hasRemoteLogo
            ? CachedNetworkImage(
                imageUrl: subscription.logoUrl!,
                width: 52,
                height: 52,
                fit: BoxFit.contain, // Or BoxFit.cover
                placeholder: (context, url) => Center(
                  child: Icon(
                    subscription.categoryDisplayIcon,
                    color: fgColor.withOpacity(0.5),
                    size: 28,
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(
                    subscription.categoryDisplayIcon, // Fallback icon
                    color: fgColor.withOpacity(0.7),
                    size: 28,
                  ),
                ),
              )
            // : hasLocalLogo
            //     ? Image.asset(subscription.localLogoPath!, fit: BoxFit.contain) // Example for local asset
            : Center( // Fallback to initial or category icon
                child: Text(
                  subscription.name.isNotEmpty ? subscription.name[0].toUpperCase() : '?',
                  style: theme.textTheme.titleLarge?.copyWith(color: fgColor, fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}

// Add this extension to your subscription_entity.dart or a shared utility file
// to get category colors that contrast with the theme.
extension CategoryDisplayHelpers on SubscriptionCategory {
   Color categoryDisplayIconColor(ThemeData theme) {
    // Simple example: use primary for light theme, onSurface for dark
    // Or use the predefined AppColors.catXYZ
    switch (this) {
      case SubscriptionCategory.streaming: return AppColors.catStreaming;
      case SubscriptionCategory.software: return AppColors.catSoftware;
      case SubscriptionCategory.gaming: return AppColors.catGaming;
      case SubscriptionCategory.fitness: return AppColors.catFitness;
      case SubscriptionCategory.music: return AppColors.catMusic;
      case SubscriptionCategory.news: return AppColors.catNews;
      case SubscriptionCategory.cloud: return AppColors.catCloud;
      case SubscriptionCategory.utilities: return Colors.teal; // Example
      case SubscriptionCategory.education: return Colors.indigo; // Example
      case SubscriptionCategory.other: return AppColors.catOther;
      default: return theme.colorScheme.onSurfaceVariant;
    }
  }
}