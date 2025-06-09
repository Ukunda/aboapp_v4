// lib/features/subscriptions/presentation/screens/add_subscription_flow_screen.dart

import 'dart:async';

import 'package:aboapp/core/utils/haptic_feedback.dart' as app_haptics;
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';
import 'package:aboapp/features/subscriptions/presentation/widgets/add_flow_step1_core.dart';
import 'package:aboapp/features/subscriptions/presentation/widgets/add_flow_step2_billing.dart';
import 'package:aboapp/features/subscriptions/presentation/widgets/add_flow_step3_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class AddSubscriptionFlowScreen extends StatefulWidget {
  const AddSubscriptionFlowScreen({super.key});

  @override
  State<AddSubscriptionFlowScreen> createState() =>
      _AddSubscriptionFlowScreenState();
}

class _AddSubscriptionFlowScreenState extends State<AddSubscriptionFlowScreen> {
  final _pageController = PageController();
  final _formKeyStep1 = GlobalKey<FormState>();

  // Temporary state for the subscription being built
  String _name = '';
  double _price = 0.0;
  BillingCycle _billingCycle = BillingCycle.monthly;
  DateTime _firstBillingDate = DateTime.now().add(const Duration(days: 30));
  SubscriptionCategory _category = SubscriptionCategory.other;
  String? _description;

  bool _isNextButtonEnabled = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onStep1Changed(String name, String price) {
    setState(() {
      _name = name;
      _price = double.tryParse(price) ?? 0.0;
      _isNextButtonEnabled = _name.isNotEmpty && _price > 0;
    });
  }

  void _onStep2Changed(BillingCycle cycle, DateTime date) {
    setState(() {
      _billingCycle = cycle;
      _firstBillingDate = date;
    });
  }

  void _onStep3Changed(SubscriptionCategory category, String? description) {
    setState(() {
      _category = category;
      _description = description;
    });
  }

  void _nextPage() {
    if (_pageController.page == 0 && !_isNextButtonEnabled) return;
    app_haptics.HapticFeedback.lightImpact();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  void _previousPage() {
    app_haptics.HapticFeedback.lightImpact();
    _pageController.previousPage(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOutCubic,
    );
  }

  void _saveSubscription() {
    final newSubscription = SubscriptionEntity(
      id: const Uuid().v4(),
      name: _name,
      price: _price,
      billingCycle: _billingCycle,
      nextBillingDate: _firstBillingDate,
      category: _category,
      startDate: DateTime.now(),
      description: _description,
      isActive: true,
      notificationsEnabled: true,
    );
    context.read<SubscriptionCubit>().addSubscription(newSubscription);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentPage =
        _pageController.hasClients ? _pageController.page?.round() ?? 0 : 0;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: currentPage > 0
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: _previousPage,
              )
            : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded),
            onPressed: () => context.pop(),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics:
                    const NeverScrollableScrollPhysics(), // Disable swiping
                children: [
                  AddFlowStep1Core(
                    formKey: _formKeyStep1,
                    onChanged: _onStep1Changed,
                  ),
                  AddFlowStep2Billing(
                    initialCycle: _billingCycle,
                    initialDate: _firstBillingDate,
                    onChanged: _onStep2Changed,
                  ),
                  AddFlowStep3Details(
                    name: _name,
                    price: _price,
                    billingCycle: _billingCycle,
                    onChanged: _onStep3Changed,
                  ),
                ],
              ),
            ),
            _buildBottomBar(theme),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(ThemeData theme) {
    // Animated switcher for the button text
    return AnimatedBuilder(
      animation: _pageController,
      builder: (context, child) {
        final page = _pageController.hasClients ? _pageController.page ?? 0 : 0;
        final isLastPage = page > 1.5;

        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: isLastPage
                  ? _saveSubscription
                  : (_isNextButtonEnabled ? _nextPage : null),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.onSurface,
                foregroundColor: theme.colorScheme.surface,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                isLastPage ? 'Add Subscription' : 'Next',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.surface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
