// lib/features/subscriptions/presentation/widgets/subscription_card_widget.dart

import 'package:aboapp/core/theme/app_colors.dart';
import 'package:aboapp/core/utils/currency_formatter.dart';
import 'package:aboapp/core/utils/date_formatter.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/core/localization/l10n_extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  String _getBillingCycleShortLabel(BuildContext context, BillingCycle cycle) {
    switch (cycle) {
      case BillingCycle.weekly:
        return context.l10n.billing_cycle_short_weekly;
      case BillingCycle.monthly:
        return context.l10n.billing_cycle_short_monthly;
      case BillingCycle.quarterly:
        return context.l10n.billing_cycle_short_quarterly;
      case BillingCycle.biAnnual:
        return context.l10n.billing_cycle_short_biAnnual;
      case BillingCycle.yearly:
        return context.l10n.billing_cycle_short_yearly;
      case BillingCycle.custom:
        return context.l10n.billing_cycle_short_custom;
    }
  }

  Color _getDaysUntilBillingColor(BuildContext context, int days) {
    final theme = Theme.of(context);
    if (days < 0) return theme.colorScheme.error;
    if (days <= 3) return theme.colorScheme.error.withAlpha(204);
    if (days <= 7) return AppColors.warning.withAlpha(230);
    return theme.colorScheme.onSurfaceVariant;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingsState = context.watch<SettingsCubit>().state;

    final daysUntil = subscription.daysUntilBilling;
    final daysLabel = DateFormatter.formatDaysUntil(
      subscription.nextBillingDate,
      todayText:
          context.l10n.subscription_card_days_until_label_today,
      tomorrowText:
          context.l10n.subscription_card_days_until_label_tomorrow,
      daysAgoText:
          '${context.l10n.subscription_card_days_until_label_overdue_prefix} {days} ${context.l10n.subscription_card_days_until_label_overdue_suffix}',
      daysFutureText:
          '${context.l10n.subscription_card_days_until_label_prefix} {days} ${context.l10n.subscription_card_days_until_label_suffix}',
    );

    final bool isInactive = !subscription.isActive;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        child: Container(
          foregroundDecoration: BoxDecoration(
            color: isInactive
                ? theme.colorScheme.onSurface
                    .withAlpha(20) // Subtiles graues Overlay
                : Colors.transparent,
            borderRadius: BorderRadius.circular(
                theme.cardTheme.shape is RoundedRectangleBorder
                    ? ((theme.cardTheme.shape as RoundedRectangleBorder)
                            .borderRadius as BorderRadius)
                        .topLeft
                        .x
                    : 12.0),
          ),
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
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        subscription.category.displayName(context),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      if (subscription.isInTrial) ...[
                        const SizedBox(height: 4.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            context.l10n.subscription_card_trial_badge,
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
                      '${CurrencyFormatter.format(subscription.price, currencyCode: settingsState.currencyCode, locale: settingsState.locale)} / ${_getBillingCycleShortLabel(context, subscription.billingCycle)}',
                      // HIER IST DIE ÄNDERUNG:
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        // Farbe ist jetzt abhängig vom Status
                        color: isInactive
                            ? theme.colorScheme.onSurfaceVariant
                            : theme.colorScheme.primary,
                        // Dekoration (Durchstrich) ist auch abhängig vom Status
                        decoration: isInactive
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        // Die Farbe des Durchstrichs erbt jetzt die Textfarbe (also grau)
                        decorationThickness: 1.5,
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
                          DateFormatter.formatDate(subscription.nextBillingDate,
                              locale: settingsState.locale),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color:
                                _getDaysUntilBillingColor(context, daysUntil),
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
      ),
    );
  }

  Widget _buildLogo(BuildContext context, ThemeData theme) {
    final hasRemoteLogo =
        subscription.logoUrl != null && subscription.logoUrl!.isNotEmpty;
    final Color bgColor = subscription.color ??
        subscription.category.categoryDisplayIconColor(theme).withAlpha(26);
    final Color fgColor = subscription.color != null
        ? (ThemeData.estimateBrightnessForColor(subscription.color!) ==
                Brightness.dark
            ? Colors.white
            : Colors.black)
        : subscription.category.categoryDisplayIconColor(theme);

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
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
                        subscription.category.displayIcon,
                        color: fgColor.withAlpha(128),
                        size: 28,
                      ),
                    ),
                    errorWidget: (context, url, error) => Center(
                      child: Icon(
                        subscription.category.displayIcon,
                        color: fgColor.withAlpha(179),
                        size: 28,
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      subscription.name.isNotEmpty
                          ? subscription.name[0].toUpperCase()
                          : '?',
                      style: theme.textTheme.titleLarge?.copyWith(
                          color: fgColor, fontWeight: FontWeight.bold),
                    ),
                  ),
          ),
        ),
        if (!subscription.notificationsEnabled)
          Positioned(
            top: -4,
            right: -4,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.cardColor.withAlpha(217),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(26),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  )
                ],
              ),
              child: Icon(
                Icons.notifications_off_rounded,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
      ],
    );
  }
}

extension CategoryDisplayHelpers on SubscriptionCategory {
  Color categoryDisplayIconColor(ThemeData theme) {
    switch (this) {
      case SubscriptionCategory.streaming:
        return AppColors.catStreaming;
      case SubscriptionCategory.software:
        return AppColors.catSoftware;
      case SubscriptionCategory.gaming:
        return AppColors.catGaming;
      case SubscriptionCategory.fitness:
        return AppColors.catFitness;
      case SubscriptionCategory.music:
        return AppColors.catMusic;
      case SubscriptionCategory.news:
        return AppColors.catNews;
      case SubscriptionCategory.cloud:
        return AppColors.catCloud;
      case SubscriptionCategory.utilities:
        return Colors.teal.shade400;
      case SubscriptionCategory.education:
        return Colors.indigo.shade400;
      case SubscriptionCategory.other:
        return AppColors.catOther;
    }
  }

  String displayName(BuildContext context) {
    switch (this) {
      case SubscriptionCategory.streaming:
        return context.l10n.category_streaming;
      case SubscriptionCategory.software:
        return context.l10n.category_software;
      case SubscriptionCategory.gaming:
        return context.l10n.category_gaming;
      case SubscriptionCategory.fitness:
        return context.l10n.category_fitness;
      case SubscriptionCategory.music:
        return context.l10n.category_music;
      case SubscriptionCategory.news:
        return context.l10n.category_news;
      case SubscriptionCategory.cloud:
        return context.l10n.category_cloud;
      case SubscriptionCategory.utilities:
        return context.l10n.category_utilities;
      case SubscriptionCategory.education:
        return context.l10n.category_education;
      case SubscriptionCategory.other:
        return context.l10n.category_other;
    }
  }

  IconData get displayIcon {
    switch (this) {
      case SubscriptionCategory.streaming:
        return Icons.live_tv_rounded;
      case SubscriptionCategory.software:
        return Icons.widgets_outlined;
      case SubscriptionCategory.gaming:
        return Icons.gamepad_outlined;
      case SubscriptionCategory.fitness:
        return Icons.fitness_center_rounded;
      case SubscriptionCategory.music:
        return Icons.music_note_rounded;
      case SubscriptionCategory.news:
        return Icons.article_outlined;
      case SubscriptionCategory.cloud:
        return Icons.cloud_outlined;
      case SubscriptionCategory.utilities:
        return Icons.lightbulb_outline_rounded;
      case SubscriptionCategory.education:
        return Icons.school_outlined;
      case SubscriptionCategory.other:
        return Icons.category_rounded;
    }
  }
}
