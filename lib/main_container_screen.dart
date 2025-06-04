import 'package:aboapp/core/routing/app_router.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/features/subscriptions/presentation/screens/add_edit_subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
// Import your AppLocalizations class
// import 'package:aboapp/core/localization/app_localizations.dart';
import 'package:aboapp/core/utils/haptic_feedback.dart' as app_haptics;


class MainContainerScreen extends StatefulWidget {
  final Widget child; // The current screen content from GoRouter
  final String location; // The current route location

  const MainContainerScreen({
    super.key,
    required this.child,
    required this.location,
  });

  @override
  State<MainContainerScreen> createState() => _MainContainerScreenState();
}

class _MainContainerScreenState extends State<MainContainerScreen> {
  late PageController _pageController;
  int _currentPageIndex = 0;

  // Map route locations to PageView indices
  // Ensure these paths match exactly what you define in GoRouter for the shell's direct children
  static const List<String> _pageLocations = [
    AppRoutes.home, // Or specifically /home/subscriptions if that's the default
    AppRoutes.home + "/" + AppRoutes.statistics, // e.g., /home/statistics
    AppRoutes.home + "/" + AppRoutes.settings,   // e.g., /home/settings
  ];

  @override
  void initState() {
    super.initState();
    _currentPageIndex = _calculatePageIndex(widget.location);
    _pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void didUpdateWidget(MainContainerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.location != oldWidget.location) {
      final newIndex = _calculatePageIndex(widget.location);
      if (newIndex != _currentPageIndex) {
        _currentPageIndex = newIndex;
        // Animate PageView if navigating via GoRouter link,
        // but jump if it's a programmatic change from BottomAppBar.
        // For simplicity, we'll just jump here as GoRouter handles the primary nav.
        if (_pageController.hasClients && _pageController.page?.round() != _currentPageIndex) {
             _pageController.jumpToPage(_currentPageIndex);
        }
      }
    }
  }

  int _calculatePageIndex(String location) {
    if (location.startsWith(AppRoutes.home + "/" + AppRoutes.statistics)) {
      return 1;
    } else if (location.startsWith(AppRoutes.home + "/" + AppRoutes.settings)) {
      return 2;
    }
    // Default to home/subscriptions if no other match or just /home
    return 0; 
  }

  void _onPageChanged(int index) {
    if (_currentPageIndex == index) return;
    setState(() {
      _currentPageIndex = index;
    });
    app_haptics.HapticFeedback.selectionClick();
    // Navigate using GoRouter when PageView swipes
    // This keeps the URL in sync with the PageView state.
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.home); // Or specific subscription route name
        break;
      case 1:
        context.goNamed(AppRoutes.statistics);
        break;
      case 2:
        context.goNamed(AppRoutes.settings);
        break;
    }
  }

  void _onBottomNavItemTapped(int index) {
     if (_currentPageIndex == index) return;
    // Update PageController which will trigger _onPageChanged and then GoRouter navigation
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
  
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final localizations = AppLocalizations.of(context); // Get localizations
    final theme = Theme.of(context);

    return Scaffold(
      // AppBar is now handled by individual screens within the PageView/child
      body: widget.child, // This is where GoRouter places the current screen

      // Floating Action Button (conditionally shown based on current page/route)
      floatingActionButton: _currentPageIndex == 0 // Only show FAB on the HomeScreen (index 0)
          ? FloatingActionButton(
              onPressed: () {
                app_haptics.HapticFeedback.lightImpact();
                // Use GoRouter to navigate to the add subscription screen
                // It will be pushed on top of the ShellRoute due to parentNavigatorKey
                context.pushNamed(AppRoutes.addSubscription);
              },
              // tooltip: localizations.translate('add_subscription'),
              tooltip: 'Add Subscription', // TODO: Localize
              child: const Icon(Icons.add_rounded),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // BottomAppBar with Page Indicator or BottomNavigationBar
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(), // For FAB notch
        notchMargin: 6.0,
        color: theme.bottomNavigationBarTheme.backgroundColor ?? theme.colorScheme.surface,
        elevation: theme.bottomNavigationBarTheme.elevation ?? 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildBottomNavItem(
              context: context,
              icon: Icons.list_alt_rounded,
              // label: localizations.translate('subscriptions'),
              label: 'Subscriptions', // TODO: Localize
              index: 0,
              isSelected: _currentPageIndex == 0,
              onTap: () => _onBottomNavItemTapped(0),
            ),
            _buildBottomNavItem(
              context: context,
              icon: Icons.bar_chart_rounded,
              // label: localizations.translate('statistics'),
              label: 'Statistics', // TODO: Localize
              index: 1,
              isSelected: _currentPageIndex == 1,
              onTap: () => _onBottomNavItemTapped(1),
            ),
            const SizedBox(width: 40), // The dummy child for the notch
            _buildBottomNavItem(
              context: context,
              icon: Icons.settings_rounded,
              // label: localizations.translate('settings'),
              label: 'Settings', // TODO: Localize
              index: 2,
              isSelected: _currentPageIndex == 2,
              onTap: () => _onBottomNavItemTapped(2),
            ),
             _buildBottomNavItem( // Example of one more item if needed
              context: context,
              icon: Icons.info_outline_rounded,
              label: 'About', // TODO: Localize
              index: 3, // This would require a 4th page
              isSelected: _currentPageIndex == 3,
              onTap: () {
                 // Example: context.go('/home/about'); or show a dialog
                 // For now, this is just a placeholder
              },
            ),
          ],
        ),
      ),
    );
  }

   Widget _buildBottomNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final color = isSelected
        ? theme.bottomNavigationBarTheme.selectedItemColor ?? theme.colorScheme.primary
        : theme.bottomNavigationBarTheme.unselectedItemColor ?? theme.colorScheme.onSurfaceVariant;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.0), // For ripple effect
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, color: color, size: 24),
              const SizedBox(height: 2),
              Text(
                label,
                style: (isSelected
                        ? theme.bottomNavigationBarTheme.selectedLabelStyle
                        : theme.bottomNavigationBarTheme.unselectedLabelStyle)
                    ?.copyWith(color: color, fontSize: 10), // Ensure font size is small
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}