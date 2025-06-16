// lib/features/subscriptions/presentation/screens/home_screen.dart

import 'package:aboapp/core/routing/app_router.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';
import 'package:aboapp/features/subscriptions/presentation/widgets/filter_bottom_sheet.dart';
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

// ZURÜCKGESETZT: AnimationController und TickerProvider entfernt
class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  final _searchFocusNode = FocusNode();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BlocBuilder<SubscriptionCubit, SubscriptionState>(
        builder: (context, state) {
          return state.when(
            initial: () =>
                const Center(child: CircularProgressIndicator.adaptive()),
            loading: () => _buildLoadingShimmer(theme),
            loaded: (allSubs, filteredSubs, sortOption, filterCats, filterBills,
                searchTerm) {
              final activeSubscriptions =
                  allSubs.where((s) => s.isActive).toList();
              final bool filtersAreActive = (filterCats?.isNotEmpty ?? false) ||
                  (filterBills?.isNotEmpty ?? false);

              return RefreshIndicator(
                onRefresh: () async {
                  app_haptics.HapticFeedback.mediumImpact();
                  await context.read<SubscriptionCubit>().loadSubscriptions();
                },
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  slivers: [
                    SliverAppBar(
                      title: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: _isSearching
                            ? TextField(
                                controller: _searchController,
                                focusNode: _searchFocusNode,
                                autofocus: true,
                                decoration: InputDecoration(
                                    hintText: 'Search subscriptions...',
                                    border: InputBorder.none,
                                    isDense: true,
                                    hintStyle: theme.appBarTheme.titleTextStyle
                                        ?.copyWith(
                                            fontWeight: FontWeight.normal,
                                            color: theme.colorScheme.onSurface
                                                .withAlpha(150))),
                                style: theme.appBarTheme.titleTextStyle,
                                onChanged: (query) => context
                                    .read<SubscriptionCubit>()
                                    .searchSubscriptions(query),
                              )
                            : const Text('My Subscriptions'),
                      ),
                      actions: [
                        if (!_isSearching)
                          IconButton(
                            icon: const Icon(Icons.filter_list_rounded),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (_) {
                                  return BlocProvider.value(
                                    value: BlocProvider.of<SubscriptionCubit>(
                                        context),
                                    child: FilterBottomSheet(
                                      currentSortOption: sortOption ??
                                          SortOption.nextBillingDateAsc,
                                      currentCategories: filterCats ?? [],
                                      currentBillingCycles: filterBills ?? [],
                                    ),
                                  );
                                },
                              );
                            },
                            tooltip: 'Filter & Sort',
                          ),
                        IconButton(
                          icon: Icon(_isSearching
                              ? Icons.close_rounded
                              : Icons.search_rounded),
                          onPressed: () => _toggleSearch(context),
                          tooltip: _isSearching ? 'Close Search' : 'Search',
                        ),
                      ],
                      floating: true,
                      snap: true,
                      backgroundColor: theme.scaffoldBackgroundColor,
                      elevation: 0,
                    ),
                    // ZURÜCKGESETZT: CustomPaint und Padding entfernt
                    if (!_isSearching)
                      SliverToBoxAdapter(
                        child: MonthlySpendingSummaryCard(
                          activeSubscriptions: activeSubscriptions,
                        ),
                      ),
                    if (filtersAreActive)
                      SliverToBoxAdapter(
                        child: _buildActiveFiltersBar(context, theme,
                            filterCats ?? [], filterBills ?? []),
                      ),
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
                      SliverPadding(
                        padding: const EdgeInsets.only(bottom: 80.0),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final subscription = filteredSubs[index];
                              return SubscriptionCardWidget(
                                subscription: subscription,
                                onTap: () => context.pushNamed(
                                    AppRoutes.editSubscription,
                                    pathParameters: {'id': subscription.id},
                                    extra: subscription),
                                onLongPress: () => _showSubscriptionActions(
                                    context, theme, subscription),
                              );
                            },
                            childCount: filteredSubs.length,
                          ),
                        ),
                      ),
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

  Widget _buildActiveFiltersBar(BuildContext context, ThemeData theme,
      List<SubscriptionCategory> cats, List<BillingCycle> bills) {
    List<Widget> chips = [];

    for (var cat in cats) {
      chips.add(Chip(
        label: Text(cat.displayName),
        onDeleted: () {
          context.read<SubscriptionCubit>().toggleCategoryFilter(cat);
        },
        deleteIconColor: theme.colorScheme.onSecondaryContainer,
        backgroundColor: theme.colorScheme.secondaryContainer,
        labelStyle: TextStyle(color: theme.colorScheme.onSecondaryContainer),
      ));
    }

    for (var bill in bills) {
      chips.add(Chip(
        label: Text(bill.name[0].toUpperCase() + bill.name.substring(1)),
        onDeleted: () {
          context.read<SubscriptionCubit>().toggleBillingCycleFilter(bill);
        },
        deleteIconColor: theme.colorScheme.onSecondaryContainer,
        backgroundColor: theme.colorScheme.secondaryContainer,
        labelStyle: TextStyle(color: theme.colorScheme.onSecondaryContainer),
      ));
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
      child: Wrap(
        spacing: 8.0,
        runSpacing: 8.0,
        children: chips,
      ),
    );
  }

  Widget _buildLoadingShimmer(ThemeData theme) {
    return Shimmer.fromColors(
      baseColor: theme.colorScheme.surfaceContainerHighest.withAlpha(100),
      highlightColor: theme.colorScheme.surfaceContainerHighest.withAlpha(50),
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Container(
            height: 150.0,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: const EdgeInsets.only(bottom: 16),
          ),
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
                if (confirmDelete == true && mounted) {
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
