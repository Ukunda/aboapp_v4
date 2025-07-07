// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_suggestion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SubscriptionSuggestion {
  String get service => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  BillingCycle get cycle => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionSuggestionCopyWith<SubscriptionSuggestion> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionSuggestionCopyWith<$Res> {
  factory $SubscriptionSuggestionCopyWith(SubscriptionSuggestion value,
          $Res Function(SubscriptionSuggestion) then) =
      _$SubscriptionSuggestionCopyWithImpl<$Res, SubscriptionSuggestion>;
  @useResult
  $Res call({String service, double amount, BillingCycle cycle});
}

/// @nodoc
class _$SubscriptionSuggestionCopyWithImpl<$Res,
        $Val extends SubscriptionSuggestion>
    implements $SubscriptionSuggestionCopyWith<$Res> {
  _$SubscriptionSuggestionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? service = null,
    Object? amount = null,
    Object? cycle = null,
  }) {
    return _then(_value.copyWith(
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      cycle: null == cycle
          ? _value.cycle
          : cycle // ignore: cast_nullable_to_non_nullable
              as BillingCycle,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubscriptionSuggestionImplCopyWith<$Res>
    implements $SubscriptionSuggestionCopyWith<$Res> {
  factory _$$SubscriptionSuggestionImplCopyWith(
          _$SubscriptionSuggestionImpl value,
          $Res Function(_$SubscriptionSuggestionImpl) then) =
      __$$SubscriptionSuggestionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String service, double amount, BillingCycle cycle});
}

/// @nodoc
class __$$SubscriptionSuggestionImplCopyWithImpl<$Res>
    extends _$SubscriptionSuggestionCopyWithImpl<$Res,
        _$SubscriptionSuggestionImpl>
    implements _$$SubscriptionSuggestionImplCopyWith<$Res> {
  __$$SubscriptionSuggestionImplCopyWithImpl(
      _$SubscriptionSuggestionImpl _value,
      $Res Function(_$SubscriptionSuggestionImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? service = null,
    Object? amount = null,
    Object? cycle = null,
  }) {
    return _then(_$SubscriptionSuggestionImpl(
      service: null == service
          ? _value.service
          : service // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      cycle: null == cycle
          ? _value.cycle
          : cycle // ignore: cast_nullable_to_non_nullable
              as BillingCycle,
    ));
  }
}

/// @nodoc

class _$SubscriptionSuggestionImpl implements _SubscriptionSuggestion {
  const _$SubscriptionSuggestionImpl(
      {required this.service, required this.amount, required this.cycle});

  @override
  final String service;
  @override
  final double amount;
  @override
  final BillingCycle cycle;

  @override
  String toString() {
    return 'SubscriptionSuggestion(service: $service, amount: $amount, cycle: $cycle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionSuggestionImpl &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.cycle, cycle) || other.cycle == cycle));
  }

  @override
  int get hashCode => Object.hash(runtimeType, service, amount, cycle);

  /// Create a copy of SubscriptionSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionSuggestionImplCopyWith<_$SubscriptionSuggestionImpl>
      get copyWith => __$$SubscriptionSuggestionImplCopyWithImpl<
          _$SubscriptionSuggestionImpl>(this, _$identity);
}

abstract class _SubscriptionSuggestion implements SubscriptionSuggestion {
  const factory _SubscriptionSuggestion(
      {required final String service,
      required final double amount,
      required final BillingCycle cycle}) = _$SubscriptionSuggestionImpl;

  @override
  String get service;
  @override
  double get amount;
  @override
  BillingCycle get cycle;

  /// Create a copy of SubscriptionSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionSuggestionImplCopyWith<_$SubscriptionSuggestionImpl>
      get copyWith => throw _privateConstructorUsedError;
}
