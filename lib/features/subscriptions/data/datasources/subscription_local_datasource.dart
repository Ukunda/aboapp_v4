import 'dart:convert';
import 'package:aboapp/features/subscriptions/data/models/subscription_model.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SubscriptionLocalDataSource {
  Future<List<SubscriptionModel>> getAllSubscriptions();
  Future<void> saveSubscription(SubscriptionModel subscription);
  Future<void> deleteSubscription(String id);
  Future<void> updateSubscription(SubscriptionModel subscription);
  Future<void> cacheSubscriptions(List<SubscriptionModel> subscriptions);
}

const String cachedSubscriptionsKey = 'CACHED_SUBSCRIPTIONS';

@LazySingleton(as: SubscriptionLocalDataSource)
class SubscriptionLocalDataSourceImpl implements SubscriptionLocalDataSource {
  final FlutterSecureStorage secureStorage;

  SubscriptionLocalDataSourceImpl(this.secureStorage);

  @override
  Future<List<SubscriptionModel>> getAllSubscriptions() async {
    final jsonString = await secureStorage.read(key: cachedSubscriptionsKey);
    if (jsonString != null) {
      try {
        final List<dynamic> decoded = jsonDecode(jsonString) as List<dynamic>;
        return decoded
            .map((json) => SubscriptionModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } catch (e) {
        // Handle corrupted data, e.g., by clearing it or logging
        await secureStorage.delete(key: cachedSubscriptionsKey);
        throw Exception('Failed to parse subscriptions from local storage: $e');
      }
    } else {
      return [];
    }
  }

  @override
  Future<void> cacheSubscriptions(List<SubscriptionModel> subscriptions) async {
    final jsonString =
        jsonEncode(subscriptions.map((sub) => sub.toJson()).toList());
    await secureStorage.write(key: cachedSubscriptionsKey, value: jsonString);
  }

  @override
  Future<void> saveSubscription(SubscriptionModel subscription) async {
    final subscriptions = await getAllSubscriptions();
    subscriptions.add(subscription);
    await cacheSubscriptions(subscriptions);
  }

  @override
  Future<void> updateSubscription(SubscriptionModel subscription) async {
    final subscriptions = await getAllSubscriptions();
    final index = subscriptions.indexWhere((sub) => sub.id == subscription.id);
    if (index != -1) {
      subscriptions[index] = subscription;
      await cacheSubscriptions(subscriptions);
    } else {
      // Optionally handle case where subscription to update is not found
      // For now, it just won't do anything if not found.
      // Or, throw an exception:
      // throw Exception('Subscription with id ${subscription.id} not found for update.');
    }
  }

  @override
  Future<void> deleteSubscription(String id) async {
    final subscriptions = await getAllSubscriptions();
    subscriptions.removeWhere((sub) => sub.id == id);
    await cacheSubscriptions(subscriptions);
  }
}