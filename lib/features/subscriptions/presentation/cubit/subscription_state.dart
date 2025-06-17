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
  String displayName(BuildContext context) {
    switch (this) {
      case SortOption.nameAsc:
        return context.l10n.translate('sort_option_nameAsc');
      case SortOption.nameDesc:
        return context.l10n.translate('sort_option_nameDesc');
      case SortOption.priceAsc:
        return context.l10n.translate('sort_option_priceAsc');
      case SortOption.priceDesc:
        return context.l10n.translate('sort_option_priceDesc');
      case SortOption.nextBillingDateAsc:
        return context.l10n.translate('sort_option_nextBillingDateAsc');
      case SortOption.nextBillingDateDesc:
        return context.l10n.translate('sort_option_nextBillingDateDesc');
      case SortOption.category:
        return context.l10n.translate('sort_option_category');
    }
  }
}
