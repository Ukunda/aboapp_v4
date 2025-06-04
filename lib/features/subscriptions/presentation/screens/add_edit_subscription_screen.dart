// import 'package:aboapp/core/routing/app_router.dart'; // Unused import
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';
import 'package:aboapp/features/subscriptions/presentation/widgets/subscription_card_widget.dart'; // For CategoryDisplayHelpers
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:aboapp/core/utils/haptic_feedback.dart' as app_haptics; 

class AddEditSubscriptionScreen extends StatefulWidget {
  final SubscriptionEntity? subscription; 
  final String? subscriptionId; 

  const AddEditSubscriptionScreen({
    super.key,
    this.subscription,
    this.subscriptionId,
  });

  @override
  State<AddEditSubscriptionScreen> createState() => _AddEditSubscriptionScreenState();
}

class _AddEditSubscriptionScreenState extends State<AddEditSubscriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _uuid = const Uuid(); 

  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _descriptionController;
  late TextEditingController _logoUrlController;
  late TextEditingController _notesController;
  late TextEditingController _customCycleDaysController;

  late String _currentId;
  SubscriptionCategory _category = SubscriptionCategory.other;
  BillingCycle _billingCycle = BillingCycle.monthly;
  DateTime _nextBillingDate = DateTime.now().add(const Duration(days: 30));
  DateTime? _startDate;
  Color? _selectedColor;
  bool _isActive = true;
  bool _notificationsEnabled = true;
  int _notificationDaysBefore = 7;
  bool _isInTrial = false;
  DateTime? _trialEndDate;

  bool get _isEditing => widget.subscription != null || widget.subscriptionId != null;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _descriptionController = TextEditingController();
    _logoUrlController = TextEditingController();
    _notesController = TextEditingController();
    _customCycleDaysController = TextEditingController();

    final initialSub = widget.subscription; 

    if (initialSub != null) {
      _loadSubscriptionData(initialSub);
    } else if (widget.subscriptionId != null) {
      final subFromState = context.read<SubscriptionCubit>().state.maybeWhen(
            loaded: (all, filtered, _, __, ___, ____) =>
                all.firstWhere((s) => s.id == widget.subscriptionId, orElse: () => _createEmptySubscription()),
            orElse: () => _createEmptySubscription(), 
          );
       _loadSubscriptionData(subFromState);
    } else {
      _currentId = _uuid.v4();
      _startDate = DateTime.now(); 
      _nextBillingDate = DateTime.now().add(const Duration(days: 30)); 
    }
  }
  
  SubscriptionEntity _createEmptySubscription() {
    return SubscriptionEntity(
      id: _uuid.v4(),
      name: '',
      price: 0.0,
      billingCycle: BillingCycle.monthly,
      nextBillingDate: DateTime.now().add(const Duration(days: 30)),
      category: SubscriptionCategory.other,
      startDate: DateTime.now(),
    );
  }


  void _loadSubscriptionData(SubscriptionEntity sub) {
    _currentId = sub.id;
    _nameController.text = sub.name;
    _priceController.text = sub.price.toStringAsFixed(2);
    _descriptionController.text = sub.description ?? '';
    _logoUrlController.text = sub.logoUrl ?? '';
    _notesController.text = sub.notes ?? '';
    _category = sub.category;
    _billingCycle = sub.billingCycle;
    _nextBillingDate = sub.nextBillingDate;
    _startDate = sub.startDate;
    _selectedColor = sub.color;
    _isActive = sub.isActive;
    _notificationsEnabled = sub.notificationsEnabled;
    _notificationDaysBefore = sub.notificationDaysBefore;
    _isInTrial = sub.isInTrial;
    _trialEndDate = sub.trialEndDate;
    if (sub.billingCycle == BillingCycle.custom && sub.customCycleDetails?['value'] != null) {
      _customCycleDaysController.text = sub.customCycleDetails!['value'].toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _logoUrlController.dispose();
    _notesController.dispose();
    _customCycleDaysController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, {
    required DateTime initialDate,
    required ValueChanged<DateTime> onDateSelected,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime(2000),
      lastDate: lastDate ?? DateTime(2101),
    );
    if (picked != null) {
      onDateSelected(picked);
    }
  }

  void _saveSubscription() {
    if (_formKey.currentState?.validate() ?? false) {
      final name = _nameController.text.trim();
      final price = double.tryParse(_priceController.text) ?? 0.0;
      final description = _descriptionController.text.trim();
      final logoUrl = _logoUrlController.text.trim();
      final notes = _notesController.text.trim();
      
      Map<String, dynamic>? customCycleDetails;
      if (_billingCycle == BillingCycle.custom) {
        final days = int.tryParse(_customCycleDaysController.text);
        if (days != null && days > 0) {
          customCycleDetails = {'type': 'days', 'value': days};
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Invalid custom cycle days.')), // TODO: Localize
          );
          return; 
        }
      }

      final subscriptionEntity = SubscriptionEntity(
        id: _currentId,
        name: name,
        price: price,
        billingCycle: _billingCycle,
        nextBillingDate: _nextBillingDate,
        category: _category,
        startDate: _startDate,
        description: description.isEmpty ? null : description,
        logoUrl: logoUrl.isEmpty ? null : logoUrl,
        color: _selectedColor,
        isActive: _isActive, 
        notificationsEnabled: _notificationsEnabled,
        notificationDaysBefore: _notificationDaysBefore,
        trialEndDate: _isInTrial ? _trialEndDate : null,
        customCycleDetails: customCycleDetails,
        notes: notes.isEmpty ? null : notes,
      );

      if (_isEditing) {
        context.read<SubscriptionCubit>().updateSubscription(subscriptionEntity);
      } else {
        context.read<SubscriptionCubit>().addSubscription(subscriptionEntity);
      }
      app_haptics.HapticFeedback.lightImpact();
      context.pop(); 
    } else {
      app_haptics.HapticFeedback.warningImpact(); 
    }
  }
  
  String _getBillingCycleLabel(BuildContext context, BillingCycle cycle) {
    // TODO: Localize these strings
    switch (cycle) {
      case BillingCycle.weekly: return 'Weekly';
      case BillingCycle.monthly: return 'Monthly';
      case BillingCycle.quarterly: return 'Quarterly';
      case BillingCycle.biAnnual: return 'Every 6 Months';
      case BillingCycle.yearly: return 'Yearly';
      case BillingCycle.custom: return 'Custom (Days)';
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd MMM yyyy'); 

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Subscription' : 'Add Subscription'), 
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt_rounded),
            tooltip: 'Save', 
            onPressed: _saveSubscription,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildSectionHeader(context, 'Basic Information'), 
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'), 
                textCapitalization: TextCapitalization.words,
                validator: (value) => (value?.trim().isEmpty ?? true) ? 'Name is required' : null, 
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Price', prefixText: '€ '), 
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))],
                validator: (value) {
                  if (value?.trim().isEmpty ?? true) return 'Price is required'; 
                  if (double.tryParse(value!) == null) return 'Invalid price'; 
                  return null;
                },
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<SubscriptionCategory>(
                value: _category,
                decoration: const InputDecoration(labelText: 'Category'), 
                items: SubscriptionCategory.values.map((cat) {
                  return DropdownMenuItem(
                    value: cat,
                    child: Row(
                      children: [
                        Icon(cat.displayIcon, size: 20, color: cat.categoryDisplayIconColor(theme)), // Using extensions
                        const SizedBox(width: 8),
                        Text(cat.displayName), // Using extensions
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (val) => setState(() => _category = val!),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description (Optional)'), 
                maxLines: 2,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 24),

              _buildSectionHeader(context, 'Billing Details'), 
              DropdownButtonFormField<BillingCycle>(
                value: _billingCycle,
                decoration: const InputDecoration(labelText: 'Billing Cycle'), 
                items: BillingCycle.values.map((cycle) {
                  return DropdownMenuItem(value: cycle, child: Text(_getBillingCycleLabel(context, cycle)));
                }).toList(),
                onChanged: (val) => setState(() => _billingCycle = val!),
              ),
              if (_billingCycle == BillingCycle.custom) ...[
                const SizedBox(height: 12),
                TextFormField(
                  controller: _customCycleDaysController,
                  decoration: const InputDecoration(labelText: 'Custom Cycle (in days)'), 
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value?.trim().isEmpty ?? true) return 'Cycle days required'; 
                    if ((int.tryParse(value!) ?? 0) <= 0) return 'Must be > 0 days'; 
                    return null;
                  },
                ),
              ],
              const SizedBox(height: 12),
              _buildDatePickerTile(
                context: context,
                title: 'Next Billing Date', 
                date: _nextBillingDate,
                dateFormat: dateFormat,
                onTap: () => _selectDate(context,
                    initialDate: _nextBillingDate,
                    onDateSelected: (date) => setState(() => _nextBillingDate = date)),
              ),
              const SizedBox(height: 12),
               _buildDatePickerTile(
                context: context,
                title: 'Subscription Start Date', 
                date: _startDate,
                dateFormat: dateFormat,
                onTap: () => _selectDate(context,
                    initialDate: _startDate ?? DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365*5)), 
                    onDateSelected: (date) => setState(() => _startDate = date)),
                canBeNull: true,
              ),
              const SizedBox(height: 24),

              _buildSectionHeader(context, 'Optional Details'), 
               SwitchListTile.adaptive(
                title: Text('Active Subscription', style: theme.textTheme.bodyLarge), 
                value: _isActive,
                onChanged: (val) => setState(() => _isActive = val),
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
              SwitchListTile.adaptive(
                title: Text('In Trial Period', style: theme.textTheme.bodyLarge), 
                value: _isInTrial,
                onChanged: (val) => setState(() {
                  _isInTrial = val;
                  if (!_isInTrial) _trialEndDate = null;
                }),
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
              if (_isInTrial)
                _buildDatePickerTile(
                  context: context,
                  title: 'Trial End Date', 
                  date: _trialEndDate,
                  dateFormat: dateFormat,
                  onTap: () => _selectDate(context,
                      initialDate: _trialEndDate ?? _nextBillingDate.add(const Duration(days:7)),
                      firstDate: DateTime.now(),
                      onDateSelected: (date) => setState(() => _trialEndDate = date)),
                  canBeNull: true,
                ),
              const SizedBox(height: 12),
              SwitchListTile.adaptive(
                title: Text('Enable Notifications', style: theme.textTheme.bodyLarge), 
                value: _notificationsEnabled,
                onChanged: (val) => setState(() => _notificationsEnabled = val),
                dense: true,
                contentPadding: EdgeInsets.zero,
              ),
              if (_notificationsEnabled) ...[
                const SizedBox(height: 12),
                DropdownButtonFormField<int>(
                  value: _notificationDaysBefore,
                  decoration: const InputDecoration(labelText: 'Notify Days Before Renewal'), 
                  items: [1, 2, 3, 5, 7, 10, 14, 21, 30].map((days) {
                    return DropdownMenuItem(value: days, child: Text('$days day${days > 1 ? "s" : ""}')); 
                  }).toList(),
                  onChanged: (val) => setState(() => _notificationDaysBefore = val!),
                ),
              ],
              const SizedBox(height: 12),
              TextFormField(
                controller: _logoUrlController,
                decoration: const InputDecoration(labelText: 'Logo URL (Optional)'), 
                keyboardType: TextInputType.url,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _notesController,
                decoration: const InputDecoration(labelText: 'Notes (Optional)'), 
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          color: Theme.of(context).colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildDatePickerTile({
    required BuildContext context,
    required String title,
    required DateTime? date,
    required DateFormat dateFormat,
    required VoidCallback onTap,
    bool canBeNull = false,
  }) {
    final theme = Theme.of(context);
    return ListTile(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(color: theme.inputDecorationTheme.enabledBorder?.borderSide.color ?? theme.dividerColor)
      ),
      title: Text(title, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
      subtitle: Text(
        date != null ? dateFormat.format(date) : (canBeNull ? 'Not Set' : 'Please select a date'), 
        style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500, color: date != null ? theme.colorScheme.onSurface : theme.colorScheme.onSurfaceVariant),
      ),
      trailing: const Icon(Icons.calendar_month_rounded),
      onTap: onTap,
    );
  }
}