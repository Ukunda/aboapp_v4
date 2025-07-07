import 'package:flutter_test/flutter_test.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_cubit.dart';
import 'package:aboapp/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/get_all_subscriptions_usecase.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/add_subscription_usecase.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/update_subscription_usecase.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/delete_subscription_usecase.dart';
import 'package:uuid/uuid.dart';

class FakeSubscriptionRepository implements SubscriptionRepository {
  List<SubscriptionEntity> subs;
  FakeSubscriptionRepository({required this.subs});

  @override
  Future<void> addSubscription(SubscriptionEntity subscription) async {
    subs.add(subscription);
  }

  @override
  Future<void> deleteSubscription(String id) async {
    subs.removeWhere((s) => s.id == id);
  }

  @override
  Future<List<SubscriptionEntity>> getAllSubscriptions() async => List.from(subs);

  @override
  Future<SubscriptionEntity?> getSubscriptionById(String id) async {
    try {
      return subs.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> saveAllSubscriptions(List<SubscriptionEntity> subscriptions) async {
    subs = subscriptions;
  }

  @override
  Future<void> updateSubscription(SubscriptionEntity subscription) async {
    final index = subs.indexWhere((s) => s.id == subscription.id);
    if (index != -1) {
      subs[index] = subscription;
    } else {
      subs.add(subscription);
    }
  }
}

void main() {
  group('SubscriptionCubit', () {
    late FakeSubscriptionRepository repository;
    late SubscriptionCubit cubit;
    late SubscriptionEntity subA;
    late SubscriptionEntity subB;

    setUp(() {
      subA = SubscriptionEntity(
        id: 'a',
        name: 'A',
        price: 10,
        billingCycle: BillingCycle.monthly,
        nextBillingDate: DateTime(2025, 1, 1),
        category: SubscriptionCategory.streaming,
      );
      subB = SubscriptionEntity(
        id: 'b',
        name: 'B',
        price: 5,
        billingCycle: BillingCycle.yearly,
        nextBillingDate: DateTime(2024, 12, 1),
        category: SubscriptionCategory.software,
        isActive: false,
      );
      repository = FakeSubscriptionRepository(subs: [subA, subB]);
      cubit = SubscriptionCubit(
        GetAllSubscriptionsUseCase(repository),
        AddSubscriptionUseCase(repository),
        UpdateSubscriptionUseCase(repository),
        DeleteSubscriptionUseCase(repository),
        const Uuid(),
      );
    });

    test('loadSubscriptions loads and sorts subscriptions', () async {
      await cubit.loadSubscriptions();

      cubit.state.maybeWhen(
        loaded: (all, filtered, sort, cats, bills, search) {
          expect(all.length, 2);
          expect(filtered.first.id, 'b'); // earliest nextBillingDate comes first
          expect(sort, SortOption.nextBillingDateAsc);
        },
        orElse: () => fail('State should be loaded'),
      );
    });

    test('addSubscription adds to list', () async {
      await cubit.loadSubscriptions();
      final newSub = subA.copyWith(id: '', name: 'C');
      await cubit.addSubscription(newSub);

      cubit.state.maybeWhen(
        loaded: (all, filtered, sort, cats, bills, search) {
          expect(all.length, 3);
          expect(all.any((s) => s.name == 'C'), isTrue);
        },
        orElse: () => fail('State should be loaded'),
      );
      expect(repository.subs.length, 3);
    });

    test('toggleSubscriptionActiveStatus updates subscription', () async {
      await cubit.loadSubscriptions();
      await cubit.toggleSubscriptionActiveStatus('a');

      final updated = repository.subs.firstWhere((s) => s.id == 'a');
      expect(updated.isActive, isFalse);
      cubit.state.maybeWhen(
        loaded: (all, filtered, sort, cats, bills, search) {
          final cubitSub = all.firstWhere((s) => s.id == 'a');
          expect(cubitSub.isActive, isFalse);
        },
        orElse: () => fail('State should be loaded'),
      );
    });
  });
}
