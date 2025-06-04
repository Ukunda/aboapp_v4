import 'package:aboapp/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class DeleteSubscriptionUseCase {
  final SubscriptionRepository repository;

  DeleteSubscriptionUseCase(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteSubscription(id);
  }
}