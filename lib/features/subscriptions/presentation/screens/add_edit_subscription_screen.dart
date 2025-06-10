// lib/features/subscriptions/presentation/screens/add_edit_subscription_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';
import 'package:aboapp/features/subscriptions/presentation/widgets/subscription_card_widget.dart';

class AddEditSubscriptionScreen extends StatefulWidget {
  final SubscriptionEntity? initialSubscription;

  const AddEditSubscriptionScreen({
    super.key,
    this.initialSubscription,
  });

  @override
  State<AddEditSubscriptionScreen> createState() =>
      _AddEditSubscriptionScreenState();
}

class _AddEditSubscriptionScreenState extends State<AddEditSubscriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();

  late SubscriptionCategory _selectedCategory;
  late BillingCycle _selectedCycle;
  late DateTime _nextBillingDate;

  bool get _isEditing => widget.initialSubscription != null;

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      final s = widget.initialSubscription!;
      _nameController.text = s.name;
      _priceController.text = s.price.toString().replaceAll('.', ',');
      _notesController.text = s.notes ?? '';
      _selectedCategory = s.category;
      _selectedCycle = s.billingCycle;
      _nextBillingDate = s.nextBillingDate;
    } else {
      _selectedCategory = SubscriptionCategory.streaming;
      _selectedCycle = BillingCycle.monthly;
      _nextBillingDate = DateTime.now();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final price =
        double.tryParse(_priceController.text.trim().replaceAll(',', '.')) ??
            0.0;

    final newSubscription = SubscriptionEntity(
      id: widget.initialSubscription?.id ?? '', // Wird im Cubit neu gesetzt
      name: _nameController.text.trim(),
      price: price,
      category: _selectedCategory,
      billingCycle: _selectedCycle,
      nextBillingDate: _nextBillingDate,
      notes: _notesController.text.trim().isEmpty
          ? null
          : _notesController.text.trim(),
    );

    final cubit = context.read<SubscriptionCubit>();
    if (_isEditing) {
      cubit.updateSubscription(newSubscription);
    } else {
      cubit.addSubscription(newSubscription);
    }

    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  Future<void> _pickNextBillingDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _nextBillingDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (pickedDate != null) {
      setState(() {
        _nextBillingDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Abo bearbeiten' : 'Abo hinzufügen'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                children: [
                  _buildSectionTitle(context, 'Kategorie'),
                  _buildCategorySelector(theme, isDarkMode),
                  const SizedBox(height: 24),
                  _buildSectionTitle(context, 'Details'),
                  _buildTextFormField(
                    controller: _nameController,
                    labelText: 'Abo-Name',
                    icon: Icons.subscriptions_outlined,
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Name ist ein Pflichtfeld'
                        : null,
                  ),
                  const SizedBox(height: 16),
                  _buildTextFormField(
                    controller: _priceController,
                    labelText: 'Preis',
                    icon: Icons.euro_symbol_rounded,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Preis ist ein Pflichtfeld';
                      }
                      final val =
                          double.tryParse(v.trim().replaceAll(',', '.'));
                      if (val == null || val < 0) {
                        return 'Ungültiger Betrag';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(child: _buildBillingCycleDropdown(theme)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildNextBillingDatePicker(theme)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildTextFormField(
                    controller: _notesController,
                    labelText: 'Notizen (optional)',
                    icon: Icons.note_alt_outlined,
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
            _buildSaveButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCategorySelector(ThemeData theme, bool isDarkMode) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: SubscriptionCategory.values.map((category) {
        final isSelected = _selectedCategory == category;
        final color = category.categoryDisplayIconColor(theme);
        return ChoiceChip(
          label: Text(category.displayName),
          avatar: Icon(
            category.displayIcon,
            size: 18,
            color: isSelected
                ? (ThemeData.estimateBrightnessForColor(color) ==
                        Brightness.dark
                    ? Colors.white
                    : Colors.black)
                : theme.colorScheme.onSurfaceVariant,
          ),
          selected: isSelected,
          onSelected: (_) => setState(() => _selectedCategory = category),
          backgroundColor: theme.colorScheme.surfaceContainerHighest,
          selectedColor: color,
          showCheckmark: false,
          labelStyle: TextStyle(
            color: isSelected
                ? (ThemeData.estimateBrightnessForColor(color) ==
                        Brightness.dark
                    ? Colors.white
                    : Colors.black)
                : theme.colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
          side: BorderSide(color: Colors.transparent),
        );
      }).toList(),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Theme.of(context).colorScheme.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        filled: true,
      ),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      textInputAction:
          maxLines > 1 ? TextInputAction.newline : TextInputAction.next,
    );
  }

  Widget _buildBillingCycleDropdown(ThemeData theme) {
    return DropdownButtonFormField<BillingCycle>(
      value: _selectedCycle,
      decoration: InputDecoration(
        labelText: 'Intervall',
        prefixIcon: Icon(Icons.calendar_today_outlined,
            color: theme.colorScheme.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide.none,
        ),
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        filled: true,
      ),
      items: BillingCycle.values
          .where((c) => c != BillingCycle.custom)
          .map((c) => DropdownMenuItem(
                value: c,
                child: Text(c.displayName),
              ))
          .toList(),
      onChanged: (v) => setState(() => _selectedCycle = v ?? _selectedCycle),
    );
  }

  Widget _buildNextBillingDatePicker(ThemeData theme) {
    return InkWell(
      onTap: _pickNextBillingDate,
      borderRadius: BorderRadius.circular(12.0),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Nächste Zahlung',
          prefixIcon: Icon(Icons.event_available_outlined,
              color: theme.colorScheme.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          fillColor: Theme.of(context).colorScheme.surfaceContainerHighest,
          filled: true,
        ),
        child: Text(
          DateFormat('dd.MM.yyyy').format(_nextBillingDate),
          style: theme.textTheme.bodyLarge,
        ),
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: Icon(_isEditing
              ? Icons.check_circle_outline
              : Icons.add_circle_outline),
          label: Text(_isEditing ? 'Änderungen speichern' : 'Abo hinzufügen'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: Theme.of(context)
                .textTheme
                .titleMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: _save,
        ),
      ),
    );
  }
}

// Kleine Erweiterung für die Anzeige der BillingCycle-Namen
extension on BillingCycle {
  String get displayName {
    switch (this) {
      case BillingCycle.weekly:
        return 'Wöchentlich';
      case BillingCycle.monthly:
        return 'Monatlich';
      case BillingCycle.quarterly:
        return 'Quartalsweise';
      case BillingCycle.biAnnual:
        return 'Halbjährlich';
      case BillingCycle.yearly:
        return 'Jährlich';
      case BillingCycle.custom:
        return 'Benutzerdef.';
    }
  }
}
