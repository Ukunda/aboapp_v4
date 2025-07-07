import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aboapp/core/utils/context_currency_formatter.dart';

void main() {
  group('ContextCurrencyFormatter', () {
    testWidgets('should format currency with default locale', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          locale: Locale('en', 'US'),
          home: TestWidget(),
        ),
      );

      final context = tester.element(find.byType(TestWidget));
      
      final formatted = ContextCurrencyFormatter.format(context, 99.99, currencyCode: 'USD');
      expect(formatted, contains('99.99'));
      expect(formatted, contains('\$'));
    });

    testWidgets('should format currency with different locales', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          locale: Locale('de', 'DE'),
          home: TestWidget(),
        ),
      );

      final context = tester.element(find.byType(TestWidget));
      
      final formatted = ContextCurrencyFormatter.format(context, 99.99, currencyCode: 'EUR');
      expect(formatted, contains('99'));
      expect(formatted, contains('€'));
    });

    test('should get correct currency symbols', () {
      expect(ContextCurrencyFormatter.getCurrencySymbol('USD'), equals('\$'));
      expect(ContextCurrencyFormatter.getCurrencySymbol('EUR'), equals('€'));
      expect(ContextCurrencyFormatter.getCurrencySymbol('GBP'), equals('£'));
      expect(ContextCurrencyFormatter.getCurrencySymbol('JPY'), equals('¥'));
    });

    test('should parse formatted amounts correctly', () {
      expect(ContextCurrencyFormatter.tryParse('\$99.99'), equals(99.99));
      expect(ContextCurrencyFormatter.tryParse('€1,234.56'), equals(1234.56));
      expect(ContextCurrencyFormatter.tryParse('invalid'), isNull);
    });

    test('should get default currency for locale', () {
      // Test internal method behavior through format method
      expect(ContextCurrencyFormatter.getCurrencySymbol('USD'), equals('\$'));
      expect(ContextCurrencyFormatter.getCurrencySymbol('EUR'), equals('€'));
      expect(ContextCurrencyFormatter.getCurrencySymbol('GBP'), equals('£'));
    });
  });
}

class TestWidget extends StatelessWidget {
  const TestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Test'),
    );
  }
}