// lib/features/onboarding/presentation/widgets/salary_onboarding_page.dart
import 'package:aboapp/features/settings/domain/entities/settings_entity.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:aboapp/core/utils/haptic_feedback.dart' as app_haptics;

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
              "Optional: Salary Insights",
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              "Enter your salary to see what percentage of it goes to subscriptions. This is optional and stored only on your device.",
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge
                  ?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            const SizedBox(height: 32),
            TextFormField(
              controller: _salaryController,
              decoration: InputDecoration(
                labelText: "Salary Amount",
                hintText: "e.g., 5000",
                prefixIcon: const Icon(Icons.attach_money_rounded),
              ),
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d,.]'))
              ],
            ),
            const SizedBox(height: 16),
            SegmentedButton<SalaryCycle>(
              segments: const [
                ButtonSegment(
                    value: SalaryCycle.monthly,
                    label: Text("Monthly"),
                    icon: Icon(Icons.calendar_view_month)),
                ButtonSegment(
                    value: SalaryCycle.yearly,
                    label: Text("Yearly"),
                    icon: Icon(Icons.calendar_today)),
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
                title: const Text("I receive a 13th salary"),
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