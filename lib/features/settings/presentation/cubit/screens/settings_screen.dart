import 'package:aboapp/core/localization/app_localizations.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  String _getThemeModeDisplayName(BuildContext context, ThemeMode themeMode) {
    final localizations = AppLocalizations.of(context)!;
    switch (themeMode) {
      case ThemeMode.system:
        return localizations.translate('settings_theme_system');
      case ThemeMode.light:
        return localizations.translate('settings_theme_light');
      case ThemeMode.dark:
        return localizations.translate('settings_theme_dark');
    }
  }

  String _getLocaleDisplayName(BuildContext context, Locale locale) {
    final localizations = AppLocalizations.of(context)!;
    if (locale.languageCode == 'en') {
      return localizations.translate('settings_language_english');
    } else if (locale.languageCode == 'de') {
      return localizations.translate('settings_language_german');
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
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          if (state.isLoading && state.themeMode == ThemeMode.system && state.locale.languageCode == 'en') { 
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state.error != null) {
            return Center(child: Text('${localizations.translate('error_occurred')}: ${state.error}'));
          }

          return ListView(
            padding: const EdgeInsets.all(8.0),
            children: <Widget>[
              _buildSectionHeader(context, localizations.translate('settings_section_appearance')),
              ListTile(
                leading: const Icon(Icons.brightness_6_rounded),
                title: Text(localizations.translate('settings_theme_title')),
                subtitle: Text(_getThemeModeDisplayName(context, state.themeMode)),
                onTap: () => _showThemeModeDialog(context, state.themeMode),
              ),
              const Divider(),
              _buildSectionHeader(context, localizations.translate('settings_section_regional')),
              ListTile(
                leading: const Icon(Icons.language_rounded),
                title: Text(localizations.translate('settings_language_title')),
                subtitle: Text(_getLocaleDisplayName(context, state.locale)),
                onTap: () => _showLocaleDialog(context, state.locale),
              ),
              ListTile(
                leading: const Icon(Icons.attach_money_rounded),
                title: Text(localizations.translate('settings_currency_title')),
                subtitle: Text(_supportedCurrencies[state.currencyCode] ?? state.currencyCode),
                onTap: () => _showCurrencyDialog(context, state.currencyCode),
              ),
              const Divider(),
              _buildSectionHeader(context, localizations.translate('settings_section_about')),
              ListTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: Text(localizations.translate('settings_about_app_title')),
                subtitle: Text(localizations.translate('settings_app_version', args: {'version': '3.0.0'})),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text(localizations.translate('settings_about_app_title')),
                      content: Text(localizations.translate('settings_app_description_long')),
                      actions: [TextButton(onPressed: () => Navigator.of(ctx).pop(), child: Text(localizations.translate('close')))],
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
    final localizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(localizations.translate('settings_dialog_select_theme_title')),
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
              child: Text(localizations.translate('cancel')),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
          ],
        );
      },
    );
  }

  void _showLocaleDialog(BuildContext context, Locale currentLocale) {
    final localizations = AppLocalizations.of(context)!;
    const List<Locale> supportedLocales = [
      Locale('en', 'US'),
      Locale('de', 'DE'),
    ];

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(localizations.translate('settings_dialog_select_language_title')),
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
              child: Text(localizations.translate('cancel')),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
          ],
        );
      },
    );
  }
  
  void _showCurrencyDialog(BuildContext context, String currentCurrencyCode) {
    final localizations = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(localizations.translate('settings_dialog_select_currency_title')),
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
              child: Text(localizations.translate('cancel')),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
          ],
        );
      },
    );
  }
}