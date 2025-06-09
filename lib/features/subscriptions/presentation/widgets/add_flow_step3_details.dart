// lib/features/subscriptions/presentation/widgets/add_flow_step3_details.dart

import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/widgets/subscription_card_widget.dart'; // For display helpers
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddFlowStep3Details extends StatefulWidget {
  final String name;
  final double price;
  final BillingCycle billingCycle;
  final Function(SubscriptionCategory category, String? description) onChanged;

  const AddFlowStep3Details({
    super.key,
    required this.name,
    required this.price,
    required this.billingCycle,
    required this.onChanged,
  });

  @override
  State<AddFlowStep3Details> createState() => _AddFlowStep3DetailsState();
}

class _AddFlowStep3DetailsState extends State<AddFlowStep3Details> {
  SubscriptionCategory _selectedCategory = SubscriptionCategory.other;
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _descriptionController.addListener(() {
      widget.onChanged(_selectedCategory, _descriptionController.text);
    });
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  void _updateCategory(SubscriptionCategory category) {
    setState(() {
      _selectedCategory = category;
    });
    widget.onChanged(_selectedCategory, _descriptionController.text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencyFormat = NumberFormat.currency(locale: 'de_DE', symbol: '€');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Finishing up...",
            style: theme.textTheme.displaySmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          _buildSummaryCard(context),
          const SizedBox(height: 32),
          Text("Category", style: theme.textTheme.bodyLarge),
          const SizedBox(height: 16),
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: SubscriptionCategory.values.length,
              itemBuilder: (context, index) {
                final category = SubscriptionCategory.values[index];
                final isSelected = _selectedCategory == category;
                return ChoiceChip(
                  label: Text(category.displayName),
                  avatar: Icon(category.displayIcon, size: 18),
                  selected: isSelected,
                  onSelected: (selected) => _updateCategory(category),
                  selectedColor: theme.colorScheme.onSurface,
                  labelStyle: TextStyle(
                      color: isSelected
                          ? theme.colorScheme.surface
                          : theme.colorScheme.onSurface),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 8),
            ),
          ),
          const SizedBox(height: 24),
          TextFormField(
            controller: _descriptionController,
            decoration: InputDecoration(
              labelText: 'Description (Optional)',
              border: InputBorder.none,
            ),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Text(
              widget.name,
              style: theme.textTheme.titleLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            "${NumberFormat.currency(locale: 'de_DE', symbol: '€').format(widget.price)} / mo", // TODO: Format based on cycle
            style: theme.textTheme.titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
