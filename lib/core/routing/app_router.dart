// lib/core/routing/app_router.dart

import 'package:aboapp/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/screens/add_edit_subscription_screen.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';
import 'package:aboapp/main_container_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  AppRouter(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter config() {
    final onboardingComplete =
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
          builder: (_, __) => const OnboardingScreen(),
        ),
        ShellRoute(
          builder: (_, state, child) =>
              MainContainerScreen(location: state.uri.toString()),
          routes: [
            GoRoute(
              path: AppRoutes.home,
              name: AppRoutes.home,
              builder: (_, __) => const SizedBox.shrink(),
              routes: [
                _buildModalSubRoute(
                  AppRoutes.addSubscription,
                  (_, __) => const AddEditSubscriptionScreen(),
                ),
                _buildModalSubRoute(
                  AppRoutes.editSubscription,
                  (context, state) {
                    final extraSub = state.extra as SubscriptionEntity?;
                    final idParam = state.pathParameters['id'];

                    if (extraSub != null) {
                      return AddEditSubscriptionScreen(
                        initialSubscription: extraSub,
                      );
                    }

                    final cubitState = context.read<SubscriptionCubit>().state;

                    return cubitState.maybeWhen(
                      loaded: (allSubscriptions,
                          filteredSubscriptions,
                          currentSortOption,
                          filterCategory,
                          filterBillingCycle,
                          searchTerm) {
                        try {
                          final found = allSubscriptions
                              .firstWhere((s) => s.id == idParam);
                          return AddEditSubscriptionScreen(
                              initialSubscription: found);
                        } catch (_) {
                          return const Scaffold(
                            body: Center(child: Text('Abo nicht gefunden')),
                          );
                        }
                      },
                      loading: () => const Scaffold(
                        body: Center(child: CircularProgressIndicator()),
                      ),
                      error: (message) => Scaffold(
                        body: Center(child: Text('Fehler: $message')),
                      ),
                      orElse: () => const Scaffold(
                        body: Center(child: Text('Unbekannter Status')),
                      ),
                    );
                  },
                ),
              ],
            ),
            GoRoute(
              path: AppRoutes.statistics,
              name: AppRoutes.statistics,
              builder: (_, __) => const SizedBox.shrink(),
            ),
            GoRoute(
              path: AppRoutes.settings,
              name: AppRoutes.settings,
              builder: (_, __) => const SizedBox.shrink(),
            ),
          ],
        ),
      ],
      errorBuilder: (_, state) => Scaffold(
        appBar: AppBar(title: const Text('Seite nicht gefunden')),
        body: Center(child: Text('Error:\n${state.error}')),
      ),
    );
  }

  static GoRoute _buildModalSubRoute(
    String path,
    Widget Function(BuildContext, GoRouterState) builder,
  ) {
    return GoRoute(
      path: path,
      name: path,
      parentNavigatorKey: _rootNavigatorKey,
      builder: builder,
    );
  }
}
