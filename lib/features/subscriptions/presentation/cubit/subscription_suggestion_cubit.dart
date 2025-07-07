import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/subscription_suggestion.dart';
import '../../domain/usecases/scan_email_subscriptions_usecase.dart';

part 'subscription_suggestion_state.dart';
part 'subscription_suggestion_cubit.freezed.dart';

@injectable
class SubscriptionSuggestionCubit extends Cubit<SubscriptionSuggestionState> {
  final ScanEmailSubscriptionsUseCase _useCase;
  SubscriptionSuggestionCubit(this._useCase)
      : super(const SubscriptionSuggestionState.initial());

  Future<void> scan({
    required String host,
    required int port,
    required bool isSecure,
    required String username,
    required String password,
  }) async {
    emit(const SubscriptionSuggestionState.loading());
    try {
      final suggestions = await _useCase(
        host: host,
        port: port,
        isSecure: isSecure,
        username: username,
        password: password,
      );
      if (suggestions.isEmpty) {
        emit(const SubscriptionSuggestionState.empty());
      } else {
        emit(SubscriptionSuggestionState.loaded(suggestions));
      }
    } catch (e) {
      emit(SubscriptionSuggestionState.error(e.toString()));
    }
  }
}
