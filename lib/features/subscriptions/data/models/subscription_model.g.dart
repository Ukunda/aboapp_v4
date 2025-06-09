// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SubscriptionModelImpl _$$SubscriptionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$SubscriptionModelImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      billingCycle: $enumDecode(_$BillingCycleEnumMap, json['billingCycle'],
          unknownValue: BillingCycle.custom),
      nextBillingDate: DateTime.parse(json['nextBillingDate'] as String),
      category: $enumDecode(_$SubscriptionCategoryEnumMap, json['category'],
          unknownValue: SubscriptionCategory.other),
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      description: json['description'] as String?,
      logoUrl: json['logoUrl'] as String?,
      color: const ColorSerializer().fromJson((json['color'] as num?)?.toInt()),
      isActive: json['isActive'] as bool? ?? true,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      notificationDaysBefore:
          (json['notificationDaysBefore'] as num?)?.toInt() ?? 7,
      trialEndDate: json['trialEndDate'] == null
          ? null
          : DateTime.parse(json['trialEndDate'] as String),
      customCycleDetails: json['customCycleDetails'] as Map<String, dynamic>?,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$SubscriptionModelImplToJson(
        _$SubscriptionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'billingCycle': _$BillingCycleEnumMap[instance.billingCycle]!,
      'nextBillingDate': instance.nextBillingDate.toIso8601String(),
      'category': _$SubscriptionCategoryEnumMap[instance.category]!,
      'startDate': instance.startDate?.toIso8601String(),
      'description': instance.description,
      'logoUrl': instance.logoUrl,
      'color': const ColorSerializer().toJson(instance.color),
      'isActive': instance.isActive,
      'notificationsEnabled': instance.notificationsEnabled,
      'notificationDaysBefore': instance.notificationDaysBefore,
      'trialEndDate': instance.trialEndDate?.toIso8601String(),
      'customCycleDetails': instance.customCycleDetails,
      'notes': instance.notes,
    };

const _$BillingCycleEnumMap = {
  BillingCycle.weekly: 'weekly',
  BillingCycle.monthly: 'monthly',
  BillingCycle.quarterly: 'quarterly',
  BillingCycle.biAnnual: 'biAnnual',
  BillingCycle.yearly: 'yearly',
  BillingCycle.custom: 'custom',
};

const _$SubscriptionCategoryEnumMap = {
  SubscriptionCategory.streaming: 'streaming',
  SubscriptionCategory.software: 'software',
  SubscriptionCategory.gaming: 'gaming',
  SubscriptionCategory.fitness: 'fitness',
  SubscriptionCategory.music: 'music',
  SubscriptionCategory.news: 'news',
  SubscriptionCategory.cloud: 'cloud',
  SubscriptionCategory.utilities: 'utilities',
  SubscriptionCategory.education: 'education',
  SubscriptionCategory.other: 'other',
};
