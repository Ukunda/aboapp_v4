import 'package:injectable/injectable.dart';
import '../../data/datasources/email_subscription_datasource.dart';
import '../entities/subscription_suggestion.dart';
import '../../data/models/subscription_suggestion_model.dart';

@lazySingleton
class ScanEmailSubscriptionsUseCase {
  final EmailSubscriptionDataSource dataSource;
  ScanEmailSubscriptionsUseCase(this.dataSource);

  Future<List<SubscriptionSuggestion>> call({
    required String host,
    required int port,
    required bool isSecure,
    required String username,
    required String password,
  }) async {
    final models = await dataSource.fetchSuggestions(
      host: host,
      port: port,
      isSecure: isSecure,
      username: username,
      password: password,
    );
    return models.map((e) => e.toEntity()).toList();
  }
}
