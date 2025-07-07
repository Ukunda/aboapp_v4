import 'package:flutter_test/flutter_test.dart';
import 'package:aboapp/features/subscriptions/presentation/cubit/subscription_suggestion_cubit.dart';
import 'package:aboapp/features/subscriptions/domain/usecases/scan_email_subscriptions_usecase.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_suggestion.dart';
import 'package:aboapp/features/subscriptions/domain/entities/subscription_entity.dart';
import 'package:aboapp/features/subscriptions/data/datasources/email_subscription_datasource.dart';
import 'package:aboapp/features/subscriptions/data/models/subscription_suggestion_model.dart';

class FakeDataSource implements EmailSubscriptionDataSource {
  @override
  Future<List<SubscriptionSuggestionModel>> fetchSuggestions({
    required String host,
    required int port,
    required bool isSecure,
    required String username,
    required String password,
  }) async => [];

  @override
  SubscriptionSuggestionModel? parseEmail(String text) => null;
}

class FakeUseCase extends ScanEmailSubscriptionsUseCase {
  final List<SubscriptionSuggestion> suggestions;
  FakeUseCase(this.suggestions) : super(FakeDataSource());

  @override
  Future<List<SubscriptionSuggestion>> call({
    required String host,
    required int port,
    required bool isSecure,
    required String username,
    required String password,
  }) async => suggestions;
}

void main() {
  test('emits loaded state with suggestions', () async {
    final useCase = FakeUseCase([
      const SubscriptionSuggestion(service: 'Netflix', amount: 9.99, cycle: BillingCycle.monthly),
    ]);
    final cubit = SubscriptionSuggestionCubit(useCase);

    await cubit.scan(host: '', port: 0, isSecure: true, username: '', password: '');

    expect(cubit.state, SubscriptionSuggestionState.loaded(useCase.suggestions));
  });
}
