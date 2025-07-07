import 'package:freezed_annotation/freezed_annotation.dart';
import 'subscription_entity.dart';

part 'subscription_suggestion.freezed.dart';

@freezed
class SubscriptionSuggestion with _$SubscriptionSuggestion {
  const factory SubscriptionSuggestion({
    required String service,
    required double amount,
    required BillingCycle cycle,
  }) = _SubscriptionSuggestion;
}
