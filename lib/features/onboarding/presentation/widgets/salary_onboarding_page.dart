// lib/features/onboarding/presentation/widgets/salary_onboarding_page.dart
import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aboapp/core/utils/haptic_feedback.dart' as app_haptics;
import 'package:aboapp/core/localization/l10n_extensions.dart';

class SalaryOnboardingPage extends StatefulWidget {
  const SalaryOnboardingPage({super.key});

  @override
  State<SalaryOnboardingPage> createState() => SalaryOnboardingPageState();
}

class SalaryOnboardingPageState extends State<SalaryOnboardingPage> {
  final _salaryController = TextEditingController();
  SalaryCycle _salaryCycle = SalaryCycle.monthly;
  bool _hasThirteenthSalary = false;

  Future<void> saveSettings() async {
    final salaryText = _salaryController.text.trim().replaceAll(',', '.');
    final salary = double.tryParse(salaryText);

    if (salary != null && salary > 0) {
      await context.read<SettingsCubit>().updateSalarySettings(
            salary: salary,
            salaryCycle: _salaryCycle,
            hasThirteenthSalary: _hasThirteenthSalary,
          );
    }
  }

  @override
  void dispose() {
    _salaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // FIX: Wrap the Column in a SingleChildScrollView to prevent overflow
    // and allow scrolling when the keyboard is displayed.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.insights_rounded, size: 80, color: Colors.blue.shade600),
            const SizedBox(height: 24),
            Text(
              context.l10n.onboarding_salary_optional_title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              context.l10n.onboarding_salary_optional_desc,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _salaryController,
              decoration: InputDecoration(
                labelText:
                    context.l10n.settings_salary_amount_label,
                hintText: context.l10n.onboarding_salary_hint,
                prefixIcon: const Icon(Icons.attach_money_rounded),
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d,.]'))
              ],
            ),
            const SizedBox(height: 16),
            SegmentedButton<SalaryCycle>(
              segments: [
                ButtonSegment(
                    value: SalaryCycle.monthly,
                    label:
                        Text(context.l10n.billing_cycle_monthly),
                    icon: const Icon(Icons.calendar_view_month)),
                ButtonSegment(
                    value: SalaryCycle.yearly,
                    label: Text(context.l10n.billing_cycle_yearly),
                    icon: const Icon(Icons.calendar_today)),
              ],
              selected: {_salaryCycle},
              onSelectionChanged: (newSelection) {
                app_haptics.HapticFeedback.selectionClick();
                setState(() {
                  _salaryCycle = newSelection.first;
                });
              },
              style: SegmentedButton.styleFrom(
                selectedForegroundColor: theme.colorScheme.onPrimary,
                selectedBackgroundColor: theme.colorScheme.primary,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
              ),
            ),
            const SizedBox(height: 8),
            if (_salaryCycle == SalaryCycle.monthly)
              SwitchListTile.adaptive(
                title: Text(
                    context.l10n.settings_salary_13th_checkbox),
                value: _hasThirteenthSalary,
                onChanged: (value) {
                  app_haptics.HapticFeedback.lightImpact();
                  setState(() {
                    _hasThirteenthSalary = value;
                  });
                },
                contentPadding: EdgeInsets.zero,
                activeColor: theme.colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}
