import 'package:aboapp/features/subscriptions/data/datasources/subscription_local_datasource.dart';
import 'package:aboapp/features/subscriptions/data/models/subscription_model.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:injectable/injectable.dart';

// For a real app, you might also have a SubscriptionRemoteDataSource if syncing with a backend.
// This implementation only uses the local data source.

@LazySingleton(as: SubscriptionRepository)
class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionLocalDataSource localDataSource;
  // final NetworkInfo networkInfo; // If you had remote data source

  SubscriptionRepositoryImpl({
    required this.localDataSource,
    // required this.networkInfo,
  });

  @override
  Future<List<SubscriptionEntity>> getAllSubscriptions() async {
    try {
      final localSubscriptions = await localDataSource.getAllSubscriptions();
      return localSubscriptions.map((model) => model.toEntity()).toList();
    } catch (e) {
      // Handle exceptions from local data source, e.g., parsing errors
      // You might want to return an empty list or a custom Failure object
      print('Error fetching subscriptions: $e'); // Log error
      throw Exception('Could not load subscriptions.'); // Re-throw as a domain-level error
    }
  }

  @override
  Future<SubscriptionEntity?> getSubscriptionById(String id) async {
    // Local data source might not have a direct getById if it always loads all.
    // If performance becomes an issue with many subscriptions, optimize localDataSource.
    final allSubscriptions = await getAllSubscriptions();
    try {
      return allSubscriptions.firstWhere((sub) => sub.id == id);
    } catch (e) {
      return null; // Not found
    }
  }

  @override
  Future<void> addSubscription(SubscriptionEntity subscription) async {
    final model = SubscriptionModel.fromEntity(subscription);
    await localDataSource.saveSubscription(model);
  }

  @override
  Future<void> updateSubscription(SubscriptionEntity subscription) async {
    final model = SubscriptionModel.fromEntity(subscription);
    await localDataSource.updateSubscription(model);
  }

  @override
  Future<void> deleteSubscription(String id) async {
    await localDataSource.deleteSubscription(id);
  }

  @override
  Future<void> saveAllSubscriptions(List<SubscriptionEntity> subscriptions) async {
    final models = subscriptions.map((e) => SubscriptionModel.fromEntity(e)).toList();
    await localDataSource.cacheSubscriptions(models);
  }
}