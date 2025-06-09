import 'package:aboapp/core/routing/app_router.dart';
// import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart'; // Unused
// import 'package:aboapp/features/subscriptions/presentation/screens/add_edit_subscription_screen.dart'; // Unused
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart'; // Unused
import 'package:go_router/go_router.dart';
import 'package:aboapp/core/utils/haptic_feedback.dart' as app_haptics;

class MainContainerScreen extends StatefulWidget {
  final Widget child;
  final String location;

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

  // static const List<String> _pageLocations = [ // Unused field
  //   AppRoutes.home,
  //   "${AppRoutes.home}/${AppRoutes.statistics}",
  //   "${AppRoutes.home}/${AppRoutes.settings}",
  // ];

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
        if (_pageController.hasClients &&
            _pageController.page?.round() != _currentPageIndex) {
          _pageController.jumpToPage(_currentPageIndex);
        }
      }
    }
  }

  int _calculatePageIndex(String location) {
    if (location.startsWith("${AppRoutes.home}/${AppRoutes.statistics}")) {
      // Used interpolation
      return 1;
    } else if (location.startsWith("${AppRoutes.home}/${AppRoutes.settings}")) {
      // Used interpolation
      return 2;
    }
    return 0;
  }

  // _onPageChanged removed as it was unused

  void _onBottomNavItemTapped(int index) {
    if (_currentPageIndex == index) return;

    // Navigate using GoRouter when BottomAppBar item is tapped
    // This keeps the URL in sync and GoRouter handles updating the ShellRoute's child
    app_haptics.HapticFeedback.selectionClick();
    switch (index) {
      case 0:
        context.goNamed(AppRoutes.home);
        break;
      case 1:
        context.goNamed(AppRoutes.statistics);
        break;
      case 2:
        context.goNamed(AppRoutes.settings);
        break;
      case 3: // For 'About' item
        // Example action: Show a dialog or navigate to an 'About' screen (if defined)
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('About AboApp'), // TODO: Localize
            content: const Text(
                'Version 3.0.0\nSubscription Management Made Easy.'), // TODO: Localize
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('Close'), // TODO: Localize
              )
            ],
          ),
        );
        // Do not change _currentPageIndex here if it's just a dialog
        // If it were a separate page in the PageView, then update index and use _pageController.
        return; // Return early to prevent _pageController interaction for dialogs
    }

    // Animate page controller only if it's a main navigation item
    if (index <= 2 && _pageController.hasClients) {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
    // No need to call setState here if GoRouter handles the rebuild via location change
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: widget.child,
      floatingActionButton: _currentPageIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                app_haptics.HapticFeedback.lightImpact();
                context.pushNamed(AppRoutes.addSubscription);
              },
              tooltip: 'Add Subscription',
              child: const Icon(Icons.add_rounded),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        color: theme.bottomNavigationBarTheme.backgroundColor ??
            theme.colorScheme.surface,
        elevation: theme.bottomNavigationBarTheme.elevation ?? 8.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildBottomNavItem(
              context: context,
              icon: Icons.list_alt_rounded,
              label: 'Subscriptions',
              index: 0,
              isSelected: _currentPageIndex == 0,
              onTap: () => _onBottomNavItemTapped(0),
            ),
            _buildBottomNavItem(
              context: context,
              icon: Icons.bar_chart_rounded,
              label: 'Statistics',
              index: 1,
              isSelected: _currentPageIndex == 1,
              onTap: () => _onBottomNavItemTapped(1),
            ),
            const SizedBox(width: 40),
            _buildBottomNavItem(
              context: context,
              icon: Icons.settings_rounded,
              label: 'Settings',
              index: 2,
              isSelected: _currentPageIndex == 2,
              onTap: () => _onBottomNavItemTapped(2),
            ),
            _buildBottomNavItem(
              context: context,
              icon: Icons.info_outline_rounded,
              label: 'About',
              index: 3,
              isSelected:
                  false, // 'About' is not a page in PageView, so never "selected" in that sense
              onTap: () => _onBottomNavItemTapped(3),
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
        ? theme.bottomNavigationBarTheme.selectedItemColor ??
            theme.colorScheme.primary
        : theme.bottomNavigationBarTheme.unselectedItemColor ??
            theme.colorScheme.onSurfaceVariant;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, color: color, size: 24),
              Text(
                label,
                style: (isSelected
                        ? theme.bottomNavigationBarTheme.selectedLabelStyle
                        : theme.bottomNavigationBarTheme.unselectedLabelStyle)
                    ?.copyWith(color: color, fontSize: 10),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
