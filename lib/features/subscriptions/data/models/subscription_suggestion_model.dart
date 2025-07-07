import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/subscription_suggestion.dart';
import '../../domain/entities/subscription_entity.dart';

part 'subscription_suggestion_model.freezed.dart';
part 'subscription_suggestion_model.g.dart';

@freezed
class SubscriptionSuggestionModel with _$SubscriptionSuggestionModel {
  const factory SubscriptionSuggestionModel({
    required String service,
    required double amount,
    required BillingCycle cycle,
  }) = _SubscriptionSuggestionModel;

  factory SubscriptionSuggestionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionSuggestionModelFromJson(json);
}

extension SubscriptionSuggestionModelX on SubscriptionSuggestionModel {
  SubscriptionSuggestion toEntity() => SubscriptionSuggestion(
        service: service,
        amount: amount,
        cycle: cycle,
      );

  static SubscriptionSuggestionModel fromEntity(SubscriptionSuggestion entity) =>
      SubscriptionSuggestionModel(
        service: entity.service,
        amount: entity.amount,
        cycle: entity.cycle,
      );
}
