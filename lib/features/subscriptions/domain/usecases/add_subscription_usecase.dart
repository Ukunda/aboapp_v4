import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AddSubscriptionUseCase {
  final SubscriptionRepository repository;

  AddSubscriptionUseCase(this.repository);

  Future<void> call(SubscriptionEntity subscription) async {
    // Business logic before adding, e.g., validation, could go here.
    // However, complex validation is often better handled in the entity or BLoC/Cubit.
    return await repository.addSubscription(subscription);
  }
}