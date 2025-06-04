import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class UpdateSubscriptionUseCase {
  final SubscriptionRepository repository;

  UpdateSubscriptionUseCase(this.repository);

  Future<void> call(SubscriptionEntity subscription) async {
    return await repository.updateSubscription(subscription);
  }
}