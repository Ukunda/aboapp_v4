import 'package:aboapp/core/utils/color_serializer.dart'; // We'll create this utility
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:flutter/material.dart'; // For Color
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_model.freezed.dart';
part 'subscription_model.g.dart'; // For JSON serialization

@freezed
class SubscriptionModel with _$SubscriptionModel {
  const SubscriptionModel._(); // Private constructor for custom methods

  // The model fields should mirror the entity, but with JSON annotations.
  // It can also include fields purely for data storage/transfer that are not in the entity.
  @JsonSerializable(explicitToJson: true) // Ensure nested objects are serialized
  const factory SubscriptionModel({
    required String id,
    required String name,
    required double price,
    @JsonKey(unknownEnumValue: JsonKey.nullForUnknownEnumValue) // Handle new/unknown enums gracefully
    required BillingCycle billingCycle,
    required DateTime nextBillingDate,
    @JsonKey(unknownEnumValue: JsonKey.nullForUnknownEnumValue)
    required SubscriptionCategory category,
    DateTime? startDate,
    String? description,
    String? logoUrl,
    @ColorSerializer() Color? color, // Custom serializer for Color
    @Default(true) bool isActive,
    @Default(true) bool notificationsEnabled,
    @Default(7) int notificationDaysBefore,
    DateTime? trialEndDate,
    Map<String, dynamic>? customCycleDetails,
    String? notes,
  }) = _SubscriptionModel;

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionModelFromJson(json);

  // Conversion to Domain Entity
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

  // Conversion from Domain Entity
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
}