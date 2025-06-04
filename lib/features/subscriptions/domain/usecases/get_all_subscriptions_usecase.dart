import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:injectable/injectable.dart';

// Basic use case structure. Can be expanded with parameters if needed (e.g., for filtering).
// For more complex scenarios, consider a generic UseCase class.

@lazySingleton
class GetAllSubscriptionsUseCase {
  final SubscriptionRepository repository;

  GetAllSubscriptionsUseCase(this.repository);

  Future<List<SubscriptionEntity>> call() async {
    // You can add pre-processing or post-processing logic here if necessary.
    return await repository.getAllSubscriptions();
  }
}