// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_suggestion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionSuggestionModelImpl _$$SubscriptionSuggestionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionSuggestionModelImpl(
      service: json['service'] as String,
      amount: (json['amount'] as num).toDouble(),
      cycle: $enumDecode(_$BillingCycleEnumMap, json['cycle']),
    );

Map<String, dynamic> _$$SubscriptionSuggestionModelImplToJson(
        _$SubscriptionSuggestionModelImpl instance) =>
    <String, dynamic>{
      'service': instance.service,
      'amount': instance.amount,
      'cycle': _$BillingCycleEnumMap[instance.cycle]!,
    };

const _$BillingCycleEnumMap = {
  BillingCycle.weekly: 'weekly',
  BillingCycle.monthly: 'monthly',
  BillingCycle.quarterly: 'quarterly',
  BillingCycle.biAnnual: 'biAnnual',
  BillingCycle.yearly: 'yearly',
  BillingCycle.custom: 'custom',
};
