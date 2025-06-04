import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  String _getThemeModeDisplayName(BuildContext context, ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return 'System Default'; 
      case ThemeMode.light:
        return 'Light'; 
      case ThemeMode.dark:
        return 'Dark'; 
    }
  }

  String _getLocaleDisplayName(BuildContext context, Locale locale) {
    if (locale.languageCode == 'en') {
      return 'English'; 
    } else if (locale.languageCode == 'de') {
      return 'Deutsch (German)'; 
    }
    return locale.toLanguageTag(); 
  }
  
  static const Map<String, String> _supportedCurrencies = {
    'USD': 'USD - United States Dollar (\$)',
    'EUR': 'EUR - Euro (€)',
    'GBP': 'GBP - British Pound (£)',
    'JPY': 'JPY - Japanese Yen (¥)',
    'CHF': 'CHF - Swiss Franc (CHF)',
  };


  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context); // Unused variable

    return Scaffold(
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state.isLoading && state.themeMode == ThemeMode.system && state.locale.languageCode == 'en') { 
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state.error != null) {
            return Center(child: Text('Error loading settings: ${state.error}')); // TODO: Localize
          }

          return ListView(
            padding: const EdgeInsets.all(8.0),
            children: <Widget>[
              _buildSectionHeader(context, 'Appearance'), 
              ListTile(
                leading: const Icon(Icons.brightness_6_rounded),
                title: const Text('Theme'), 
                subtitle: Text(_getThemeModeDisplayName(context, state.themeMode)),
                onTap: () => _showThemeModeDialog(context, state.themeMode),
              ),
              const Divider(),
              _buildSectionHeader(context, 'Regional'), 
              ListTile(
                leading: const Icon(Icons.language_rounded),
                title: const Text('Language'), 
                subtitle: Text(_getLocaleDisplayName(context, state.locale)),
                onTap: () => _showLocaleDialog(context, state.locale),
              ),
              ListTile(
                leading: const Icon(Icons.attach_money_rounded),
                title: const Text('Currency'), 
                subtitle: Text(_supportedCurrencies[state.currencyCode] ?? state.currencyCode),
                onTap: () => _showCurrencyDialog(context, state.currencyCode),
              ),
              const Divider(),
              _buildSectionHeader(context, 'About'), 
              ListTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: const Text('About AboApp'), 
                subtitle: const Text('Version 3.0.0 - Refactored'), 
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('About AboApp'), 
                      content: const Text('Subscription management made easy.\nVersion 3.0.0'), 
                      actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: const Text('Close'))], 
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
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Select Theme'), 
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
              child: const Text('Cancel'), 
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
          ],
        );
      },
    );
  }

  void _showLocaleDialog(BuildContext context, Locale currentLocale) {
    const List<Locale> supportedLocales = [
      Locale('en', 'US'),
      Locale('de', 'DE'),
    ];

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Select Language'), 
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
              child: const Text('Cancel'), 
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
          ],
        );
      },
    );
  }
  
  void _showCurrencyDialog(BuildContext context, String currentCurrencyCode) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Select Currency'), 
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: _supportedCurrencies.entries.map((entry) {
                return RadioListTile<String>(
                  title: Text(entry.value), 
                  value: entry.key, 
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
              child: const Text('Cancel'), 
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
          ],
        );
      },
    );
  }
}