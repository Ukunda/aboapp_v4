// lib/features/subscriptions/presentation/cubit/subscription_cubit.dart
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/add_subscription_usecase.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/delete_subscription_usecase.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/get_all_subscriptions_usecase.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/update_subscription_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';

part 'subscription_state.dart';
part 'subscription_cubit.freezed.dart';

@injectable
class SubscriptionCubit extends Cubit<SubscriptionState> {
  final GetAllSubscriptionsUseCase _getAllSubscriptions;
  final AddSubscriptionUseCase _addSubscription;
  final UpdateSubscriptionUseCase _updateSubscription;
  final DeleteSubscriptionUseCase _deleteSubscription;
  final Uuid _uuid;

  List<SubscriptionEntity> _masterSubscriptionList = [];

  SubscriptionCubit(
    this._getAllSubscriptions,
    this._addSubscription,
    this._updateSubscription,
    this._deleteSubscription,
    this._uuid,
  ) : super(const SubscriptionState.initial());

  Future<void> loadSubscriptions() async {
    emit(const SubscriptionState.loading());
    try {
      _masterSubscriptionList = await _getAllSubscriptions();
      _applyFiltersAndSort();
    } catch (e) {
      emit(SubscriptionState.error(message: e.toString()));
    }
  }

  Future<void> addSubscription(SubscriptionEntity subscription) async {
    final subToAdd = subscription.id.isEmpty
        ? subscription.copyWith(id: _uuid.v4())
        : subscription;
    emit(const SubscriptionState.loading());
    try {
      await _addSubscription(subToAdd);
      _masterSubscriptionList.add(subToAdd);
      _applyFiltersAndSort();
    } catch (e) {
      emit(SubscriptionState.error(
          message: "Failed to add subscription: ${e.toString()}"));
      _applyFiltersAndSort();
    }
  }

  Future<void> updateSubscription(SubscriptionEntity subscription) async {
    emit(const SubscriptionState.loading());
    try {
      await _updateSubscription(subscription);
      final index =
          _masterSubscriptionList.indexWhere((s) => s.id == subscription.id);
      if (index != -1) {
        _masterSubscriptionList[index] = subscription;
      } else {
        _masterSubscriptionList.add(subscription);
      }
      _applyFiltersAndSort();
    } catch (e) {
      emit(SubscriptionState.error(
          message: "Failed to update subscription: ${e.toString()}"));
      _applyFiltersAndSort();
    }
  }

  Future<void> deleteSubscription(String id) async {
    emit(const SubscriptionState.loading());
    try {
      await _deleteSubscription(id);
      _masterSubscriptionList.removeWhere((s) => s.id == id);
      _applyFiltersAndSort();
    } catch (e) {
      emit(SubscriptionState.error(
          message: "Failed to delete subscription: ${e.toString()}"));
      _applyFiltersAndSort();
    }
  }

  Future<void> toggleSubscriptionActiveStatus(String id) async {
    final index = _masterSubscriptionList.indexWhere((s) => s.id == id);
    if (index != -1) {
      final sub = _masterSubscriptionList[index];
      final updatedSub = sub.copyWith(isActive: !sub.isActive);
      await updateSubscription(updatedSub);
    }
  }

  Future<void> toggleSubscriptionNotification(String id) async {
    final index = _masterSubscriptionList.indexWhere((s) => s.id == id);
    if (index != -1) {
      final sub = _masterSubscriptionList[index];
      final updatedSub =
          sub.copyWith(notificationsEnabled: !sub.notificationsEnabled);
      await updateSubscription(updatedSub);
    }
  }

  void _applyFiltersAndSort({
    SortOption? newSortOption,
    List<SubscriptionCategory>? newFilterCategories,
    List<BillingCycle>? newFilterBillingCycles,
    String? newSearchTerm,
    bool clearSearch = false,
    bool clearCategories = false,
    bool clearBillingCycles = false,
  }) {
    final currentState = state.maybeWhen(
      loaded: (alls, filters, sort, cats, bills, search) => state as _Loaded,
      orElse: () => null,
    );

    SortOption currentSortOption = newSortOption ??
        currentState?.currentSortOption ??
        SortOption.nextBillingDateAsc;
    List<SubscriptionCategory> currentFilterCategories =
        newFilterCategories ?? currentState?.filterCategories ?? [];
    List<BillingCycle> currentFilterBillingCycles =
        newFilterBillingCycles ?? currentState?.filterBillingCycles ?? [];
    String? currentSearchTerm = newSearchTerm ?? currentState?.searchTerm;

    if (clearSearch) currentSearchTerm = null;
    if (clearCategories) currentFilterCategories = [];
    if (clearBillingCycles) currentFilterBillingCycles = [];

    List<SubscriptionEntity> filtered = List.from(_masterSubscriptionList);

    if (currentSearchTerm != null && currentSearchTerm.isNotEmpty) {
      final query = currentSearchTerm.toLowerCase();
      filtered = filtered
          .where((sub) =>
              sub.name.toLowerCase().contains(query) ||
              (sub.description?.toLowerCase().contains(query) ?? false))
          .toList();
    }

    if (currentFilterCategories.isNotEmpty) {
      filtered = filtered
          .where((sub) => currentFilterCategories.contains(sub.category))
          .toList();
    }

    if (currentFilterBillingCycles.isNotEmpty) {
      filtered = filtered
          .where((sub) => currentFilterBillingCycles.contains(sub.billingCycle))
          .toList();
    }

    switch (currentSortOption) {
      case SortOption.nameAsc:
        filtered.sort(
            (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
        break;
      case SortOption.nameDesc:
        filtered.sort(
            (a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
        break;
      case SortOption.priceAsc:
        filtered.sort((a, b) =>
            a.monthlyEquivalentPrice.compareTo(b.monthlyEquivalentPrice));
        break;
      case SortOption.priceDesc:
        filtered.sort((a, b) =>
            b.monthlyEquivalentPrice.compareTo(a.monthlyEquivalentPrice));
        break;
      case SortOption.nextBillingDateAsc:
        filtered.sort((a, b) => a.nextBillingDate.compareTo(b.nextBillingDate));
        break;
      case SortOption.nextBillingDateDesc:
        filtered.sort((a, b) => b.nextBillingDate.compareTo(a.nextBillingDate));
        break;
      case SortOption.category:
        filtered.sort((a, b) => a.category.index.compareTo(b.category.index));
        break;
    }

    emit(SubscriptionState.loaded(
      allSubscriptions: _masterSubscriptionList,
      filteredSubscriptions: filtered,
      currentSortOption: currentSortOption,
      filterCategories: currentFilterCategories,
      filterBillingCycles: currentFilterBillingCycles,
      searchTerm: currentSearchTerm,
    ));
  }

  void changeSortOption(SortOption option) {
    _applyFiltersAndSort(newSortOption: option);
  }

  void toggleCategoryFilter(SubscriptionCategory category) {
    final currentState = state.maybeWhen(
      loaded: (alls, filters, sort, cats, bills, search) => state as _Loaded,
      orElse: () => null,
    );
    if (currentState == null) return;

    List<SubscriptionCategory> currentCats =
        List.from(currentState.filterCategories ?? []);

    if (currentCats.contains(category)) {
      currentCats.remove(category);
    } else {
      currentCats.add(category);
    }
    _applyFiltersAndSort(newFilterCategories: currentCats);
  }

  void toggleBillingCycleFilter(BillingCycle cycle) {
    final currentState = state.maybeWhen(
      loaded: (alls, filters, sort, cats, bills, search) => state as _Loaded,
      orElse: () => null,
    );
    if (currentState == null) return;

    List<BillingCycle> currentCycles =
        List.from(currentState.filterBillingCycles ?? []);

    if (currentCycles.contains(cycle)) {
      currentCycles.remove(cycle);
    } else {
      currentCycles.add(cycle);
    }
    _applyFiltersAndSort(newFilterBillingCycles: currentCycles);
  }

  void searchSubscriptions(String searchTerm) {
    _applyFiltersAndSort(newSearchTerm: searchTerm);
  }

  void clearSearch() {
    _applyFiltersAndSort(clearSearch: true, newSearchTerm: '');
  }

  void clearCategoryFilters() {
    _applyFiltersAndSort(clearCategories: true);
  }

  void clearBillingCycleFilters() {
    _applyFiltersAndSort(clearBillingCycles: true);
  }

  void clearAllFilters() {
    _applyFiltersAndSort(
      clearCategories: true,
      clearBillingCycles: true,
      newSearchTerm: '',
      clearSearch: true,
    );
  }

  void setCategoryFilters(List<SubscriptionCategory> categories) {
    _applyFiltersAndSort(newFilterCategories: categories);
  }

  void setBillingCycleFilters(List<BillingCycle> cycles) {
    _applyFiltersAndSort(newFilterBillingCycles: cycles);
  }
}
