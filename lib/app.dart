import 'package:aboapp/core/di/injection.dart';
import 'package:aboapp/core/routing/app_router.dart';
import 'package:aboapp/core/theme/app_theme.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:aboapp/core/localization/app_localizations.dart'; // Import your AppLocalizations class

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
        // ... other global providers
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          return MaterialApp.router(
            title: 'AboApp V3', // This could also be localized if needed early
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: settingsState.themeMode,
            routerConfig: appRouter.config(),

            // Localization Setup
            locale: settingsState.locale, // Driven by SettingsCubit
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('de', 'DE'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate, // Your custom delegate
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            // Optional: Define how to resolve the locale if the device locale isn't exactly matched.
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode) {
                  // If country code is also important, add: && supportedLocale.countryCode == locale?.countryCode
                  return supportedLocale;
                }
              }
              // If no exact match is found, fall back to the first supported locale (e.g., English)
              return supportedLocales.first;
            },
          );
        },
      ),
    );
  }
}