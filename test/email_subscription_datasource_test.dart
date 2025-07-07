import 'package:flutter_test/flutter_test.dart';
import 'package:aboapp/features/subscriptions/data/datasources/email_subscription_datasource.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';

void main() {
  group('EmailSubscriptionDataSource.parseEmail', () {
    final dataSource = EmailSubscriptionDataSourceImpl();

    test('parses service, amount and cycle', () {
      const sample = 'Thank you for subscribing to Netflix. Amount: 9.99 monthly.';
      final result = dataSource.parseEmail(sample);
      expect(result, isNotNull);
      expect(result!.service, 'Netflix');
      expect(result.amount, 9.99);
      expect(result.cycle, BillingCycle.monthly);
    });
  });
}
