// lib/main_container_screen.dart

import 'package:aboapp/core/routing/app_router.dart';
import 'package:aboapp/features/settings/presentation/cubit/screens/settings_screen.dart';
import 'package:aboapp/features/statistics/presentation/screens/statistics_screen.dart';
import 'package:aboapp/features/subscriptions/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:aboapp/core/utils/haptic_feedback.dart' as app_haptics;
import 'package:aboapp/core/utils/color_extensions.dart';

class MainContainerScreen extends StatefulWidget {
  final String location;
  const MainContainerScreen({super.key, required this.location});

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
    final theme = Theme.of(context);
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: const <Widget>[
          HomeScreen(),
          StatisticsScreen(),
          SettingsScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          app_haptics.HapticFeedback.lightImpact();
          context.pushNamed(AppRoutes.addSubscription);
        },
        tooltip: 'Add Subscription',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8.0,
        // FIX: Das Row-Widget wird in einen Container mit oberem Rand gewickelt.
        child: Container(
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(
                      color: theme.dividerColor.withValues(alpha: 128), width: 1.0))),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _buildBottomNavItem(
                  context: context,
                  icon: Icons.home_filled,
                  label: 'Home',
                  index: 0),
              _buildBottomNavItem(
                  context: context,
                  icon: Icons.pie_chart_rounded,
                  label: 'Stats',
                  index: 1),
              const SizedBox(width: 48), // The notch space
              _buildBottomNavItem(
                  context: context,
                  icon: Icons.settings_rounded,
                  label: 'Settings',
                  index: 2),
              _buildBottomNavItem(
                  context: context,
                  icon: Icons.person_rounded,
                  label: 'Profile',
                  index: 3), // Example for future use
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
  }) {
    final theme = Theme.of(context);
    final isSelected = _currentIndex == index;
    final bool isDisabled = index > 2; // Profil-Icon ist deaktiviert

    // Die Farben werden jetzt direkt vom überarbeiteten Theme korrekt übernommen.
    final color = isDisabled
        ? theme.colorScheme.onSurface.withValues(alpha: 77)
        : isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurfaceVariant;

    return Expanded(
      child: InkWell(
        onTap: isDisabled ? null : () => _onBottomNavItemTapped(index),
        customBorder: const CircleBorder(),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Icon(icon, color: color, size: 28),
        ),
      ),
    );
  }
}
