import 'package:aboapp/core/utils/currency_formatter.dart';
import 'package:aboapp/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:aboapp/features/subscriptions/presentation/widgets/subscription_card_widget.dart';
import 'package:aboapp/widgets/animated_gradient_chip.dart';
import 'package:aboapp/widgets/animated_gradient_input_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';

class AddEditSubscriptionScreen extends StatefulWidget {
  final SubscriptionEntity? initialSubscription;
  const AddEditSubscriptionScreen({super.key, this.initialSubscription});

  @override
  State<AddEditSubscriptionScreen> createState() =>
      _AddEditSubscriptionScreenState();
}

class _AddEditSubscriptionScreenState extends State<AddEditSubscriptionScreen>
    with SingleTickerProviderStateMixin {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _notesController = TextEditingController();
  late final AnimationController _animationController;
  late SubscriptionCategory _selectedCategory;
  late BillingCycle _selectedCycle;
  late DateTime _nextBillingDate;
  bool get _isEditing => widget.initialSubscription != null;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    if (_isEditing) {
      final s = widget.initialSubscription!;
      _nameController.text = s.name;
      _priceController.text = s.price.toString().replaceAll('.', ',');
      _notesController.text = s.notes ?? '';
      _selectedCategory = s.category;
      _selectedCycle = s.billingCycle;
      _nextBillingDate = s.nextBillingDate;
    } else {
      _selectedCategory = SubscriptionCategory.other;
      _selectedCycle = BillingCycle.monthly;
      _nextBillingDate = DateTime.now().add(const Duration(days: 30));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _notesController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _pickNextBillingDate(Locale locale) async {
    final picked = await showDatePicker(
      context: context,
      locale: locale,
      initialDate: _nextBillingDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365 * 5)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 10)),
    );
    if (picked != null) setState(() => _nextBillingDate = picked);
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final price =
        double.parse(_priceController.text.trim().replaceAll(',', '.'));
    final sub = SubscriptionEntity(
      id: widget.initialSubscription?.id ?? '',
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
    _isEditing ? cubit.updateSubscription(sub) : cubit.addSubscription(sub);
    Navigator.of(context).pop();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settingsState = context.watch<SettingsCubit>().state;
    final currencySymbol =
        CurrencyFormatter.getCurrencySymbol(settingsState.currencyCode);

    final defaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide.none,
    );

    // KORREKTUR: Farbverlauf für weichere Übergänge angepasst
    final focusedBorder = AnimatedGradientInputBorder(
      animation: _animationController,
      gradientColors: [
        Colors.pink.shade200,
        Colors.purple.shade200,
        Colors.blue.shade200,
        Colors.purple.shade200,
        Colors.pink.shade200,
      ],
    );
    final errorBorder = AnimatedGradientInputBorder(
      animation: _animationController,
      gradientColors: [
        theme.colorScheme.error.withAlpha(180),
        Colors.orange.shade400.withAlpha(180),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Abo bearbeiten' : 'Abo hinzufügen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              _buildSectionTitle(theme, 'Kategorie'),
              _buildCategorySelector(theme),
              const SizedBox(height: 24),
              _buildSectionTitle(theme, 'Abo-Name'),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => TextFormField(
                  controller: _nameController,
                  decoration: _inputDecoration(
                    theme: theme,
                    icon: Icons.subscriptions_outlined,
                    hintText: 'z.B. Netflix, Spotify...',
                    defaultBorder: defaultBorder,
                    focusedBorder: focusedBorder,
                    errorBorder: errorBorder,
                  ),
                  validator: (v) =>
                      v == null || v.trim().isEmpty ? 'Pflichtfeld' : null,
                ),
              ),
              const SizedBox(height: 16),
              _buildSectionTitle(theme, 'Preis ($currencySymbol)'),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => TextFormField(
                  controller: _priceController,
                  decoration: _inputDecoration(
                    theme: theme,
                    icon: Icons.price_change_outlined,
                    hintText: '0,00',
                    defaultBorder: defaultBorder,
                    focusedBorder: focusedBorder,
                    errorBorder: errorBorder,
                  ),
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[\d,.]'))
                  ],
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Pflichtfeld';
                    if (double.tryParse(v.trim().replaceAll(',', '.')) == null)
                      return 'Ungültiger Betrag';
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(theme, 'Intervall'),
                        AnimatedBuilder(
                          animation: _animationController,
                          builder: (context, child) =>
                              DropdownButtonFormField<BillingCycle>(
                            value: _selectedCycle,
                            decoration: _inputDecoration(
                              theme: theme,
                              icon: Icons.calendar_view_month,
                              defaultBorder: defaultBorder,
                              focusedBorder: focusedBorder,
                            ),
                            items: BillingCycle.values
                                .where((c) => c != BillingCycle.custom)
                                .map((c) => DropdownMenuItem(
                                    value: c, child: Text(c.displayName)))
                                .toList(),
                            onChanged: (v) => setState(
                                () => _selectedCycle = v ?? _selectedCycle),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildSectionTitle(theme, 'Nächste Zahlung'),
                        InkWell(
                          onTap: () =>
                              _pickNextBillingDate(settingsState.locale),
                          child: InputDecorator(
                            decoration: _inputDecoration(
                              theme: theme,
                              icon: Icons.event,
                              defaultBorder: defaultBorder,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top:
                                      1.0), // Kleine Anpassung für vertikale Zentrierung
                              child: Text(
                                DateFormat.yMd(
                                        settingsState.locale.toLanguageTag())
                                    .format(_nextBillingDate),
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildSectionTitle(theme, 'Notizen (optional)'),
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => TextFormField(
                  controller: _notesController,
                  decoration: _inputDecoration(
                    theme: theme,
                    icon: Icons.note_alt_outlined,
                    hintText: 'Zusätzliche Infos...',
                    defaultBorder: defaultBorder,
                    focusedBorder: focusedBorder,
                  ),
                  maxLines: 3,
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  label: Text(_isEditing ? 'Aktualisieren' : 'Speichern'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: _save,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // KORREKTUR: Hilfsmethode für das getrennte Label
  Widget _buildSectionTitle(ThemeData theme, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(
        title,
        style:
            theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  // KORREKTUR: InputDecoration verwendet jetzt 'hintText' statt 'labelText'
  InputDecoration _inputDecoration({
    required ThemeData theme,
    required IconData icon,
    String? hintText,
    required InputBorder defaultBorder,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
  }) {
    return InputDecoration(
      hintText: hintText,
      prefixIcon: Icon(icon, color: theme.colorScheme.onSurfaceVariant),
      filled: true,
      fillColor: theme.colorScheme.surface,
      border: defaultBorder,
      enabledBorder: defaultBorder,
      focusedBorder: focusedBorder,
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  Widget _buildCategorySelector(ThemeData theme) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: SubscriptionCategory.values.map((cat) {
        return AnimatedGradientChip(
          label: cat.displayName,
          icon: cat.displayIcon,
          isSelected: _selectedCategory == cat,
          selectedColor: cat.categoryDisplayIconColor(theme),
          onSelected: (_) => setState(() => _selectedCategory = cat),
        );
      }).toList(),
    );
  }
}

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
