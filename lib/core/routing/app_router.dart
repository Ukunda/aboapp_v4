import 'package:aboapp/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:aboapp/features/settings/presentation/screens/settings_screen.dart';
import 'package:aboapp/features/statistics/presentation/screens/statistics_screen.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/screens/add_edit_subscription_screen.dart';
import 'package:aboapp/features/subscriptions/presentation/screens/home_screen.dart';
import 'package:aboapp/main_container_screen.dart'; // Your screen that holds PageView and BottomNav/Indicator
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Part for GoRouterBuilder (if using type-safe routes later)
// part 'app_router.g.dart'; // Run build_runner if you create this

// Define route paths as constants for easy reference and to avoid typos
abstract class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String home = '/home'; // Base for main content
  static const String subscriptions = 'subscriptions'; // Relative to home or as top-level
  static const String statistics = 'statistics';   // Relative to home
  static const String settings = 'settings';     // Relative to home
  static const String addSubscription = 'add'; // Relative to subscriptions
  static const String editSubscription = 'edit/:id'; // Relative to subscriptions, with ID param
}

@singleton // Register AppRouter with GetIt
class AppRouter {
  final SharedPreferences _sharedPreferences; // To check for onboarding status

  AppRouter(this._sharedPreferences);

  // ShellRoute for persistent navigation (like BottomNavigationBar)
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'ShellNavigator');


  GoRouter config() {
    final bool onboardingComplete = _sharedPreferences.getBool('onboarding_complete') ?? false;

    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: onboardingComplete ? AppRoutes.home : AppRoutes.onboarding,
      debugLogDiagnostics: true, // Helpful for debugging routes
      routes: [
        GoRoute(
          path: AppRoutes.onboarding,
          name: AppRoutes.onboarding,
          builder: (context, state) => const OnboardingScreen(),
        ),
        // ShellRoute for main app sections with persistent navigation
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            // MainContainerScreen will contain the PageView and BottomAppBar/Indicator
            return MainContainerScreen(location: state.matchedLocation, child: child);
          },
          routes: [
            GoRoute(
              path: AppRoutes.home, // This will be the base for the shell
              name: AppRoutes.home, // Can also be a more generic name like 'main'
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeScreen(), // Default screen for the shell
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.subscriptions, // Example: /home/subscriptions
                  name: AppRoutes.subscriptions,
                   parentNavigatorKey: _rootNavigatorKey, // Use root if you want it to cover the shell
                  builder: (context, state) => const HomeScreen(), // Or a dedicated SubscriptionsScreen if different from Home
                ),
                GoRoute(
                  path: AppRoutes.addSubscription, // Example: /home/subscriptions/add
                  name: AppRoutes.addSubscription,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const AddEditSubscriptionScreen(),
                ),
                GoRoute(
                  path: AppRoutes.editSubscription, // Example: /home/subscriptions/edit/:id
                  name: AppRoutes.editSubscription,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final subscription = state.extra as SubscriptionEntity?;
                    final subscriptionId = state.pathParameters['id'];
                    // In a real app, you'd fetch the subscription by ID if not passed in extra
                    // For this refactor, assuming it might be passed via `extra` or fetched in the screen
                    return AddEditSubscriptionScreen(
                      subscriptionId: subscriptionId,
                      subscription: subscription,
                    );
                  },
                ),
                 GoRoute(
                  path: AppRoutes.statistics, // Example: /home/statistics
                  name: AppRoutes.statistics,
                  // parentNavigatorKey: _shellNavigatorKey, // Stays within shell
                  pageBuilder: (context, state) => const NoTransitionPage(
                     child: StatisticsScreen(),
                  )
                ),
                GoRoute(
                  path: AppRoutes.settings, // Example: /home/settings
                  name: AppRoutes.settings,
                  // parentNavigatorKey: _shellNavigatorKey, // Stays within shell
                   pageBuilder: (context, state) => const NoTransitionPage(
                     child: SettingsScreen(),
                  )
                ),
              ]
            ),
          ],
        ),
        // Add other top-level routes here if needed (e.g., login, profile outside the main shell)
      ],
      // Optional: Error handler for unknown routes
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Page Not Found')),
        body: Center(child: Text('Error: ${state.error}')),
      ),
    );
  }
}