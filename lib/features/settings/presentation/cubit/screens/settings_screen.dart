// lib/features/settings/presentation/cubit/screens/settings_screen.dart

import 'package:aboapp/core/di/injection.dart';
import 'package:aboapp/core/routing/app_router.dart';
import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/core/utils/currency_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:aboapp/core/localization/l10n_extensions.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _salaryController = TextEditingController();
  SalaryCycle? _salaryCycle;
  bool? _hasThirteenthSalary;

  @override
  void initState() {
    super.initState();
    final settingsState = context.read<SettingsCubit>().state;
    _updateLocalState(settingsState);
  }

  void _updateLocalState(SettingsState state) {
    if (state.salary != null) {
      _salaryController.text = state.salary.toString();
    } else {
      _salaryController.clear();
    }
    _salaryCycle = state.salaryCycle;
    _hasThirteenthSalary = state.hasThirteenthSalary;
  }

  @override
  void dispose() {
    _salaryController.dispose();
    super.dispose();
  }

  void _saveSalary() {
    final salary = double.tryParse(_salaryController.text.replaceAll(',', '.'));
    context.read<SettingsCubit>().updateSalarySettings(
          salary: salary,
          salaryCycle: _salaryCycle,
          hasThirteenthSalary: _hasThirteenthSalary,
        );
    FocusScope.of(context).unfocus(); // Close keyboard
  }

  void _showRerunOnboardingDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(context.l10n.translate('settings_rerun_onboarding_title')),
        content: Text(
            context.l10n.translate('settings_rerun_onboarding_message')),
        actions: <Widget>[
          TextButton(
            child: Text(context.l10n.translate('cancel')),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
          TextButton(
            child: Text(
              context.l10n.translate('confirm'),
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),
            onPressed: () async {
              Navigator.of(dialogContext).pop(); // Close the dialog first
              final prefs = getIt<SharedPreferences>();
              await prefs.setBool('onboarding_complete', false);
              if (mounted) {
                // Navigate to the onboarding route, clearing the navigation stack
                context.go(AppRoutes.onboarding);
              }
            },
          ),
        ],
      ),
    );
  }

  String _getThemeModeDisplayName(BuildContext context, ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.system:
        return context.l10n.translate('settings_theme_system');
      case ThemeMode.light:
        return context.l10n.translate('settings_theme_light');
      case ThemeMode.dark:
        return context.l10n.translate('settings_theme_dark');
    }
  }

  String _getLocaleDisplayName(BuildContext context, Locale locale) {
    if (locale.languageCode == 'en')
      return context.l10n.translate('settings_language_english');
    if (locale.languageCode == 'de')
      return context.l10n.translate('settings_language_german');
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
    return BlocListener<SettingsCubit, SettingsState>(
      listener: (context, state) {
        if (mounted) {
          _updateLocalState(state);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.translate('settings_title')),
        ),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state.isLoading && _salaryController.text.isEmpty) { // Show loader only on initial load
              return const Center(child: CircularProgressIndicator.adaptive());
            }
            if (state.error != null) {
              return Center(
                  child: Text('Error loading settings: ${state.error}'));
            }

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                _buildSectionHeader(context, context.l10n.translate('settings_section_appearance')),
                _buildAppearanceSection(context, state),
                const Divider(height: 32),
                _buildSectionHeader(context, context.l10n.translate('settings_section_regional')),
                _buildRegionalSection(context, state),
                const Divider(height: 32),
                _buildSectionHeader(context, context.l10n.translate('settings_section_salary')),
                _buildSalarySection(context, state),
                const Divider(height: 32),
                _buildSectionHeader(context, context.l10n.translate('settings_section_advanced')),
                _buildAdvancedSection(context),
                const Divider(height: 32),
                _buildSectionHeader(context, context.l10n.translate('settings_section_about')),
                _buildAboutSection(context),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppearanceSection(BuildContext context, SettingsState state) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.brightness_6_rounded),
        title: Text(context.l10n.translate('settings_theme_title')),
        subtitle: Text(_getThemeModeDisplayName(context, state.themeMode)),
        onTap: () => _showThemeModeDialog(context, state.themeMode),
      ),
    );
  }

  Widget _buildRegionalSection(BuildContext context, SettingsState state) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.language_rounded),
            title: Text(context.l10n.translate('settings_language_title')),
            subtitle: Text(_getLocaleDisplayName(context, state.locale)),
            onTap: () => _showLocaleDialog(context, state.locale),
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          ListTile(
            leading: const Icon(Icons.attach_money_rounded),
            title: Text(context.l10n.translate('settings_currency_title')),
            subtitle: Text(
                _supportedCurrencies[state.currencyCode] ?? state.currencyCode),
            onTap: () => _showCurrencyDialog(context, state.currencyCode),
          ),
        ],
      ),
    );
  }

  Widget _buildSalarySection(BuildContext context, SettingsState state) {
    final theme = Theme.of(context);
    final currencySymbol =
        CurrencyFormatter.getCurrencySymbol(state.currencyCode);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.l10n.translate('settings_salary_title'),
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text(
              context.l10n.translate('settings_salary_description'),
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _salaryController,
              decoration: InputDecoration(
                labelText: context.l10n.translate('settings_salary_amount_label'),
                prefixText: "$currencySymbol ",
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d,.]'))
              ],
              onEditingComplete: _saveSalary,
            ),
            const SizedBox(height: 16),
            SegmentedButton<SalaryCycle>(
              segments: [
                ButtonSegment(
                    value: SalaryCycle.monthly,
                    label: Text(context.l10n.translate('billing_cycle_monthly'))),
                ButtonSegment(
                    value: SalaryCycle.yearly,
                    label: Text(context.l10n.translate('billing_cycle_yearly'))),
              ],
              selected: {_salaryCycle ?? SalaryCycle.monthly},
              onSelectionChanged: (newSelection) {
                setState(() => _salaryCycle = newSelection.first);
                _saveSalary();
              },
            ),
            if (_salaryCycle == SalaryCycle.monthly)
              SwitchListTile.adaptive(
                title: Text(context.l10n.translate('settings_salary_13th_checkbox')),
                value: _hasThirteenthSalary ?? false,
                onChanged: (value) {
                  setState(() => _hasThirteenthSalary = value);
                  _saveSalary();
                },
                contentPadding: EdgeInsets.zero,
              ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildAdvancedSection(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      color: theme.colorScheme.errorContainer.withAlpha(77), // ~30% opacity
      child: ListTile(
        leading: Icon(Icons.replay_circle_filled_rounded,
            color: theme.colorScheme.error),
        title: Text(
            context.l10n.translate('settings_rerun_onboarding_title'),
            style: TextStyle(color: theme.colorScheme.onErrorContainer)),
        subtitle: Text(
            context.l10n.translate('settings_rerun_onboarding_subtitle'),
            style: TextStyle(
                color: theme.colorScheme.onErrorContainer.withAlpha(204))), // ~80% opacity
        onTap: _showRerunOnboardingDialog,
      ),
    );
  }

  Widget _buildAboutSection(BuildContext context) {
    return Card(
      child: ListTile(
        leading: const Icon(Icons.info_outline_rounded),
        title: Text(context.l10n.translate('settings_about_app_title')),
        subtitle:
            Text(context.l10n.translate('settings_app_version', args: {'version': '4.0.0'})),
        onTap: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(context.l10n.translate('settings_about_app_title')),
              content: Text(
                '${context.l10n.translate('settings_app_description_long')}\n${context.l10n.translate('settings_app_version', args: {'version': '4.0.0'})}',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: Text(context.l10n.translate('close')),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8
            ),
      ),
    );
  }

  void _showThemeModeDialog(BuildContext context, ThemeMode currentThemeMode) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.translate('settings_dialog_select_theme_title')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ThemeMode.values.map((themeMode) {
            return RadioListTile<ThemeMode>(
              title: Text(_getThemeModeDisplayName(context, themeMode)),
              value: themeMode,
              groupValue: currentThemeMode,
              onChanged: (value) {
                if (value != null) {
                  context.read<SettingsCubit>().updateThemeMode(value);
                  Navigator.of(ctx).pop();
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showLocaleDialog(BuildContext context, Locale currentLocale) {
    const supportedLocales = [Locale('en', 'US'), Locale('de', 'DE')];
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.translate('settings_dialog_select_language_title')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: supportedLocales.map((locale) {
            return RadioListTile<Locale>(
              title: Text(_getLocaleDisplayName(context, locale)),
              value: locale,
              groupValue: currentLocale,
              onChanged: (value) {
                if (value != null) {
                  context.read<SettingsCubit>().updateLocale(value);
                  Navigator.of(ctx).pop();
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showCurrencyDialog(BuildContext context, String currentCurrencyCode) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.l10n.translate('settings_dialog_select_currency_title')),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            shrinkWrap: true,
            children: _supportedCurrencies.entries.map((entry) {
              return RadioListTile<String>(
                title: Text(entry.value),
                value: entry.key,
                groupValue: currentCurrencyCode,
                onChanged: (value) {
                  if (value != null) {
                    // CORRECTION: Typo `SettingsCTubit` fixed to `SettingsCubit`
                    context.read<SettingsCubit>().updateCurrencyCode(value);
                    Navigator.of(ctx).pop();
                  }
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}