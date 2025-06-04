import 'package:flutter/material.dart'; 
import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_entity.freezed.dart'; 

enum BillingCycle {
  weekly,
  monthly,
  quarterly,
  biAnnual, 
  yearly,
  custom, 
}

enum SubscriptionCategory {
  streaming,
  software,
  gaming,
  fitness,
  music,
  news,
  cloud,
  utilities, 
  education, 
  other,
}

@freezed
class SubscriptionEntity with _$SubscriptionEntity {
  const SubscriptionEntity._(); 

  const factory SubscriptionEntity({
    required String id,
    required String name,
    required double price, 
    required BillingCycle billingCycle,
    required DateTime nextBillingDate,
    required SubscriptionCategory category,
    DateTime? startDate,
    String? description,
    String? logoUrl, 
    Color? color,     
    @Default(true) bool isActive,
    @Default(true) bool notificationsEnabled,
    @Default(7) int notificationDaysBefore,
    DateTime? trialEndDate,
    Map<String, dynamic>? customCycleDetails, 
    String? notes, 
  }) = _SubscriptionEntity;

  bool get isInTrial {
    if (trialEndDate == null) return false;
    return DateTime.now().isBefore(trialEndDate!);
  }

  int get daysUntilBilling {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final nextBillingDay = DateTime(nextBillingDate.year, nextBillingDate.month, nextBillingDate.day);
    return nextBillingDay.difference(today).inDays;
  }

  double get monthlyEquivalentPrice {
    switch (billingCycle) {
      case BillingCycle.weekly:
        return price * (365.25 / 12 / 7); 
      case BillingCycle.monthly:
        return price;
      case BillingCycle.quarterly:
        return price / 3.0;
      case BillingCycle.biAnnual:
        return price / 6.0;
      case BillingCycle.yearly:
        return price / 12.0;
      case BillingCycle.custom:
        final days = customCycleDetails?['value'] as int?;
        if (days != null && days > 0) {
          return price * (30.4375 / days); 
        }
        return price; 
      // No default needed if all cases are covered, but good for safety if enum changes.
      // However, the linter for unreachable_switch_default will trigger if all are covered.
      // Removing default as the error was for it being unreachable.
    }
  }
}

// Moved extensions for SubscriptionCategory to subscription_card_widget.dart
// to keep entity cleaner and consolidate UI helpers.