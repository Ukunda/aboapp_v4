import 'package:aboapp/core/routing/app_router.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';
import 'package:aboapp/features/subscriptions/presentation/widgets/monthly_spending_summary_card.dart';
import 'package:aboapp/features/subscriptions/presentation/widgets/subscription_card_widget.dart'; // For CategoryDisplayHelpers
import 'package:aboapp/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:aboapp/core/utils/haptic_feedback.dart' as app_haptics;
import 'package:aboapp/core/theme/app_colors.dart'; // Import AppColors
import 'package:aboapp/core/localization/localization_extension.dart';
import 'package:aboapp/core/localization/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  bool _isSearching = false;
  late AnimationController _fabAnimationController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SubscriptionCubit>().loadSubscriptions();
    });
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fabAnimationController.forward();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    _fabAnimationController.dispose();
    super.dispose();
  }

  void _toggleSearch(BuildContext context) {
    setState(() {
      _isSearching = !_isSearching;
      if (!_isSearching) {
        _searchController.clear();
        _searchFocusNode.unfocus();
        context.read<SubscriptionCubit>().clearSearch();
      } else {
        _searchFocusNode.requestFocus();
      }
    });
  }

  String _getBillingCycleLabel(BuildContext context, BillingCycle cycle) {
    // TODO: Localize
    switch (cycle) {
      case BillingCycle.weekly:
        return 'Weekly';
      case BillingCycle.monthly:
        return 'Monthly';
      case BillingCycle.quarterly:
        return 'Quarterly';
      case BillingCycle.biAnnual:
        return 'Bi-Annual';
      case BillingCycle.yearly:
        return 'Yearly';
      case BillingCycle.custom:
        return 'Custom';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _isSearching
              ? TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  autofocus: true,
                  decoration: InputDecoration(
                      hintText: context.tr(L10nKeys.homeSearchHint),
                      border: InputBorder.none,
                      isDense: true,
                      hintStyle: theme.appBarTheme.titleTextStyle?.copyWith(
                          fontWeight: FontWeight.normal,
                          color: theme.colorScheme.onSurface
                              .withOpacity(0.6) // Kept withOpacity
                          )),
                  style: theme.appBarTheme.titleTextStyle,
                  onChanged: (query) => context
                      .read<SubscriptionCubit>()
                      .searchSubscriptions(query),
                )
              : Text(context.tr(L10nKeys.homeMySubscriptions)),
        ),
        actions: [
          IconButton(
            icon:
                Icon(_isSearching ? Icons.close_rounded : Icons.search_rounded),
            onPressed: () => _toggleSearch(context),
            tooltip: _isSearching ? context.tr(L10nKeys.homeCloseSearchTooltip) : context.tr(L10nKeys.homeSearchTooltip),
          ),
        ],
      ),
      body: BlocBuilder<SubscriptionCubit, SubscriptionState>(
        builder: (context, state) {
          return state.when(
            initial: () =>
                const Center(child: CircularProgressIndicator.adaptive()),
            loading: () => _buildLoadingShimmer(theme),
            loaded: (allSubs, filteredSubs, sortOption, filterCat, filterBill,
                searchTerm) {
              final activeSubscriptions =
                  allSubs.where((s) => s.isActive).toList();
              return RefreshIndicator(
                onRefresh: () async {
                  app_haptics.HapticFeedback.mediumImpact();
                  await context.read<SubscriptionCubit>().loadSubscriptions();
                },
                child: CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    if (!_isSearching)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                          child: MonthlySpendingSummaryCard(
                            activeSubscriptions: activeSubscriptions,
                          ),
                        ),
                      ),
                    _buildFilterAndSortControls(
                        context, theme, sortOption, filterCat, filterBill),
                    if (filteredSubs.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: EmptyStateWidget(
                            icon: Icons.search_off_rounded,
                            title: 'No Subscriptions Found',
                            message: 'Try adjusting your search or filters.',
                            onRetry: () => context
                                .read<SubscriptionCubit>()
                                .clearAllFilters(),
                            retryText: 'Clear Filters',
                          ),
                        ),
                      )
                    else
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final subscription = filteredSubs[index];
                            return SubscriptionCardWidget(
                              subscription: subscription,
                              onTap: () {
                                context.pushNamed(
                                  AppRoutes.editSubscription,
                                  pathParameters: {'id': subscription.id},
                                  extra: subscription,
                                );
                              },
                              onLongPress: () => _showSubscriptionActions(
                                  context, theme, subscription),
                            );
                          },
                          childCount: filteredSubs.length,
                        ),
                      ),
                    const SliverPadding(padding: EdgeInsets.only(bottom: 80)),
                  ],
                ),
              );
            },
            error: (message) => Center(
              child: EmptyStateWidget(
                icon: Icons.error_outline_rounded,
                title: 'Error',
                message: message,
                onRetry: () =>
                    context.read<SubscriptionCubit>().loadSubscriptions(),
                retryText: 'Retry',
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildFilterAndSortControls(
    BuildContext context,
    ThemeData theme,
    SortOption? currentSort,
    SubscriptionCategory? currentCat,
    BillingCycle? currentBill,
  ) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButtonHideUnderline(
                  child: DropdownButton<SortOption>(
                    value: currentSort ?? SortOption.nextBillingDateAsc,
                    icon: const Icon(Icons.sort_rounded, size: 20),
                    style: theme.textTheme.bodySmall,
                    items: SortOption.values.map((option) {
                      return DropdownMenuItem<SortOption>(
                        value: option,
                        child: Text(option.displayName),
                      );
                    }).toList(),
                    onChanged: (option) {
                      if (option != null) {
                        context
                            .read<SubscriptionCubit>()
                            .changeSortOption(option);
                      }
                    },
                  ),
                ),
                if (currentCat != null ||
                    currentBill != null ||
                    (_searchController.text.isNotEmpty && _isSearching))
                  TextButton.icon(
                    icon: const Icon(Icons.clear_all_rounded, size: 18),
                    label: Text(context.tr(L10nKeys.homeClearFiltersButton)),
                    onPressed: () =>
                        context.read<SubscriptionCubit>().clearAllFilters(),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: Text(context.tr(L10nKeys.homeFilterAllCategories)),
                    selected: currentCat == null,
                    onSelected: (_) =>
                        context.read<SubscriptionCubit>().clearCategoryFilter(),
                  ),
                  ...SubscriptionCategory.values.map((category) => Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: FilterChip(
                          avatar: Icon(category.displayIcon,
                              size: 16,
                              color: category == currentCat
                                  ? theme.colorScheme.onPrimary
                                  : category.categoryDisplayIconColor(theme)),
                          label: Text(category.displayName),
                          selected: currentCat == category,
                          onSelected: (selected) {
                            context
                                .read<SubscriptionCubit>()
                                .filterByCategory(selected ? category : null);
                          },
                          selectedColor:
                              category.categoryDisplayIconColor(theme),
                          checkmarkColor: theme.colorScheme.onPrimary,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 4),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('All Cycles'),
                    selected: currentBill == null,
                    onSelected: (_) => context
                        .read<SubscriptionCubit>()
                        .clearBillingCycleFilter(),
                  ),
                  ...BillingCycle.values
                      .where((c) => c != BillingCycle.custom)
                      .map((cycle) => Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: FilterChip(
                              label:
                                  Text(_getBillingCycleLabel(context, cycle)),
                              selected: currentBill == cycle,
                              onSelected: (selected) {
                                context
                                    .read<SubscriptionCubit>()
                                    .filterByBillingCycle(
                                        selected ? cycle : null);
                              },
                            ),
                          )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingShimmer(ThemeData theme) {
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.surfaceContainerHighest
          .withOpacity(0.3), // Corrected deprecated
      highlightColor: theme.colorScheme.surfaceContainerHighest
          .withOpacity(0.1), // Corrected deprecated
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            height: 130.0,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: const EdgeInsets.only(bottom: 16),
          ),
          Container(
              height: 40,
              color: theme.cardColor,
              margin: const EdgeInsets.only(bottom: 8)),
          Container(
              height: 40,
              color: theme.cardColor,
              margin: const EdgeInsets.only(bottom: 16)),
          ...List.generate(
              5,
              (index) => Container(
                    height: 90.0,
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    margin: const EdgeInsets.only(bottom: 10.0),
                  )),
        ],
      ),
    );
  }

  void _showSubscriptionActions(
      BuildContext context, ThemeData theme, SubscriptionEntity subscription) {
    app_haptics.HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (builderContext) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.edit_rounded),
              title: const Text('Edit Subscription'),
              onTap: () {
                Navigator.pop(builderContext);
                context.pushNamed(
                  AppRoutes.editSubscription,
                  pathParameters: {'id': subscription.id},
                  extra: subscription,
                );
              },
            ),
            ListTile(
              leading: Icon(subscription.isActive
                  ? Icons.pause_circle_outline_rounded
                  : Icons.play_circle_outline_rounded),
              title: Text(subscription.isActive
                  ? 'Pause Subscription'
                  : 'Resume Subscription'),
              onTap: () {
                Navigator.pop(builderContext);
                context
                    .read<SubscriptionCubit>()
                    .toggleSubscriptionActiveStatus(subscription.id);
              },
            ),
            ListTile(
              leading: Icon(subscription.notificationsEnabled
                  ? Icons.notifications_off_rounded
                  : Icons.notifications_active_rounded),
              title: Text(subscription.notificationsEnabled
                  ? 'Disable Notifications'
                  : 'Enable Notifications'),
              onTap: () {
                Navigator.pop(builderContext);
                context
                    .read<SubscriptionCubit>()
                    .toggleSubscriptionNotification(subscription.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_forever_rounded,
                  color: theme.colorScheme.error),
              title: Text('Delete Subscription',
                  style: TextStyle(color: theme.colorScheme.error)),
              onTap: () async {
                Navigator.pop(builderContext);
                final confirmDelete = await showDialog<bool>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text('Confirm Delete'),
                    content: Text(
                        'Are you sure you want to delete "${subscription.name}"? This cannot be undone.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () => Navigator.of(dialogContext).pop(false),
                      ),
                      TextButton(
                        child: Text('Delete',
                            style: TextStyle(color: theme.colorScheme.error)),
                        onPressed: () => Navigator.of(dialogContext).pop(true),
                      ),
                    ],
                  ),
                );
                if (confirmDelete == true) {
                  if (!mounted) return; // Guard context use
                  context
                      .read<SubscriptionCubit>()
                      .deleteSubscription(subscription.id);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
