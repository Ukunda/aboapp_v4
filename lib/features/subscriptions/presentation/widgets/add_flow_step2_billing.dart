// lib/features/subscriptions/presentation/widgets/add_flow_step2_billing.dart

import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddFlowStep2Billing extends StatefulWidget {
  final BillingCycle initialCycle;
  final DateTime initialDate;
  final Function(BillingCycle cycle, DateTime date) onChanged;

  const AddFlowStep2Billing({
    super.key,
    required this.initialCycle,
    required this.initialDate,
    required this.onChanged,
  });

  @override
  State<AddFlowStep2Billing> createState() => _AddFlowStep2BillingState();
}

class _AddFlowStep2BillingState extends State<AddFlowStep2Billing> {
  late BillingCycle _selectedCycle;
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedCycle = widget.initialCycle;
    _selectedDate = widget.initialDate;
  }

  void _updateCycle(BillingCycle cycle) {
    setState(() {
      _selectedCycle = cycle;
    });
    widget.onChanged(_selectedCycle, _selectedDate);
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onChanged(_selectedCycle, _selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "And what's the\nbilling rhythm?",
            style: theme.textTheme.displaySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              _buildCycleTile(context, BillingCycle.monthly, "Monthly"),
              const SizedBox(width: 16),
              _buildCycleTile(context, BillingCycle.yearly, "Yearly"),
            ],
          ),
          // Can add more tiles for Weekly, Quarterly etc. here
          const SizedBox(height: 32),
          Text("First payment on", style: theme.textTheme.bodyLarge),
          const SizedBox(height: 8),
          InkWell(
            onTap: () => _selectDate(context),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd MMMM, yyyy').format(_selectedDate),
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const Icon(Icons.calendar_today_rounded),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCycleTile(
      BuildContext context, BillingCycle cycle, String label) {
    final theme = Theme.of(context);
    final isSelected = _selectedCycle == cycle;
    return Expanded(
      child: InkWell(
        onTap: () => _updateCycle(cycle),
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 24),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.onSurface
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Center(
            child: Text(
              label,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: isSelected
                    ? theme.colorScheme.surface
                    : theme.colorScheme.onSurface,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
