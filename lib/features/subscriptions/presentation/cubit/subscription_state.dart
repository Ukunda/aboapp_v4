// lib/features/subscriptions/presentation/cubit/subscription_state.dart
part of 'subscription_cubit.dart';

@freezed
class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState.initial() = _Initial;
  const factory SubscriptionState.loading() = _Loading;
  const factory SubscriptionState.loaded({
    required List<SubscriptionEntity> allSubscriptions,
    required List<SubscriptionEntity> filteredSubscriptions,
    SortOption? currentSortOption,
    List<SubscriptionCategory>? filterCategories,
    List<BillingCycle>? filterBillingCycles, // NEU: Liste für Zyklen
    String? searchTerm,
  }) = _Loaded;
  const factory SubscriptionState.error({required String message}) = _Error;
}

enum SortOption {
  nameAsc,
  nameDesc,
  priceAsc,
  priceDesc,
  nextBillingDateAsc,
  nextBillingDateDesc,
  category
}

extension SortOptionDisplay on SortOption {
  String get displayName {
    switch (this) {
      case SortOption.nameAsc:
        return 'Name (A-Z)';
      case SortOption.nameDesc:
        return 'Name (Z-A)';
      case SortOption.priceAsc:
        return 'Price (Low-High)';
      case SortOption.priceDesc:
        return 'Price (High-Low)';
      case SortOption.nextBillingDateAsc:
        return 'Next Billing Date';
      case SortOption.nextBillingDateDesc:
        return 'Next Billing Date (Desc)';
      case SortOption.category:
        return 'Category';
    }
  }
}
