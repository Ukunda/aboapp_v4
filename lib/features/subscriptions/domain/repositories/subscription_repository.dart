import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
// Using a Either for functional error handling is a good practice, but for simplicity,
// we can use Futures that might throw exceptions, to be handled by the BLoC/Cubit.
// import 'package:dartz/dartz.dart'; // For Either
// import 'package:aboapp/core/error/failures.dart'; // Custom failure types

abstract class SubscriptionRepository {
  Future<List<SubscriptionEntity>> getAllSubscriptions();
  Future<SubscriptionEntity?> getSubscriptionById(String id);
  Future<void> addSubscription(SubscriptionEntity subscription);
  Future<void> updateSubscription(SubscriptionEntity subscription);
  Future<void> deleteSubscription(String id);
  Future<void> saveAllSubscriptions(List<SubscriptionEntity> subscriptions); // For bulk operations if needed
}