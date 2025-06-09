// lib/core/routing/app_router.dart

import 'package:aboapp/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:aboapp/features/settings/presentation/cubit/screens/settings_screen.dart';
import 'package:aboapp/features/statistics/presentation/screens/statistics_screen.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/screens/add_edit_subscription_screen.dart';
import 'package:aboapp/features/subscriptions/presentation/screens/home_screen.dart';
import 'package:aboapp/main_container_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String subscriptions = 'subscriptions';
  static const String statistics = 'statistics';
  static const String settings = 'settings';
  static const String addSubscription = 'add';
  static const String editSubscription = 'edit/:id';
}

@singleton
class AppRouter {
  final SharedPreferences _sharedPreferences;

  AppRouter(this._sharedPreferences);

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'ShellNavigator');

  GoRouter config() {
    final bool onboardingComplete =
        _sharedPreferences.getBool('onboarding_complete') ?? false;

    return GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation:
          onboardingComplete ? AppRoutes.home : AppRoutes.onboarding,
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: AppRoutes.onboarding,
          name: AppRoutes.onboarding,
          builder: (context, state) => const OnboardingScreen(),
        ),
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            // The providers are now at the root of the app in app.dart.
            // This builder just needs to return the shell UI.
            return MainContainerScreen(
                location: state.matchedLocation, child: child);
          },
          routes: [
            GoRoute(
              path: AppRoutes.home,
              name: AppRoutes.home,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: HomeScreen(),
              ),
              routes: [
                GoRoute(
                  path: AppRoutes.subscriptions,
                  name: AppRoutes.subscriptions,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) => const HomeScreen(),
                ),
                GoRoute(
                  path: AppRoutes.addSubscription,
                  name: AppRoutes.addSubscription,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) =>
                      const AddEditSubscriptionScreen(),
                ),
                GoRoute(
                  path: AppRoutes.editSubscription,
                  name: AppRoutes.editSubscription,
                  parentNavigatorKey: _rootNavigatorKey,
                  builder: (context, state) {
                    final subscription = state.extra as SubscriptionEntity?;
                    final subscriptionId = state.pathParameters['id'];
                    return AddEditSubscriptionScreen(
                      subscriptionId: subscriptionId,
                      subscription: subscription,
                    );
                  },
                ),
                GoRoute(
                    path: AppRoutes.statistics,
                    name: AppRoutes.statistics,
                    pageBuilder: (context, state) => const NoTransitionPage(
                          child: StatisticsScreen(),
                        )),
                GoRoute(
                    path: AppRoutes.settings,
                    name: AppRoutes.settings,
                    pageBuilder: (context, state) => const NoTransitionPage(
                          child: SettingsScreen(),
                        )),
              ],
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Page Not Found')),
        body: Center(child: Text('Error: ${state.error}')),
      ),
    );
  }
}
