// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SettingsEntity {
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  Locale get locale => throw _privateConstructorUsedError;
  String get currencyCode =>
      throw _privateConstructorUsedError; // --- NEUE FELDER FÜR GEHALT ---
  double? get salary => throw _privateConstructorUsedError;
  SalaryCycle get salaryCycle => throw _privateConstructorUsedError;
  bool get hasThirteenthSalary => throw _privateConstructorUsedError;

  /// Create a copy of SettingsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingsEntityCopyWith<SettingsEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsEntityCopyWith<$Res> {
  factory $SettingsEntityCopyWith(
          SettingsEntity value, $Res Function(SettingsEntity) then) =
      _$SettingsEntityCopyWithImpl<$Res, SettingsEntity>;
  @useResult
  $Res call(
      {ThemeMode themeMode,
      Locale locale,
      String currencyCode,
      double? salary,
      SalaryCycle salaryCycle,
      bool hasThirteenthSalary});
}

/// @nodoc
class _$SettingsEntityCopyWithImpl<$Res, $Val extends SettingsEntity>
    implements $SettingsEntityCopyWith<$Res> {
  _$SettingsEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? locale = null,
    Object? currencyCode = null,
    Object? salary = freezed,
    Object? salaryCycle = null,
    Object? hasThirteenthSalary = null,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      salary: freezed == salary
          ? _value.salary
          : salary // ignore: cast_nullable_to_non_nullable
              as double?,
      salaryCycle: null == salaryCycle
          ? _value.salaryCycle
          : salaryCycle // ignore: cast_nullable_to_non_nullable
              as SalaryCycle,
      hasThirteenthSalary: null == hasThirteenthSalary
          ? _value.hasThirteenthSalary
          : hasThirteenthSalary // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsEntityImplCopyWith<$Res>
    implements $SettingsEntityCopyWith<$Res> {
  factory _$$SettingsEntityImplCopyWith(_$SettingsEntityImpl value,
          $Res Function(_$SettingsEntityImpl) then) =
      __$$SettingsEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ThemeMode themeMode,
      Locale locale,
      String currencyCode,
      double? salary,
      SalaryCycle salaryCycle,
      bool hasThirteenthSalary});
}

/// @nodoc
class __$$SettingsEntityImplCopyWithImpl<$Res>
    extends _$SettingsEntityCopyWithImpl<$Res, _$SettingsEntityImpl>
    implements _$$SettingsEntityImplCopyWith<$Res> {
  __$$SettingsEntityImplCopyWithImpl(
      _$SettingsEntityImpl _value, $Res Function(_$SettingsEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? locale = null,
    Object? currencyCode = null,
    Object? salary = freezed,
    Object? salaryCycle = null,
    Object? hasThirteenthSalary = null,
  }) {
    return _then(_$SettingsEntityImpl(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      locale: null == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as Locale,
      currencyCode: null == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String,
      salary: freezed == salary
          ? _value.salary
          : salary // ignore: cast_nullable_to_non_nullable
              as double?,
      salaryCycle: null == salaryCycle
          ? _value.salaryCycle
          : salaryCycle // ignore: cast_nullable_to_non_nullable
              as SalaryCycle,
      hasThirteenthSalary: null == hasThirteenthSalary
          ? _value.hasThirteenthSalary
          : hasThirteenthSalary // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SettingsEntityImpl implements _SettingsEntity {
  const _$SettingsEntityImpl(
      {required this.themeMode,
      required this.locale,
      required this.currencyCode,
      this.salary,
      this.salaryCycle = SalaryCycle.monthly,
      this.hasThirteenthSalary = false});

  @override
  final ThemeMode themeMode;
  @override
  final Locale locale;
  @override
  final String currencyCode;
// --- NEUE FELDER FÜR GEHALT ---
  @override
  final double? salary;
  @override
  @JsonKey()
  final SalaryCycle salaryCycle;
  @override
  @JsonKey()
  final bool hasThirteenthSalary;

  @override
  String toString() {
    return 'SettingsEntity(themeMode: $themeMode, locale: $locale, currencyCode: $currencyCode, salary: $salary, salaryCycle: $salaryCycle, hasThirteenthSalary: $hasThirteenthSalary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsEntityImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.salary, salary) || other.salary == salary) &&
            (identical(other.salaryCycle, salaryCycle) ||
                other.salaryCycle == salaryCycle) &&
            (identical(other.hasThirteenthSalary, hasThirteenthSalary) ||
                other.hasThirteenthSalary == hasThirteenthSalary));
  }

  @override
  int get hashCode => Object.hash(runtimeType, themeMode, locale, currencyCode,
      salary, salaryCycle, hasThirteenthSalary);

  /// Create a copy of SettingsEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsEntityImplCopyWith<_$SettingsEntityImpl> get copyWith =>
      __$$SettingsEntityImplCopyWithImpl<_$SettingsEntityImpl>(
          this, _$identity);
}

abstract class _SettingsEntity implements SettingsEntity {
  const factory _SettingsEntity(
      {required final ThemeMode themeMode,
      required final Locale locale,
      required final String currencyCode,
      final double? salary,
      final SalaryCycle salaryCycle,
      final bool hasThirteenthSalary}) = _$SettingsEntityImpl;

  @override
  ThemeMode get themeMode;
  @override
  Locale get locale;
  @override
  String get currencyCode; // --- NEUE FELDER FÜR GEHALT ---
  @override
  double? get salary;
  @override
  SalaryCycle get salaryCycle;
  @override
  bool get hasThirteenthSalary;

  /// Create a copy of SettingsEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsEntityImplCopyWith<_$SettingsEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
