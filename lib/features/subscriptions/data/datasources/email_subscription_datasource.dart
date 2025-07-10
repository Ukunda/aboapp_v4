import 'package:enough_mail/enough_mail.dart';
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
    final client = ImapClient(isLogEnabled: false);
    final suggestions = <SubscriptionSuggestionModel>[];
    try {
      await client.connectToServer(host, port, isSecure: isSecure);
      await client.login(username, password);
      await client.selectInbox();
      final sinceDate = DateTime.now().subtract(const Duration(days: 90));
      final imapDate =
          '${sinceDate.day}-${_getShortMonth(sinceDate.month)}-${sinceDate.year}';

      final froms = [
        'netflix.com',
        'spotify.com',
        'amazon.com',
        'disney.com',
        'apple.com',
        'google.com'
      ];

      for (final from in froms) {
        final query = '(SENTSINCE $imapDate FROM "$from")';
        final searchResult = await client.searchMessages(query);
        if (searchResult.matchingSequence != null) {
          final fetchedMessages = await client.fetchMessages(
              searchResult.matchingSequence!, 'BODY.PEEK[]');
          for (final message in fetchedMessages.messages) {
            final text = message.decodeContentText() ?? '';
            final suggestion = parseEmail(text);
            if (suggestion != null) {
              // Avoid duplicates
              if (!suggestions.any((s) =>
                  s.service == suggestion.service &&
                  s.amount == suggestion.amount &&
                  s.cycle == suggestion.cycle)) {
                suggestions.add(suggestion);
              }
            }
          }
        }
      }

      await client.logout();
      return suggestions;
    } catch (e) {
      // Log error or handle it as per app's error handling strategy
      rethrow;
    } finally {
      if (client.isConnected) {
        await client.disconnect();
      }
    }
  }

  String _getShortMonth(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }

  SubscriptionSuggestionModel? parseEmail(String text) {
    final servicePattern =
        RegExp(r'(Netflix|Spotify|Prime|Disney|Apple|Google)', caseSensitive: false);
    final amountPattern = RegExp(r'(\d+[,.]\d{2})');
    final cyclePattern = RegExp(r'(weekly|monthly|quarterly|bi-annual|yearly|annual)',
        caseSensitive: false);

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
    return SubscriptionSuggestionModel(
        service: service, amount: amount, cycle: cycle);
  }
}
