// lib/main_container_screen.dart

import 'package:aboapp/core/routing/app_router.dart';
import 'package:aboapp/features/settings/presentation/cubit/screens/settings_screen.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:aboapp/features/statistics/presentation/screens/statistics_screen.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';
import 'package:aboapp/features/subscriptions/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:aboapp/core/utils/haptic_feedback.dart' as app_haptics;
import 'package:aboapp/core/localization/l10n_extensions.dart';

class MainContainerScreen extends StatefulWidget {
  final String location;
  final Widget child;
  const MainContainerScreen({super.key, required this.location, required this.child});

  @override
  State<MainContainerScreen> createState() => _MainContainerScreenState();
}

class _MainContainerScreenState extends State<MainContainerScreen> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = _calculatePageIndex(widget.location);
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void didUpdateWidget(covariant MainContainerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newIndex = _calculatePageIndex(widget.location);
    if (newIndex != _currentIndex) {
      setState(() {
        _currentIndex = newIndex;
      });
      if (_pageController.hasClients &&
          _pageController.page?.round() != newIndex) {
        _pageController.jumpToPage(newIndex);
      }
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  int _calculatePageIndex(String location) {
    if (location.startsWith(AppRoutes.statistics)) return 1;
    if (location.startsWith(AppRoutes.settings)) return 2;
    return 0;
  }

  void _onPageChanged(int index) {
    if (_currentIndex == index) return;
    _updateRoute(index);
  }

  void _updateRoute(int index) {
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        context.go(AppRoutes.statistics);
        break;
      case 2:
        context.go(AppRoutes.settings);
        break;
    }
  }

  void _onBottomNavItemTapped(int index) {
    if (index == 3) {
      context.pushNamed(AppRoutes.suggestions);
      return;
    }
    if (_currentIndex == index) return;
    app_haptics.HapticFeedback.selectionClick();
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            physics: const BouncingScrollPhysics(),
            children: <Widget>[
              const HomeScreen(),
              BlocProvider(
                create: (context) => StatisticsCubit(
                  subscriptionCubit: context.read<SubscriptionCubit>(),
                  settingsCubit: context.read<SettingsCubit>(),
                ),
                child: const StatisticsScreen(),
              ),
              const SettingsScreen(),
            ],
          ),
               IgnorePointer(
            ignoring: widget.location == AppRoutes.home ||
                widget.location == AppRoutes.statistics ||
                widget.location == AppRoutes.settings,
            child: widget.child,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          app_haptics.HapticFeedback.lightImpact();
          context.pushNamed(AppRoutes.addSubscription);
        },
        tooltip: context.l10n.home_add_subscription_tooltip,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildBottomNavItem(
                icon: Icons.home_filled,
                label: context.l10n.bottom_nav_subscriptions,
                index: 0),
            _buildBottomNavItem(
                icon: Icons.pie_chart_rounded,
                label: context.l10n.bottom_nav_statistics,
                index: 1),
            const SizedBox(width: 48), // The notch space
            _buildBottomNavItem(
                icon: Icons.settings_rounded,
                label: context.l10n.bottom_nav_settings,
                index: 2),
            _buildBottomNavItem(
                icon: Icons.mail_rounded,
                label: context.l10n.bottom_nav_import,
                index: 3),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final theme = Theme.of(context);
    final isSelected = _currentIndex == index;
    // Import screen is accessed via navigation
    final color = isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurfaceVariant;

    return Expanded(
      child: TapScaleEffect(
        onTap: () => _onBottomNavItemTapped(index),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color, size: 28),
              const SizedBox(height: 2),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 4,
                width: isSelected ? 24 : 0,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TapScaleEffect extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const TapScaleEffect({super.key, required this.child, this.onTap});

  @override
  State<TapScaleEffect> createState() => _TapScaleEffectState();
}

class _TapScaleEffectState extends State<TapScaleEffect>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _controller.reverse();
    });
  }

  void _handleTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: widget.onTap != null ? _handleTapDown : null,
      onTapUp: widget.onTap != null ? _handleTapUp : null,
      onTapCancel: widget.onTap != null ? _handleTapCancel : null,
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
