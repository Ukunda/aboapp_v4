import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:aboapp/core/localization/app_localizations.dart'; // When implemented

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // Helper to get display name for ThemeMode
  String _getThemeModeDisplayName(BuildContext context, ThemeMode themeMode) {
    // final localizations = AppLocalizations.of(context);
    switch (themeMode) {
      case ThemeMode.system:
        return 'System Default'; // localizations.translate('theme_system');
      case ThemeMode.light:
        return 'Light'; // localizations.translate('theme_light');
      case ThemeMode.dark:
        return 'Dark'; // localizations.translate('theme_dark');
    }
  }

  // Helper to get display name for Locale
  String _getLocaleDisplayName(BuildContext context, Locale locale) {
    // final localizations = AppLocalizations.of(context);
    // This is a simplified version. For a full list, you might need a map or intl package capabilities.
    if (locale.languageCode == 'en') {
      return 'English'; // localizations.translate('language_english');
    } else if (locale.languageCode == 'de') {
      return 'Deutsch (German)'; // localizations.translate('language_german');
    }
    return locale.toLanguageTag(); // Fallback
  }
  
  // Supported currencies (example)
  static const Map<String, String> _supportedCurrencies = {
    'USD': 'USD - United States Dollar (\$)',
    'EUR': 'EUR - Euro (€)',
    'GBP': 'GBP - British Pound (£)',
    'JPY': 'JPY - Japanese Yen (¥)',
    'CHF': 'CHF - Swiss Franc (CHF)',
    // Add more as needed
  };


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final localizations = AppLocalizations.of(context);

    return Scaffold(
      // AppBar is typically part of the MainContainerScreen for shell routes
      // If this screen can be pushed independently, it might need its own AppBar.
      // For now, assuming it's part of the shell.
      // appBar: AppBar(
      //   title: Text('Settings'), // localizations.translate('settings_title')),
      // ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state.isLoading && state.themeMode == ThemeMode.system && state.locale.languageCode == 'en') { // Check if it's truly initial load
            // This condition might be too simple if initial state matches defaults
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state.error != null) {
            return Center(child: Text('Error loading settings: ${state.error}')); // TODO: Localize
          }

          return ListView(
            padding: const EdgeInsets.all(8.0),
            children: <Widget>[
              _buildSectionHeader(context, 'Appearance'), // localizations.translate('appearance')),
              ListTile(
                leading: const Icon(Icons.brightness_6_rounded),
                title: Text('Theme'), // localizations.translate('theme_setting_title')),
                subtitle: Text(_getThemeModeDisplayName(context, state.themeMode)),
                onTap: () => _showThemeModeDialog(context, state.themeMode),
              ),
              const Divider(),
              _buildSectionHeader(context, 'Regional'), // localizations.translate('regional_settings')),
              ListTile(
                leading: const Icon(Icons.language_rounded),
                title: Text('Language'), // localizations.translate('language_setting_title')),
                subtitle: Text(_getLocaleDisplayName(context, state.locale)),
                onTap: () => _showLocaleDialog(context, state.locale),
              ),
              ListTile(
                leading: const Icon(Icons.attach_money_rounded),
                title: Text('Currency'), // localizations.translate('currency_setting_title')),
                subtitle: Text(_supportedCurrencies[state.currencyCode] ?? state.currencyCode),
                onTap: () => _showCurrencyDialog(context, state.currencyCode),
              ),
              const Divider(),
              _buildSectionHeader(context, 'About'), // localizations.translate('about_section_title')),
              ListTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: Text('About AboApp'), // localizations.translate('about_app_title')),
                // subtitle: Text('Version 3.0.0'), // localizations.translate('app_version', args: {'version': '3.0.0'})),
                subtitle: Text('Version 3.0.0 - Refactored'), // TODO: Get from package_info_plus
                onTap: () {
                  // TODO: Show an About Dialog or navigate to an About Screen
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('About AboApp'), // localizations.translate('about_app_title')),
                      content: Text('Subscription management made easy.\nVersion 3.0.0'), // localizations.translate('app_description_long')),
                      actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text('Close'))], // localizations.translate('close')))],
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0, left: 16.0, right: 16.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  void _showThemeModeDialog(BuildContext context, ThemeMode currentThemeMode) {
    // final localizations = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Select Theme'), // localizations.translate('select_theme_dialog_title')),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: ThemeMode.values.map((themeMode) {
              return RadioListTile<ThemeMode>(
                title: Text(_getThemeModeDisplayName(context, themeMode)),
                value: themeMode,
                groupValue: currentThemeMode,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    context.read<SettingsCubit>().updateThemeMode(value);
                    Navigator.of(dialogContext).pop();
                  }
                },
              );
            }).toList(),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'), // localizations.translate('cancel')),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
          ],
        );
      },
    );
  }

  void _showLocaleDialog(BuildContext context, Locale currentLocale) {
    // final localizations = AppLocalizations.of(context);
    // Define your supported locales here or get them from a config
    final List<Locale> supportedLocales = [
      const Locale('en', 'US'),
      const Locale('de', 'DE'),
    ];

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Select Language'), // localizations.translate('select_language_dialog_title')),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: supportedLocales.length,
              itemBuilder: (BuildContext context, int index) {
                final locale = supportedLocales[index];
                return RadioListTile<Locale>(
                  title: Text(_getLocaleDisplayName(context, locale)),
                  value: locale,
                  groupValue: currentLocale,
                  onChanged: (Locale? value) {
                    if (value != null) {
                      context.read<SettingsCubit>().updateLocale(value);
                      Navigator.of(dialogContext).pop();
                    }
                  },
                );
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'), // localizations.translate('cancel')),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
          ],
        );
      },
    );
  }
  
  void _showCurrencyDialog(BuildContext context, String currentCurrencyCode) {
    // final localizations = AppLocalizations.of(context);
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Select Currency'), // localizations.translate('select_currency_dialog_title')),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: _supportedCurrencies.entries.map((entry) {
                return RadioListTile<String>(
                  title: Text(entry.value), // Display the full name
                  value: entry.key, // Store the code
                  groupValue: currentCurrencyCode,
                  onChanged: (String? value) {
                    if (value != null) {
                      context.read<SettingsCubit>().updateCurrencyCode(value);
                       Navigator.of(dialogContext).pop();
                    }
                  },
                );
              }).toList(),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'), // localizations.translate('cancel')),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
          ],
        );
      },
    );
  }
}