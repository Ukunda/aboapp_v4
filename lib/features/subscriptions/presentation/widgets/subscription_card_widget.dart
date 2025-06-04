import 'package:aboapp/core/theme/app_colors.dart'; // Import AppColors
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
    if (days < 0) return theme.colorScheme.error; 
    if (days <= 3) return theme.colorScheme.error.withOpacity(0.8); // Kept withOpacity
    if (days <= 7) return AppColors.warning.withOpacity(0.9); // Used AppColors.warning, Kept withOpacity
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
              _buildLogo(context, theme),
              const SizedBox(width: 12.0),
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
                      subscription.category.displayName, // Using extension
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
    final Color bgColor = subscription.color ?? subscription.category.categoryDisplayIconColor(theme).withOpacity(0.1); // Kept withOpacity
    final Color fgColor = subscription.color != null ? (ThemeData.estimateBrightnessForColor(subscription.color!) == Brightness.dark ? Colors.white : Colors.black) : subscription.category.categoryDisplayIconColor(theme);


    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ClipRRect( 
        borderRadius: BorderRadius.circular(10.0),
        child: hasRemoteLogo
            ? CachedNetworkImage(
                imageUrl: subscription.logoUrl!,
                width: 52,
                height: 52,
                fit: BoxFit.contain, 
                placeholder: (context, url) => Center(
                  child: Icon(
                    subscription.category.displayIcon, // Using extension
                    color: fgColor.withOpacity(0.5), // Kept withOpacity
                    size: 28,
                  ),
                ),
                errorWidget: (context, url, error) => Center(
                  child: Icon(
                    subscription.category.displayIcon, // Using extension
                    color: fgColor.withOpacity(0.7), // Kept withOpacity
                    size: 28,
                  ),
                ),
              )
            : Center( 
                child: Text(
                  subscription.name.isNotEmpty ? subscription.name[0].toUpperCase() : '?',
                  style: theme.textTheme.titleLarge?.copyWith(color: fgColor, fontWeight: FontWeight.bold),
                ),
              ),
      ),
    );
  }
}

// Centralized display helpers for SubscriptionCategory
extension CategoryDisplayHelpers on SubscriptionCategory {
   Color categoryDisplayIconColor(ThemeData theme) {
    switch (this) {
      case SubscriptionCategory.streaming: return AppColors.catStreaming;
      case SubscriptionCategory.software: return AppColors.catSoftware;
      case SubscriptionCategory.gaming: return AppColors.catGaming;
      case SubscriptionCategory.fitness: return AppColors.catFitness;
      case SubscriptionCategory.music: return AppColors.catMusic;
      case SubscriptionCategory.news: return AppColors.catNews;
      case SubscriptionCategory.cloud: return AppColors.catCloud;
      case SubscriptionCategory.utilities: return Colors.teal.shade400; // Example
      case SubscriptionCategory.education: return Colors.indigo.shade400; // Example
      case SubscriptionCategory.other: return AppColors.catOther;
      // No default because all enum values are covered.
    }
  }

  String get displayName {
    // TODO: Localize these
    switch (this) {
      case SubscriptionCategory.streaming: return 'Streaming';
      case SubscriptionCategory.software: return 'Software';
      case SubscriptionCategory.gaming: return 'Gaming';
      case SubscriptionCategory.fitness: return 'Fitness';
      case SubscriptionCategory.music: return 'Music';
      case SubscriptionCategory.news: return 'News & Mags';
      case SubscriptionCategory.cloud: return 'Cloud Storage';
      case SubscriptionCategory.utilities: return 'Utilities';
      case SubscriptionCategory.education: return 'Education';
      case SubscriptionCategory.other: return 'Other';
    }
  }

  IconData get displayIcon {
     switch (this) {
      case SubscriptionCategory.streaming: return Icons.live_tv_rounded;
      case SubscriptionCategory.software: return Icons.widgets_outlined;
      case SubscriptionCategory.gaming: return Icons.gamepad_outlined;
      case SubscriptionCategory.fitness: return Icons.fitness_center_rounded;
      case SubscriptionCategory.music: return Icons.music_note_rounded;
      case SubscriptionCategory.news: return Icons.article_outlined;
      case SubscriptionCategory.cloud: return Icons.cloud_outlined;
      case SubscriptionCategory.utilities: return Icons.lightbulb_outline_rounded;
      case SubscriptionCategory.education: return Icons.school_outlined;
      case SubscriptionCategory.other: return Icons.category_rounded;
    }
  }
}