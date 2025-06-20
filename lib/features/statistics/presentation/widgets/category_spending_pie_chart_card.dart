import 'package:aboapp/features/statistics/presentation/cubit/statistics_cubit.dart'; 
import 'package:aboapp/features/subscriptions/presentation/widgets/subscription_card_widget.dart'; // Import for CategoryDisplayHelpers
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart'; // Unused import

class CategorySpendingPieChartCard extends StatefulWidget {
  final List<CategorySpending> categorySpendingData;

  const CategorySpendingPieChartCard({
    super.key,
    required this.categorySpendingData,
  });

  @override
  State<CategorySpendingPieChartCard> createState() => _CategorySpendingPieChartCardState();
}

class _CategorySpendingPieChartCardState extends State<CategorySpendingPieChartCard> {
  int? _touchedIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // TODO: Use locale/currency from SettingsCubit
    final currencyFormat = NumberFormat.currency(locale: 'de_DE', symbol: '€', decimalDigits: 0); 

    if (widget.categorySpendingData.isEmpty) {
      return Card(
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'No category spending data available.', // TODO: Localize
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ),
      );
    }
    
    final relevantData = widget.categorySpendingData.where((d) => d.totalAmount > 0.01).toList();
    if (relevantData.isEmpty) {
       return Card(
        elevation: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Text(
              'No significant category spending.', // TODO: Localize
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ),
      );
    }


    return Card(
      elevation: 1.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spending by Category', // TODO: Localize
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 180, 
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          _touchedIndex = -1;
                          return;
                        }
                        _touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: 45, 
                  sections: _generatePieChartSections(theme, relevantData),
                ),
              ),
            ),
            const SizedBox(height: 24),
            _buildLegend(theme, currencyFormat, relevantData),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _generatePieChartSections(ThemeData theme, List<CategorySpending> data) {
    return List.generate(data.length, (i) {
      final isTouched = i == _touchedIndex;
      final fontSize = isTouched ? 14.0 : 10.0;
      final radius = isTouched ? 70.0 : 60.0;
      final categoryData = data[i];

      return PieChartSectionData(
        color: categoryData.category.categoryDisplayIconColor(theme), 
        value: categoryData.totalAmount,
        title: '${(categoryData.percentage * 100).toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: ThemeData.estimateBrightnessForColor(categoryData.category.categoryDisplayIconColor(theme)) == Brightness.dark
                 ? Colors.white : Colors.black,
          shadows: const [Shadow(color: Colors.black26, blurRadius: 1)],
        ),
      );
    });
  }

  Widget _buildLegend(ThemeData theme, NumberFormat currencyFormat, List<CategorySpending> data) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 8.0,
      alignment: WrapAlignment.center,
      children: data.map((categoryData) {
        final isTouched = data.indexOf(categoryData) == _touchedIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: isTouched ? categoryData.category.categoryDisplayIconColor(theme).withOpacity(0.2) : Colors.transparent,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: categoryData.category.categoryDisplayIconColor(theme),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                categoryData.category.displayName, // Using extension getter
                style: theme.textTheme.bodySmall?.copyWith(
                  fontWeight: isTouched ? FontWeight.bold : FontWeight.normal,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                '(${currencyFormat.format(categoryData.totalAmount)})',
                 style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: isTouched ? FontWeight.bold : FontWeight.normal,
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
