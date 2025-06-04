import 'package:aboapp/core/routing/app_router.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';
import 'package:aboapp/features/subscriptions/presentation/widgets/monthly_spending_summary_card.dart';
import 'package:aboapp/features/subscriptions/presentation/widgets/subscription_card_widget.dart';
import 'package:aboapp/widgets/empty_state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';
import 'package:aboapp/core/utils/haptic_feedback.dart' as app_haptics;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  bool _isSearching = false;
  late AnimationController _fabAnimationController;


  @override
  void initState() {
    super.initState();
    // Load subscriptions when the screen is initialized
    // Ensure Cubit is available in the widget tree (usually provided higher up)
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
      case BillingCycle.weekly: return 'Weekly';
      case BillingCycle.monthly: return 'Monthly';
      case BillingCycle.quarterly: return 'Quarterly';
      case BillingCycle.biAnnual: return 'Bi-Annual';
      case BillingCycle.yearly: return 'Yearly';
      case BillingCycle.custom: return 'Custom';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final localizations = AppLocalizations.of(context); // For localization

    return Scaffold(
      // AppBar is part of the MainContainerScreen now, 
      // but individual screens can also have their own if needed (e.g. SliverAppBar)
      // For this setup, assuming HomeScreen might want its own specific AppBar content
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _isSearching
              ? TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: 'Search subscriptions...', // localizations.translate('search_subscriptions'),
                    border: InputBorder.none,
                    isDense: true,
                    hintStyle: theme.appBarTheme.titleTextStyle?.copyWith(
                      fontWeight: FontWeight.normal,
                      color: theme.colorScheme.onSurface.withOpacity(0.6)
                    )
                  ),
                  style: theme.appBarTheme.titleTextStyle,
                  onChanged: (query) => context.read<SubscriptionCubit>().searchSubscriptions(query),
                )
              : Text('My Subscriptions'), // localizations.translate('my_subscriptions')),
        ),
        actions: [
          IconButton(
            icon: Icon(_isSearching ? Icons.close_rounded : Icons.search_rounded),
            onPressed: () => _toggleSearch(context),
            tooltip: _isSearching ? 'Close Search' : 'Search', // localizations.translate(_isSearching ? 'close_search' : 'search'),
          ),
          // Actions like navigating to Statistics/Settings are now handled by the MainContainerScreen's BottomAppBar
        ],
      ),
      body: BlocBuilder<SubscriptionCubit, SubscriptionState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: CircularProgressIndicator.adaptive()),
            loading: () => _buildLoadingShimmer(theme),
            loaded: (allSubs, filteredSubs, sortOption, filterCat, filterBill, searchTerm) {
              final activeSubscriptions = allSubs.where((s) => s.isActive).toList();
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
                    _buildFilterAndSortControls(context, theme, sortOption, filterCat, filterBill),
                    if (filteredSubs.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: EmptyStateWidget(
                            icon: Icons.search_off_rounded,
                            // title: localizations.translate('no_subscriptions_found'),
                            // message: localizations.translate('try_adjusting_filters'),
                            title: 'No Subscriptions Found',
                            message: 'Try adjusting your search or filters.',
                            onRetry: () => context.read<SubscriptionCubit>().clearAllFilters(),
                            retryText: 'Clear Filters', // localizations.translate('clear_filters'),
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
                                  extra: subscription, // Pass the entity for immediate display
                                );
                              },
                              onLongPress: () => _showSubscriptionActions(context, theme, subscription),
                            );
                          },
                          childCount: filteredSubs.length,
                        ),
                      ),
                    const SliverPadding(padding: EdgeInsets.only(bottom: 80)), // For FAB
                  ],
                ),
              );
            },
            error: (message) => Center(
              child: EmptyStateWidget(
                icon: Icons.error_outline_rounded,
                title: 'Error', // localizations.translate('error_occurred'),
                message: message,
                onRetry: () => context.read<SubscriptionCubit>().loadSubscriptions(),
                retryText: 'Retry', // localizations.translate('retry'),
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
                // Sort Dropdown
                DropdownButtonHideUnderline(
                  child: DropdownButton<SortOption>(
                    value: currentSort ?? SortOption.nextBillingDateAsc,
                    icon: const Icon(Icons.sort_rounded, size: 20),
                    style: theme.textTheme.bodySmall,
                    items: SortOption.values.map((option) {
                      return DropdownMenuItem<SortOption>(
                        value: option,
                        child: Text(option.toString().split('.').last), // TODO: Localize
                      );
                    }).toList(),
                    onChanged: (option) {
                      if (option != null) {
                        context.read<SubscriptionCubit>().changeSortOption(option);
                      }
                    },
                  ),
                ),
                // Clear All Filters Button
                if (currentCat != null || currentBill != null || (_searchController.text.isNotEmpty && _isSearching))
                  TextButton.icon(
                    icon: const Icon(Icons.clear_all_rounded, size: 18),
                    label: Text('Clear Filters'), // TODO: Localize
                    onPressed: () => context.read<SubscriptionCubit>().clearAllFilters(),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            // Category Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: Text('All Cats'), // TODO: Localize
                    selected: currentCat == null,
                    onSelected: (_) => context.read<SubscriptionCubit>().clearCategoryFilter(),
                  ),
                  ...SubscriptionCategory.values.map((category) => Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: FilterChip(
                          avatar: Icon(category.categoryDisplayIcon, size: 16, color: category == currentCat ? theme.colorScheme.onPrimary : category.categoryDisplayIconColor(theme)),
                          label: Text(category.categoryDisplayName), // TODO: Localize
                          selected: currentCat == category,
                          onSelected: (selected) {
                            context.read<SubscriptionCubit>().filterByCategory(selected ? category : null);
                          },
                          selectedColor: category.categoryDisplayIconColor(theme), // Use category color for selected chip
                          checkmarkColor: theme.colorScheme.onPrimary,
                        ),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 4),
            // Billing Cycle Filter Chips
             SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                   FilterChip(
                    label: Text('All Cycles'), // TODO: Localize
                    selected: currentBill == null,
                    onSelected: (_) => context.read<SubscriptionCubit>().clearBillingCycleFilter(),
                  ),
                  ...BillingCycle.values.where((c) => c != BillingCycle.custom).map((cycle) => Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: FilterChip(
                          label: Text(_getBillingCycleLabel(context, cycle)),
                          selected: currentBill == cycle,
                          onSelected: (selected) {
                             context.read<SubscriptionCubit>().filterByBillingCycle(selected ? cycle : null);
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
      baseColor: theme.colorScheme.surfaceVariant.withOpacity(0.3),
      highlightColor: theme.colorScheme.surfaceVariant.withOpacity(0.1),
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Shimmer for MonthlySpendingCard
          Container(
            height: 130.0,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(12.0),
            ),
            margin: const EdgeInsets.only(bottom: 16),
          ),
          // Shimmer for filter controls (simplified)
          Container(height: 40, color: theme.cardColor, margin: const EdgeInsets.only(bottom:8)),
          Container(height: 40, color: theme.cardColor, margin: const EdgeInsets.only(bottom:16)),
          // Shimmer for SubscriptionCards
          ...List.generate(5, (index) => Container(
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

  void _showSubscriptionActions(BuildContext context, ThemeData theme, SubscriptionEntity subscription) {
    app_haptics.HapticFeedback.mediumImpact();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (builderContext) { // Use a different context name
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: const Icon(Icons.edit_rounded),
              title: Text('Edit Subscription'), // localizations.translate('edit_subscription')),
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
              leading: Icon(subscription.isActive ? Icons.pause_circle_outline_rounded : Icons.play_circle_outline_rounded),
              title: Text(subscription.isActive ? 'Pause Subscription' : 'Resume Subscription'), // localizations.translate(subscription.isActive ? 'pause_subscription' : 'resume_subscription')),
              onTap: () {
                Navigator.pop(builderContext);
                context.read<SubscriptionCubit>().toggleSubscriptionActiveStatus(subscription.id);
              },
            ),
             ListTile(
              leading: Icon(subscription.notificationsEnabled ? Icons.notifications_off_rounded : Icons.notifications_active_rounded),
              title: Text(subscription.notificationsEnabled ? 'Disable Notifications' : 'Enable Notifications'), // localizations.translate(subscription.notificationsEnabled ? 'disable_notifications' : 'enable_notifications')),
              onTap: () {
                Navigator.pop(builderContext);
                context.read<SubscriptionCubit>().toggleSubscriptionNotification(subscription.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete_forever_rounded, color: theme.colorScheme.error),
              title: Text('Delete Subscription', style: TextStyle(color: theme.colorScheme.error)), // localizations.translate('delete_subscription')),
              onTap: () async {
                Navigator.pop(builderContext);
                final confirmDelete = await showDialog<bool>(
                  context: context, // Use original context for dialog
                  builder: (dialogContext) => AlertDialog(
                    title: Text('Confirm Delete'), // localizations.translate('confirm_delete')),
                    content: Text('Are you sure you want to delete "${subscription.name}"? This cannot be undone.'), // localizations.translate('delete_confirmation_message', args: {'name': subscription.name})),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancel'), // localizations.translate('cancel')),
                        onPressed: () => Navigator.of(dialogContext).pop(false),
                      ),
                      TextButton(
                        child: Text('Delete', style: TextStyle(color: theme.colorScheme.error)), // localizations.translate('delete')),
                        onPressed: () => Navigator.of(dialogContext).pop(true),
                      ),
                    ],
                  ),
                );
                if (confirmDelete == true) {
                  context.read<SubscriptionCubit>().deleteSubscription(subscription.id);
                }
              },
            ),
          ],
        );
      },
    );
  }
}
// Helper extension for category colors on icons within chips
extension CategoryDisplayExtension on SubscriptionCategory {
  Color categoryDisplayIconColor(ThemeData theme) {
    // Use a color that contrasts well with the chip's default background
    // This is a simple example; you might need more sophisticated logic
    // or define these in AppColors alongside categoryColor.
    return theme.brightness == Brightness.light ? AppColors.onSurfaceVariantLight : AppColors.onSurfaceVariantDark;
  }
}