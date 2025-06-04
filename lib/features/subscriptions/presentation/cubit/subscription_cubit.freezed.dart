// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SubscriptionState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<SubscriptionEntity> allSubscriptions,
            List<SubscriptionEntity> filteredSubscriptions,
            SortOption? currentSortOption,
            SubscriptionCategory? filterCategory,
            BillingCycle? filterBillingCycle,
            String? searchTerm)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<SubscriptionEntity> allSubscriptions,
            List<SubscriptionEntity> filteredSubscriptions,
            SortOption? currentSortOption,
            SubscriptionCategory? filterCategory,
            BillingCycle? filterBillingCycle,
            String? searchTerm)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<SubscriptionEntity> allSubscriptions,
            List<SubscriptionEntity> filteredSubscriptions,
            SortOption? currentSortOption,
            SubscriptionCategory? filterCategory,
            BillingCycle? filterBillingCycle,
            String? searchTerm)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionStateCopyWith<$Res> {
  factory $SubscriptionStateCopyWith(
          SubscriptionState value, $Res Function(SubscriptionState) then) =
      _$SubscriptionStateCopyWithImpl<$Res, SubscriptionState>;
}

/// @nodoc
class _$SubscriptionStateCopyWithImpl<$Res, $Val extends SubscriptionState>
    implements $SubscriptionStateCopyWith<$Res> {
  _$SubscriptionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$InitialImplCopyWith<$Res> {
  factory _$$InitialImplCopyWith(
          _$InitialImpl value, $Res Function(_$InitialImpl) then) =
      __$$InitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InitialImplCopyWithImpl<$Res>
    extends _$SubscriptionStateCopyWithImpl<$Res, _$InitialImpl>
    implements _$$InitialImplCopyWith<$Res> {
  __$$InitialImplCopyWithImpl(
      _$InitialImpl _value, $Res Function(_$InitialImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InitialImpl implements _Initial {
  const _$InitialImpl();

  @override
  String toString() {
    return 'SubscriptionState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$InitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<SubscriptionEntity> allSubscriptions,
            List<SubscriptionEntity> filteredSubscriptions,
            SortOption? currentSortOption,
            SubscriptionCategory? filterCategory,
            BillingCycle? filterBillingCycle,
            String? searchTerm)
        loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<SubscriptionEntity> allSubscriptions,
            List<SubscriptionEntity> filteredSubscriptions,
            SortOption? currentSortOption,
            SubscriptionCategory? filterCategory,
            BillingCycle? filterBillingCycle,
            String? searchTerm)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<SubscriptionEntity> allSubscriptions,
            List<SubscriptionEntity> filteredSubscriptions,
            SortOption? currentSortOption,
            SubscriptionCategory? filterCategory,
            BillingCycle? filterBillingCycle,
            String? searchTerm)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements SubscriptionState {
  const factory _Initial() = _$InitialImpl;
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$SubscriptionStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'SubscriptionState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<SubscriptionEntity> allSubscriptions,
            List<SubscriptionEntity> filteredSubscriptions,
            SortOption? currentSortOption,
            SubscriptionCategory? filterCategory,
            BillingCycle? filterBillingCycle,
            String? searchTerm)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<SubscriptionEntity> allSubscriptions,
            List<SubscriptionEntity> filteredSubscriptions,
            SortOption? currentSortOption,
            SubscriptionCategory? filterCategory,
            BillingCycle? filterBillingCycle,
            String? searchTerm)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<SubscriptionEntity> allSubscriptions,
            List<SubscriptionEntity> filteredSubscriptions,
            SortOption? currentSortOption,
            SubscriptionCategory? filterCategory,
            BillingCycle? filterBillingCycle,
            String? searchTerm)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements SubscriptionState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$LoadedImplCopyWith<$Res> {
  factory _$$LoadedImplCopyWith(
          _$LoadedImpl value, $Res Function(_$LoadedImpl) then) =
      __$$LoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<SubscriptionEntity> allSubscriptions,
      List<SubscriptionEntity> filteredSubscriptions,
      SortOption? currentSortOption,
      SubscriptionCategory? filterCategory,
      BillingCycle? filterBillingCycle,
      String? searchTerm});
}

/// @nodoc
class __$$LoadedImplCopyWithImpl<$Res>
    extends _$SubscriptionStateCopyWithImpl<$Res, _$LoadedImpl>
    implements _$$LoadedImplCopyWith<$Res> {
  __$$LoadedImplCopyWithImpl(
      _$LoadedImpl _value, $Res Function(_$LoadedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allSubscriptions = null,
    Object? filteredSubscriptions = null,
    Object? currentSortOption = freezed,
    Object? filterCategory = freezed,
    Object? filterBillingCycle = freezed,
    Object? searchTerm = freezed,
  }) {
    return _then(_$LoadedImpl(
      allSubscriptions: null == allSubscriptions
          ? _value._allSubscriptions
          : allSubscriptions // ignore: cast_nullable_to_non_nullable
              as List<SubscriptionEntity>,
      filteredSubscriptions: null == filteredSubscriptions
          ? _value._filteredSubscriptions
          : filteredSubscriptions // ignore: cast_nullable_to_non_nullable
              as List<SubscriptionEntity>,
      currentSortOption: freezed == currentSortOption
          ? _value.currentSortOption
          : currentSortOption // ignore: cast_nullable_to_non_nullable
              as SortOption?,
      filterCategory: freezed == filterCategory
          ? _value.filterCategory
          : filterCategory // ignore: cast_nullable_to_non_nullable
              as SubscriptionCategory?,
      filterBillingCycle: freezed == filterBillingCycle
          ? _value.filterBillingCycle
          : filterBillingCycle // ignore: cast_nullable_to_non_nullable
              as BillingCycle?,
      searchTerm: freezed == searchTerm
          ? _value.searchTerm
          : searchTerm // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$LoadedImpl implements _Loaded {
  const _$LoadedImpl(
      {required final List<SubscriptionEntity> allSubscriptions,
      required final List<SubscriptionEntity> filteredSubscriptions,
      this.currentSortOption,
      this.filterCategory,
      this.filterBillingCycle,
      this.searchTerm})
      : _allSubscriptions = allSubscriptions,
        _filteredSubscriptions = filteredSubscriptions;

  final List<SubscriptionEntity> _allSubscriptions;
  @override
  List<SubscriptionEntity> get allSubscriptions {
    if (_allSubscriptions is EqualUnmodifiableListView)
      return _allSubscriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allSubscriptions);
  }

  final List<SubscriptionEntity> _filteredSubscriptions;
  @override
  List<SubscriptionEntity> get filteredSubscriptions {
    if (_filteredSubscriptions is EqualUnmodifiableListView)
      return _filteredSubscriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filteredSubscriptions);
  }

// For UI display after filtering/sorting
// Add other relevant data for the UI, e.g., sorting options, filter values
  @override
  final SortOption? currentSortOption;
  @override
  final SubscriptionCategory? filterCategory;
  @override
  final BillingCycle? filterBillingCycle;
  @override
  final String? searchTerm;

  @override
  String toString() {
    return 'SubscriptionState.loaded(allSubscriptions: $allSubscriptions, filteredSubscriptions: $filteredSubscriptions, currentSortOption: $currentSortOption, filterCategory: $filterCategory, filterBillingCycle: $filterBillingCycle, searchTerm: $searchTerm)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadedImpl &&
            const DeepCollectionEquality()
                .equals(other._allSubscriptions, _allSubscriptions) &&
            const DeepCollectionEquality()
                .equals(other._filteredSubscriptions, _filteredSubscriptions) &&
            (identical(other.currentSortOption, currentSortOption) ||
                other.currentSortOption == currentSortOption) &&
            (identical(other.filterCategory, filterCategory) ||
                other.filterCategory == filterCategory) &&
            (identical(other.filterBillingCycle, filterBillingCycle) ||
                other.filterBillingCycle == filterBillingCycle) &&
            (identical(other.searchTerm, searchTerm) ||
                other.searchTerm == searchTerm));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_allSubscriptions),
      const DeepCollectionEquality().hash(_filteredSubscriptions),
      currentSortOption,
      filterCategory,
      filterBillingCycle,
      searchTerm);

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      __$$LoadedImplCopyWithImpl<_$LoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<SubscriptionEntity> allSubscriptions,
            List<SubscriptionEntity> filteredSubscriptions,
            SortOption? currentSortOption,
            SubscriptionCategory? filterCategory,
            BillingCycle? filterBillingCycle,
            String? searchTerm)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(allSubscriptions, filteredSubscriptions, currentSortOption,
        filterCategory, filterBillingCycle, searchTerm);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<SubscriptionEntity> allSubscriptions,
            List<SubscriptionEntity> filteredSubscriptions,
            SortOption? currentSortOption,
            SubscriptionCategory? filterCategory,
            BillingCycle? filterBillingCycle,
            String? searchTerm)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(allSubscriptions, filteredSubscriptions,
        currentSortOption, filterCategory, filterBillingCycle, searchTerm);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<SubscriptionEntity> allSubscriptions,
            List<SubscriptionEntity> filteredSubscriptions,
            SortOption? currentSortOption,
            SubscriptionCategory? filterCategory,
            BillingCycle? filterBillingCycle,
            String? searchTerm)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(allSubscriptions, filteredSubscriptions, currentSortOption,
          filterCategory, filterBillingCycle, searchTerm);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class _Loaded implements SubscriptionState {
  const factory _Loaded(
      {required final List<SubscriptionEntity> allSubscriptions,
      required final List<SubscriptionEntity> filteredSubscriptions,
      final SortOption? currentSortOption,
      final SubscriptionCategory? filterCategory,
      final BillingCycle? filterBillingCycle,
      final String? searchTerm}) = _$LoadedImpl;

  List<SubscriptionEntity> get allSubscriptions;
  List<SubscriptionEntity>
      get filteredSubscriptions; // For UI display after filtering/sorting
// Add other relevant data for the UI, e.g., sorting options, filter values
  SortOption? get currentSortOption;
  SubscriptionCategory? get filterCategory;
  BillingCycle? get filterBillingCycle;
  String? get searchTerm;

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LoadedImplCopyWith<_$LoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$SubscriptionStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$ErrorImpl(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl({required this.message});

  @override
  final String message;

  @override
  String toString() {
    return 'SubscriptionState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(
            List<SubscriptionEntity> allSubscriptions,
            List<SubscriptionEntity> filteredSubscriptions,
            SortOption? currentSortOption,
            SubscriptionCategory? filterCategory,
            BillingCycle? filterBillingCycle,
            String? searchTerm)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(
            List<SubscriptionEntity> allSubscriptions,
            List<SubscriptionEntity> filteredSubscriptions,
            SortOption? currentSortOption,
            SubscriptionCategory? filterCategory,
            BillingCycle? filterBillingCycle,
            String? searchTerm)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(
            List<SubscriptionEntity> allSubscriptions,
            List<SubscriptionEntity> filteredSubscriptions,
            SortOption? currentSortOption,
            SubscriptionCategory? filterCategory,
            BillingCycle? filterBillingCycle,
            String? searchTerm)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Initial value) initial,
    required TResult Function(_Loading value) loading,
    required TResult Function(_Loaded value) loaded,
    required TResult Function(_Error value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Initial value)? initial,
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Loaded value)? loaded,
    TResult? Function(_Error value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Initial value)? initial,
    TResult Function(_Loading value)? loading,
    TResult Function(_Loaded value)? loaded,
    TResult Function(_Error value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements SubscriptionState {
  const factory _Error({required final String message}) = _$ErrorImpl;

  String get message;

  /// Create a copy of SubscriptionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
