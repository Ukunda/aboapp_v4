// lib/app.dart

import 'package:aboapp/core/di/injection.dart';
import 'package:aboapp/core/routing/app_router.dart';
// VEREINFACHT: Nur noch ein Theme importieren
import 'package:aboapp/core/theme/app_theme.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/features/statistics/presentation/cubit/statistics_cubit.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_suggestion_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aboapp/l10n/generated/app_localizations.dart';

class AboApp extends StatelessWidget {
  const AboApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = getIt<AppRouter>();

    return MultiBlocProvider(
      providers: [
        BlocProvider<SettingsCubit>(
          create: (context) => getIt<SettingsCubit>()..loadSettings(),
        ),
        BlocProvider<SubscriptionCubit>(
          create: (context) => getIt<SubscriptionCubit>()..loadSubscriptions(),
        ),
        BlocProvider<StatisticsCubit>(
          create: (context) => getIt<StatisticsCubit>(),
        ),
        BlocProvider<SubscriptionSuggestionCubit>(
          create: (context) => getIt<SubscriptionSuggestionCubit>(),
        ),
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          return MaterialApp.router(
            onGenerateTitle: (context) => AppLocalizations.of(context).app_title,
            debugShowCheckedModeBanner: false,
            // VEREINFACHT: Wir verwenden jetzt immer das AppTheme.
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsState.themeMode,
            routerConfig: appRouter.config(),
            locale: settingsState.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
          );
        },
      ),
    );
  }
}
