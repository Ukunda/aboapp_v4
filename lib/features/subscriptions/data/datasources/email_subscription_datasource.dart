import 'package:injectable/injectable.dart';
import '../models/subscription_suggestion_model.dart';
import '../../domain/entities/subscription_entity.dart';

abstract class EmailSubscriptionDataSource {
  Future<List<SubscriptionSuggestionModel>> fetchSuggestions({
    required String host,
    required int port,
    required bool isSecure,
    required String username,
    required String password,
  });
}

@LazySingleton(as: EmailSubscriptionDataSource)
class EmailSubscriptionDataSourceImpl implements EmailSubscriptionDataSource {
  @override
  Future<List<SubscriptionSuggestionModel>> fetchSuggestions({
    required String host,
    required int port,
    required bool isSecure,
    required String username,
    required String password,
  }) async {
    // Placeholder implementation. Real IMAP fetching is omitted in tests.
    return [];
  }

  SubscriptionSuggestionModel? parseEmail(String text) {
    final servicePattern = RegExp(r'(Netflix|Spotify|Prime|Disney|Apple|Google)', caseSensitive: false);
    final amountPattern = RegExp(r'(\d+[,.]\d{2})');
    final cyclePattern = RegExp(r'(weekly|monthly|quarterly|bi-annual|yearly|annual)', caseSensitive: false);

    final serviceMatch = servicePattern.firstMatch(text);
    final amountMatch = amountPattern.firstMatch(text);
    final cycleMatch = cyclePattern.firstMatch(text);
    if (serviceMatch == null || amountMatch == null) return null;
    final service = serviceMatch.group(0)!;
    final amount = double.parse(amountMatch.group(0)!.replaceAll(',', '.'));
    BillingCycle cycle;
    switch (cycleMatch?.group(0)?.toLowerCase()) {
      case 'weekly':
        cycle = BillingCycle.weekly;
        break;
      case 'quarterly':
        cycle = BillingCycle.quarterly;
        break;
      case 'bi-annual':
        cycle = BillingCycle.biAnnual;
        break;
      case 'yearly':
      case 'annual':
        cycle = BillingCycle.yearly;
        break;
      case 'monthly':
      default:
        cycle = BillingCycle.monthly;
    }
    return SubscriptionSuggestionModel(service: service, amount: amount, cycle: cycle);
  }
}
