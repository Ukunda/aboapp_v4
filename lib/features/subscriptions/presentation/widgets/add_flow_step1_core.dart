// lib/features/subscriptions/presentation/widgets/add_flow_step1_core.dart

import 'package:flutter/material.dart';

class AddFlowStep1Core extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(String name, String price) onChanged;

  const AddFlowStep1Core({
    super.key,
    required this.formKey,
    required this.onChanged,
  });

  @override
  State<AddFlowStep1Core> createState() => _AddFlowStep1CoreState();
}

class _AddFlowStep1CoreState extends State<AddFlowStep1Core> {
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() {
      widget.onChanged(_nameController.text, _priceController.text);
    });
    _priceController.addListener(() {
      widget.onChanged(_nameController.text, _priceController.text);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currencySymbol = '€'; // TODO: Get from settings

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What are you\nsubscribing to?",
              style: theme.textTheme.displaySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: _nameController,
              autofocus: true,
              style: theme.textTheme.headlineSmall,
              decoration: InputDecoration(
                labelText: 'Name or Service',
                labelStyle: theme.textTheme.bodyLarge,
                border: InputBorder.none,
              ),
              textCapitalization: TextCapitalization.words,
            ),
            const SizedBox(height: 24),
            TextFormField(
              controller: _priceController,
              style: theme.textTheme.headlineSmall,
              decoration: InputDecoration(
                labelText: 'Amount',
                labelStyle: theme.textTheme.bodyLarge,
                border: InputBorder.none,
                suffixText: currencySymbol,
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
          ],
        ),
      ),
    );
  }
}
