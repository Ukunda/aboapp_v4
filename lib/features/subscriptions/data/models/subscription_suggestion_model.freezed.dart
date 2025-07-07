// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_suggestion_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubscriptionSuggestionModel _$SubscriptionSuggestionModelFromJson(
    Map<String, dynamic> json) {
  return _SubscriptionSuggestionModel.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionSuggestionModel {
  String get service => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  BillingCycle get cycle => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionSuggestionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionSuggestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionSuggestionModelCopyWith<SubscriptionSuggestionModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionSuggestionModelCopyWith<$Res> {
  factory $SubscriptionSuggestionModelCopyWith(
          SubscriptionSuggestionModel value,
          $Res Function(SubscriptionSuggestionModel) then) =
      _$SubscriptionSuggestionModelCopyWithImpl<$Res,
          SubscriptionSuggestionModel>;
  @useResult
  $Res call({String service, double amount, BillingCycle cycle});
}

/// @nodoc
class _$SubscriptionSuggestionModelCopyWithImpl<$Res,
        $Val extends SubscriptionSuggestionModel>
    implements $SubscriptionSuggestionModelCopyWith<$Res> {
  _$SubscriptionSuggestionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionSuggestionModel
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
abstract class _$$SubscriptionSuggestionModelImplCopyWith<$Res>
    implements $SubscriptionSuggestionModelCopyWith<$Res> {
  factory _$$SubscriptionSuggestionModelImplCopyWith(
          _$SubscriptionSuggestionModelImpl value,
          $Res Function(_$SubscriptionSuggestionModelImpl) then) =
      __$$SubscriptionSuggestionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String service, double amount, BillingCycle cycle});
}

/// @nodoc
class __$$SubscriptionSuggestionModelImplCopyWithImpl<$Res>
    extends _$SubscriptionSuggestionModelCopyWithImpl<$Res,
        _$SubscriptionSuggestionModelImpl>
    implements _$$SubscriptionSuggestionModelImplCopyWith<$Res> {
  __$$SubscriptionSuggestionModelImplCopyWithImpl(
      _$SubscriptionSuggestionModelImpl _value,
      $Res Function(_$SubscriptionSuggestionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionSuggestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? service = null,
    Object? amount = null,
    Object? cycle = null,
  }) {
    return _then(_$SubscriptionSuggestionModelImpl(
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
@JsonSerializable()
class _$SubscriptionSuggestionModelImpl
    implements _SubscriptionSuggestionModel {
  const _$SubscriptionSuggestionModelImpl(
      {required this.service, required this.amount, required this.cycle});

  factory _$SubscriptionSuggestionModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$SubscriptionSuggestionModelImplFromJson(json);

  @override
  final String service;
  @override
  final double amount;
  @override
  final BillingCycle cycle;

  @override
  String toString() {
    return 'SubscriptionSuggestionModel(service: $service, amount: $amount, cycle: $cycle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionSuggestionModelImpl &&
            (identical(other.service, service) || other.service == service) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.cycle, cycle) || other.cycle == cycle));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, service, amount, cycle);

  /// Create a copy of SubscriptionSuggestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionSuggestionModelImplCopyWith<_$SubscriptionSuggestionModelImpl>
      get copyWith => __$$SubscriptionSuggestionModelImplCopyWithImpl<
          _$SubscriptionSuggestionModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionSuggestionModelImplToJson(
      this,
    );
  }
}

abstract class _SubscriptionSuggestionModel
    implements SubscriptionSuggestionModel {
  const factory _SubscriptionSuggestionModel(
      {required final String service,
      required final double amount,
      required final BillingCycle cycle}) = _$SubscriptionSuggestionModelImpl;

  factory _SubscriptionSuggestionModel.fromJson(Map<String, dynamic> json) =
      _$SubscriptionSuggestionModelImpl.fromJson;

  @override
  String get service;
  @override
  double get amount;
  @override
  BillingCycle get cycle;

  /// Create a copy of SubscriptionSuggestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionSuggestionModelImplCopyWith<_$SubscriptionSuggestionModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
