// lib/core/routing/app_router.dart

import 'package:aboapp/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/screens/add_edit_subscription_screen.dart';
import 'package:aboapp/features/subscriptions/presentation/screens/add_subscription_flow_screen.dart';
import 'package:aboapp/main_container_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String home = '/home';
  static const String statistics = '/statistics';
  static const String settings = '/settings';
  static const String addSubscription = 'add';
  static const String editSubscription = 'edit/:id';
}

@singleton
class AppRouter {
  final SharedPreferences _sharedPreferences;

  AppRouter(this._sharedPreferences);

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

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
          builder: (context, state, child) {
            return MainContainerScreen(location: state.uri.toString());
          },
          routes: [
            GoRoute(
              path: AppRoutes.home,
              name: AppRoutes.home,
              builder: (context, state) => const SizedBox.shrink(),
              routes: [
                _buildModalSubRoute(AppRoutes.addSubscription,
                    (context, state) => const AddSubscriptionFlowScreen()),
                _buildModalSubRoute(AppRoutes.editSubscription,
                    (context, state) {
                  final subscription = state.extra as SubscriptionEntity?;
                  final subscriptionId = state.pathParameters['id'];
                  // TODO: The edit screen also needs to be redesigned later. For now, it uses the old one.
                  return AddEditSubscriptionScreen(
                    subscriptionId: subscriptionId,
                    subscription: subscription,
                  );
                }),
              ],
            ),
            GoRoute(
              path: AppRoutes.statistics,
              name: AppRoutes.statistics,
              builder: (context, state) => const SizedBox.shrink(),
            ),
            GoRoute(
              path: AppRoutes.settings,
              name: AppRoutes.settings,
              builder: (context, state) => const SizedBox.shrink(),
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) => Scaffold(
        appBar: AppBar(title: const Text('Page Not Found')),
        body: Center(child: Text('Error: \n${state.error}')),
      ),
    );
  }

  static GoRoute _buildModalSubRoute(
      String path, Widget Function(BuildContext, GoRouterState) builder) {
    return GoRoute(
      path: path,
      name: path,
      parentNavigatorKey: _rootNavigatorKey,
      pageBuilder: (context, state) => MaterialPage(
        child: builder(context, state),
        fullscreenDialog: true, // This makes it slide up on mobile
      ),
    );
  }
}
