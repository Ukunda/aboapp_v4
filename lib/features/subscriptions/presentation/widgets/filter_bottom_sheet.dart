// lib/features/subscriptions/presentation/widgets/filter_bottom_sheet.dart
import 'package:aboapp/core/utils/haptic_feedback.dart' as app_haptics;
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';
// Import für die .displayName Erweiterung auf SubscriptionCategory
import 'package:aboapp/features/subscriptions/presentation/widgets/subscription_card_widget.dart';
// Import für den GradientOutlinePainter
import 'package:aboapp/widgets/animated_gradient_chip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBottomSheet extends StatefulWidget {
  final SortOption currentSortOption;
  final List<SubscriptionCategory> currentCategories;
  final List<BillingCycle> currentBillingCycles;

  const FilterBottomSheet({
    super.key,
    required this.currentSortOption,
    required this.currentCategories,
    required this.currentBillingCycles,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet>
    with SingleTickerProviderStateMixin {
  late SortOption _selectedSortOption;
  late List<SubscriptionCategory> _selectedCategories;
  late List<BillingCycle> _selectedBillingCycles;
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _selectedSortOption = widget.currentSortOption;
    _selectedCategories = List.from(widget.currentCategories);
    _selectedBillingCycles = List.from(widget.currentBillingCycles);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _applyFiltersAndClose() {
    final cubit = context.read<SubscriptionCubit>();
    cubit.changeSortOption(_selectedSortOption);
    cubit.setCategoryFilters(_selectedCategories);
    cubit.setBillingCycleFilters(_selectedBillingCycles);
    Navigator.pop(context);
  }

  void _resetFilters() {
    app_haptics.HapticFeedback.lightImpact();
    setState(() {
      _selectedSortOption = SortOption.nextBillingDateAsc;
      _selectedCategories.clear();
      _selectedBillingCycles.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Sort & Filter", style: theme.textTheme.headlineSmall),
                TextButton(
                  onPressed: _resetFilters,
                  child: const Text("Reset"),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text("SORT BY",
                style: theme.textTheme.labelMedium
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 8),
            _buildSortDropdown(theme),
            const SizedBox(height: 24),
            Text("CATEGORIES",
                style: theme.textTheme.labelMedium
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 8),
            _buildMultiSelectChipGroup<SubscriptionCategory>(
              allItems: SubscriptionCategory.values,
              selectedItems: _selectedCategories,
              onTap: (item) {
                app_haptics.HapticFeedback.selectionClick();
                setState(() {
                  if (_selectedCategories.contains(item)) {
                    _selectedCategories.remove(item);
                  } else {
                    _selectedCategories.add(item);
                  }
                });
              },
              getLabel: (item) => item.displayName,
            ),
            const SizedBox(height: 24),
            Text("BILLING CYCLES",
                style: theme.textTheme.labelMedium
                    ?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
            const SizedBox(height: 8),
            _buildMultiSelectChipGroup<BillingCycle>(
              allItems: BillingCycle.values
                  .where((c) => c != BillingCycle.custom)
                  .toList(),
              selectedItems: _selectedBillingCycles,
              onTap: (item) {
                app_haptics.HapticFeedback.selectionClick();
                setState(() {
                  if (_selectedBillingCycles.contains(item)) {
                    _selectedBillingCycles.remove(item);
                  } else {
                    _selectedBillingCycles.add(item);
                  }
                });
              },
              getLabel: (item) =>
                  item.name[0].toUpperCase() + item.name.substring(1),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _applyFiltersAndClose,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
              ),
              child: const Text("Apply Filters"),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // HIER IST DIE ÄNDERUNG FÜR DAS DROPDOWN
  Widget _buildSortDropdown(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: theme.colorScheme.outline)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<SortOption>(
          value: _selectedSortOption,
          isExpanded: true,
          icon: const Icon(Icons.unfold_more_rounded),
          // --- STYLING FÜR DAS AUFGEKLAPPTE MENÜ ---
          borderRadius: BorderRadius.circular(12.0),
          dropdownColor: theme.cardColor,
          elevation: 4,
          // --- ENDE STYLING ---
          onChanged: (newValue) {
            if (newValue != null) {
              setState(() {
                _selectedSortOption = newValue;
              });
            }
          },
          items: SortOption.values.map((option) {
            return DropdownMenuItem<SortOption>(
              value: option,
              child: Padding(
                // Etwas mehr vertikaler Platz für jedes Element
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(option.displayName),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildMultiSelectChipGroup<T>({
    required List<T> allItems,
    required List<T> selectedItems,
    required Function(T) onTap,
    required String Function(T) getLabel,
  }) {
    return Wrap(
      spacing: 10.0,
      runSpacing: 10.0,
      children: allItems.map((item) {
        final isSelected = selectedItems.contains(item);
        return CustomGradientFilterChip(
          label: getLabel(item),
          isSelected: isSelected,
          onTap: () => onTap(item),
          animation: _animationController,
        );
      }).toList(),
    );
  }
}

class CustomGradientFilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Animation<double> animation;

  const CustomGradientFilterChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradientColors = [
      Colors.pink.shade200,
      Colors.purple.shade300,
      Colors.blue.shade300,
      Colors.pink.shade200, // Schließt den Farbkreis
    ];

    return CustomPaint(
      foregroundPainter: isSelected
          ? GradientOutlinePainter(
              animation: animation,
              strokeWidth: 2.0,
              radius: 50.0,
              gradientColors: gradientColors,
            )
          : null,
      child: Material(
        color: Colors.transparent,
        shape: const StadiumBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const StadiumBorder(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primary.withValues(alpha: 26)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(50.0),
              border: isSelected ? null : Border.all(color: theme.dividerColor),
            ),
            child: Text(
              label,
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
