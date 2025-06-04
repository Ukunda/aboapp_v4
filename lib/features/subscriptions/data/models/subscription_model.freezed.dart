// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubscriptionModel _$SubscriptionModelFromJson(Map<String, dynamic> json) {
  return _SubscriptionModel.fromJson(json);
}

/// @nodoc
mixin _$SubscriptionModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError;
  @JsonKey(unknownEnumValue: BillingCycle.custom)
  BillingCycle get billingCycle => throw _privateConstructorUsedError;
  DateTime get nextBillingDate => throw _privateConstructorUsedError;
  @JsonKey(unknownEnumValue: SubscriptionCategory.other)
  SubscriptionCategory get category => throw _privateConstructorUsedError;
  DateTime? get startDate => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get logoUrl => throw _privateConstructorUsedError;
  @ColorSerializer()
  Color? get color => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  bool get notificationsEnabled => throw _privateConstructorUsedError;
  int get notificationDaysBefore => throw _privateConstructorUsedError;
  DateTime? get trialEndDate => throw _privateConstructorUsedError;
  Map<String, dynamic>? get customCycleDetails =>
      throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this SubscriptionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubscriptionModelCopyWith<SubscriptionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubscriptionModelCopyWith<$Res> {
  factory $SubscriptionModelCopyWith(
          SubscriptionModel value, $Res Function(SubscriptionModel) then) =
      _$SubscriptionModelCopyWithImpl<$Res, SubscriptionModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      double price,
      @JsonKey(unknownEnumValue: BillingCycle.custom) BillingCycle billingCycle,
      DateTime nextBillingDate,
      @JsonKey(unknownEnumValue: SubscriptionCategory.other)
      SubscriptionCategory category,
      DateTime? startDate,
      String? description,
      String? logoUrl,
      @ColorSerializer() Color? color,
      bool isActive,
      bool notificationsEnabled,
      int notificationDaysBefore,
      DateTime? trialEndDate,
      Map<String, dynamic>? customCycleDetails,
      String? notes});
}

/// @nodoc
class _$SubscriptionModelCopyWithImpl<$Res, $Val extends SubscriptionModel>
    implements $SubscriptionModelCopyWith<$Res> {
  _$SubscriptionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? billingCycle = null,
    Object? nextBillingDate = null,
    Object? category = null,
    Object? startDate = freezed,
    Object? description = freezed,
    Object? logoUrl = freezed,
    Object? color = freezed,
    Object? isActive = null,
    Object? notificationsEnabled = null,
    Object? notificationDaysBefore = null,
    Object? trialEndDate = freezed,
    Object? customCycleDetails = freezed,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      billingCycle: null == billingCycle
          ? _value.billingCycle
          : billingCycle // ignore: cast_nullable_to_non_nullable
              as BillingCycle,
      nextBillingDate: null == nextBillingDate
          ? _value.nextBillingDate
          : nextBillingDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as SubscriptionCategory,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationDaysBefore: null == notificationDaysBefore
          ? _value.notificationDaysBefore
          : notificationDaysBefore // ignore: cast_nullable_to_non_nullable
              as int,
      trialEndDate: freezed == trialEndDate
          ? _value.trialEndDate
          : trialEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customCycleDetails: freezed == customCycleDetails
          ? _value.customCycleDetails
          : customCycleDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubscriptionModelImplCopyWith<$Res>
    implements $SubscriptionModelCopyWith<$Res> {
  factory _$$SubscriptionModelImplCopyWith(_$SubscriptionModelImpl value,
          $Res Function(_$SubscriptionModelImpl) then) =
      __$$SubscriptionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      double price,
      @JsonKey(unknownEnumValue: BillingCycle.custom) BillingCycle billingCycle,
      DateTime nextBillingDate,
      @JsonKey(unknownEnumValue: SubscriptionCategory.other)
      SubscriptionCategory category,
      DateTime? startDate,
      String? description,
      String? logoUrl,
      @ColorSerializer() Color? color,
      bool isActive,
      bool notificationsEnabled,
      int notificationDaysBefore,
      DateTime? trialEndDate,
      Map<String, dynamic>? customCycleDetails,
      String? notes});
}

/// @nodoc
class __$$SubscriptionModelImplCopyWithImpl<$Res>
    extends _$SubscriptionModelCopyWithImpl<$Res, _$SubscriptionModelImpl>
    implements _$$SubscriptionModelImplCopyWith<$Res> {
  __$$SubscriptionModelImplCopyWithImpl(_$SubscriptionModelImpl _value,
      $Res Function(_$SubscriptionModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? billingCycle = null,
    Object? nextBillingDate = null,
    Object? category = null,
    Object? startDate = freezed,
    Object? description = freezed,
    Object? logoUrl = freezed,
    Object? color = freezed,
    Object? isActive = null,
    Object? notificationsEnabled = null,
    Object? notificationDaysBefore = null,
    Object? trialEndDate = freezed,
    Object? customCycleDetails = freezed,
    Object? notes = freezed,
  }) {
    return _then(_$SubscriptionModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      billingCycle: null == billingCycle
          ? _value.billingCycle
          : billingCycle // ignore: cast_nullable_to_non_nullable
              as BillingCycle,
      nextBillingDate: null == nextBillingDate
          ? _value.nextBillingDate
          : nextBillingDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as SubscriptionCategory,
      startDate: freezed == startDate
          ? _value.startDate
          : startDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUrl: freezed == logoUrl
          ? _value.logoUrl
          : logoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationDaysBefore: null == notificationDaysBefore
          ? _value.notificationDaysBefore
          : notificationDaysBefore // ignore: cast_nullable_to_non_nullable
              as int,
      trialEndDate: freezed == trialEndDate
          ? _value.trialEndDate
          : trialEndDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customCycleDetails: freezed == customCycleDetails
          ? _value._customCycleDetails
          : customCycleDetails // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SubscriptionModelImpl extends _SubscriptionModel {
  const _$SubscriptionModelImpl(
      {required this.id,
      required this.name,
      required this.price,
      @JsonKey(unknownEnumValue: BillingCycle.custom)
      required this.billingCycle,
      required this.nextBillingDate,
      @JsonKey(unknownEnumValue: SubscriptionCategory.other)
      required this.category,
      this.startDate,
      this.description,
      this.logoUrl,
      @ColorSerializer() this.color,
      this.isActive = true,
      this.notificationsEnabled = true,
      this.notificationDaysBefore = 7,
      this.trialEndDate,
      final Map<String, dynamic>? customCycleDetails,
      this.notes})
      : _customCycleDetails = customCycleDetails,
        super._();

  factory _$SubscriptionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubscriptionModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final double price;
  @override
  @JsonKey(unknownEnumValue: BillingCycle.custom)
  final BillingCycle billingCycle;
  @override
  final DateTime nextBillingDate;
  @override
  @JsonKey(unknownEnumValue: SubscriptionCategory.other)
  final SubscriptionCategory category;
  @override
  final DateTime? startDate;
  @override
  final String? description;
  @override
  final String? logoUrl;
  @override
  @ColorSerializer()
  final Color? color;
  @override
  @JsonKey()
  final bool isActive;
  @override
  @JsonKey()
  final bool notificationsEnabled;
  @override
  @JsonKey()
  final int notificationDaysBefore;
  @override
  final DateTime? trialEndDate;
  final Map<String, dynamic>? _customCycleDetails;
  @override
  Map<String, dynamic>? get customCycleDetails {
    final value = _customCycleDetails;
    if (value == null) return null;
    if (_customCycleDetails is EqualUnmodifiableMapView)
      return _customCycleDetails;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final String? notes;

  @override
  String toString() {
    return 'SubscriptionModel(id: $id, name: $name, price: $price, billingCycle: $billingCycle, nextBillingDate: $nextBillingDate, category: $category, startDate: $startDate, description: $description, logoUrl: $logoUrl, color: $color, isActive: $isActive, notificationsEnabled: $notificationsEnabled, notificationDaysBefore: $notificationDaysBefore, trialEndDate: $trialEndDate, customCycleDetails: $customCycleDetails, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubscriptionModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.billingCycle, billingCycle) ||
                other.billingCycle == billingCycle) &&
            (identical(other.nextBillingDate, nextBillingDate) ||
                other.nextBillingDate == nextBillingDate) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            (identical(other.notificationDaysBefore, notificationDaysBefore) ||
                other.notificationDaysBefore == notificationDaysBefore) &&
            (identical(other.trialEndDate, trialEndDate) ||
                other.trialEndDate == trialEndDate) &&
            const DeepCollectionEquality()
                .equals(other._customCycleDetails, _customCycleDetails) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      price,
      billingCycle,
      nextBillingDate,
      category,
      startDate,
      description,
      logoUrl,
      color,
      isActive,
      notificationsEnabled,
      notificationDaysBefore,
      trialEndDate,
      const DeepCollectionEquality().hash(_customCycleDetails),
      notes);

  /// Create a copy of SubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubscriptionModelImplCopyWith<_$SubscriptionModelImpl> get copyWith =>
      __$$SubscriptionModelImplCopyWithImpl<_$SubscriptionModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubscriptionModelImplToJson(
      this,
    );
  }
}

abstract class _SubscriptionModel extends SubscriptionModel {
  const factory _SubscriptionModel(
      {required final String id,
      required final String name,
      required final double price,
      @JsonKey(unknownEnumValue: BillingCycle.custom)
      required final BillingCycle billingCycle,
      required final DateTime nextBillingDate,
      @JsonKey(unknownEnumValue: SubscriptionCategory.other)
      required final SubscriptionCategory category,
      final DateTime? startDate,
      final String? description,
      final String? logoUrl,
      @ColorSerializer() final Color? color,
      final bool isActive,
      final bool notificationsEnabled,
      final int notificationDaysBefore,
      final DateTime? trialEndDate,
      final Map<String, dynamic>? customCycleDetails,
      final String? notes}) = _$SubscriptionModelImpl;
  const _SubscriptionModel._() : super._();

  factory _SubscriptionModel.fromJson(Map<String, dynamic> json) =
      _$SubscriptionModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  double get price;
  @override
  @JsonKey(unknownEnumValue: BillingCycle.custom)
  BillingCycle get billingCycle;
  @override
  DateTime get nextBillingDate;
  @override
  @JsonKey(unknownEnumValue: SubscriptionCategory.other)
  SubscriptionCategory get category;
  @override
  DateTime? get startDate;
  @override
  String? get description;
  @override
  String? get logoUrl;
  @override
  @ColorSerializer()
  Color? get color;
  @override
  bool get isActive;
  @override
  bool get notificationsEnabled;
  @override
  int get notificationDaysBefore;
  @override
  DateTime? get trialEndDate;
  @override
  Map<String, dynamic>? get customCycleDetails;
  @override
  String? get notes;

  /// Create a copy of SubscriptionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubscriptionModelImplCopyWith<_$SubscriptionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
