part of 'subscription_suggestion_cubit.dart';

@freezed
class SubscriptionSuggestionState with _$SubscriptionSuggestionState {
  const factory SubscriptionSuggestionState.initial() = _Initial;
  const factory SubscriptionSuggestionState.loading() = _Loading;
  const factory SubscriptionSuggestionState.loaded(List<SubscriptionSuggestion> suggestions) = _Loaded;
  const factory SubscriptionSuggestionState.empty() = _Empty;
  const factory SubscriptionSuggestionState.error(String message) = _Error;
}
