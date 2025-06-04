import 'package:aboapp/features/subscriptions/data/datasources/subscription_local_datasource.dart';
import 'package:aboapp/features/subscriptions/data/models/subscription_model.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/domain/repositories/subscription_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SubscriptionRepository)
class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionLocalDataSource localDataSource;

  SubscriptionRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<List<SubscriptionEntity>> getAllSubscriptions() async {
    try {
      final localSubscriptions = await localDataSource.getAllSubscriptions();
      return localSubscriptions.map((model) => model.toEntity()).toList();
    } catch (e) {
      // print('Error fetching subscriptions: $e'); // Avoid print
      throw Exception('Could not load subscriptions.'); 
    }
  }

  @override
  Future<SubscriptionEntity?> getSubscriptionById(String id) async {
    final allSubscriptions = await getAllSubscriptions();
    try {
      return allSubscriptions.firstWhere((sub) => sub.id == id);
    } catch (e) {
      return null; 
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