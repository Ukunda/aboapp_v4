// lib/features/subscriptions/data/models/subscription_model.dart

import 'package:aboapp/core/utils/color_serializer.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_model.freezed.dart';
part 'subscription_model.g.dart';

@freezed
class SubscriptionModel with _$SubscriptionModel {
  const SubscriptionModel._();

  // FIX: Die @JsonKey-Annotationen sind jetzt korrekt an den Parametern platziert.
  const factory SubscriptionModel({
    required String id,
    required String name,
    required double price,
    @JsonKey(unknownEnumValue: BillingCycle.custom) required BillingCycle billingCycle,
    required DateTime nextBillingDate,
    @JsonKey(unknownEnumValue: SubscriptionCategory.other) required SubscriptionCategory category,
    DateTime? startDate,
    String? description,
    String? logoUrl,
    @ColorSerializer() Color? color,
    @Default(true) bool isActive,
    @Default(true) bool notificationsEnabled,
    @Default(7) int notificationDaysBefore,
    DateTime? trialEndDate,
    Map<String, dynamic>? customCycleDetails,
    String? notes,
  }) = _SubscriptionModel;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  factory SubscriptionModel.fromEntity(SubscriptionEntity entity) {
    return SubscriptionModel(
      id: entity.id,
      name: entity.name,
      price: entity.price,
      billingCycle: entity.billingCycle,
      nextBillingDate: entity.nextBillingDate,
      category: entity.category,
      startDate: entity.startDate,
      description: entity.description,
      logoUrl: entity.logoUrl,
      color: entity.color,
      isActive: entity.isActive,
      notificationsEnabled: entity.notificationsEnabled,
      notificationDaysBefore: entity.notificationDaysBefore,
      trialEndDate: entity.trialEndDate,
      customCycleDetails: entity.customCycleDetails,
      notes: entity.notes,
    );
  }

  SubscriptionEntity toEntity() {
    return SubscriptionEntity(
      id: id,
      name: name,
      price: price,
      billingCycle: billingCycle,
      nextBillingDate: nextBillingDate,
      category: category,
      startDate: startDate,
      description: description,
      logoUrl: logoUrl,
      color: color,
      isActive: isActive,
      notificationsEnabled: notificationsEnabled,
      notificationDaysBefore: notificationDaysBefore,
      trialEndDate: trialEndDate,
      customCycleDetails: customCycleDetails,
      notes: notes,
    );
  }
}
