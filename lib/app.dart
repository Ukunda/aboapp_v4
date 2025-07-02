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
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:aboapp/core/localization/app_localizations.dart';
import 'package:aboapp/core/localization/l10n_extensions.dart';

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
            onGenerateTitle: (context) => context.l10n.translate('app_title'),
            debugShowCheckedModeBanner: false,
            // VEREINFACHT: Wir verwenden jetzt immer das AppTheme.
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsState.themeMode,
            routerConfig: appRouter.config(),
            locale: settingsState.locale,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('de', 'DE'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
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
