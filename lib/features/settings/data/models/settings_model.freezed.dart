// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SettingsModel _$SettingsModelFromJson(Map<String, dynamic> json) {
  return _SettingsModel.fromJson(json);
}

/// @nodoc
mixin _$SettingsModel {
  @ThemeModeConverter()
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  @LocaleConverter()
  Locale get locale => throw _privateConstructorUsedError;
  String get currencyCode =>
      throw _privateConstructorUsedError; // --- NEUE FELDER ---
  double? get salary => throw _privateConstructorUsedError;
  @SalaryCycleConverter()
  SalaryCycle get salaryCycle => throw _privateConstructorUsedError;
  bool get hasThirteenthSalary => throw _privateConstructorUsedError;

  /// Serializes this SettingsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SettingsModelCopyWith<SettingsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsModelCopyWith<$Res> {
  factory $SettingsModelCopyWith(
          SettingsModel value, $Res Function(SettingsModel) then) =
      _$SettingsModelCopyWithImpl<$Res, SettingsModel>;
  @useResult
  $Res call(
      {@ThemeModeConverter() ThemeMode themeMode,
      @LocaleConverter() Locale locale,
      String currencyCode,
      double? salary,
      @SalaryCycleConverter() SalaryCycle salaryCycle,
      bool hasThirteenthSalary});
}

/// @nodoc
class _$SettingsModelCopyWithImpl<$Res, $Val extends SettingsModel>
    implements $SettingsModelCopyWith<$Res> {
  _$SettingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SettingsModel
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
abstract class _$$SettingsModelImplCopyWith<$Res>
    implements $SettingsModelCopyWith<$Res> {
  factory _$$SettingsModelImplCopyWith(
          _$SettingsModelImpl value, $Res Function(_$SettingsModelImpl) then) =
      __$$SettingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@ThemeModeConverter() ThemeMode themeMode,
      @LocaleConverter() Locale locale,
      String currencyCode,
      double? salary,
      @SalaryCycleConverter() SalaryCycle salaryCycle,
      bool hasThirteenthSalary});
}

/// @nodoc
class __$$SettingsModelImplCopyWithImpl<$Res>
    extends _$SettingsModelCopyWithImpl<$Res, _$SettingsModelImpl>
    implements _$$SettingsModelImplCopyWith<$Res> {
  __$$SettingsModelImplCopyWithImpl(
      _$SettingsModelImpl _value, $Res Function(_$SettingsModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SettingsModel
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
    return _then(_$SettingsModelImpl(
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
@JsonSerializable()
class _$SettingsModelImpl extends _SettingsModel {
  const _$SettingsModelImpl(
      {@ThemeModeConverter() required this.themeMode,
      @LocaleConverter() required this.locale,
      required this.currencyCode,
      this.salary,
      @SalaryCycleConverter() this.salaryCycle = SalaryCycle.monthly,
      this.hasThirteenthSalary = false})
      : super._();

  factory _$SettingsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SettingsModelImplFromJson(json);

  @override
  @ThemeModeConverter()
  final ThemeMode themeMode;
  @override
  @LocaleConverter()
  final Locale locale;
  @override
  final String currencyCode;
// --- NEUE FELDER ---
  @override
  final double? salary;
  @override
  @JsonKey()
  @SalaryCycleConverter()
  final SalaryCycle salaryCycle;
  @override
  @JsonKey()
  final bool hasThirteenthSalary;

  @override
  String toString() {
    return 'SettingsModel(themeMode: $themeMode, locale: $locale, currencyCode: $currencyCode, salary: $salary, salaryCycle: $salaryCycle, hasThirteenthSalary: $hasThirteenthSalary)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsModelImpl &&
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

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, themeMode, locale, currencyCode,
      salary, salaryCycle, hasThirteenthSalary);

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsModelImplCopyWith<_$SettingsModelImpl> get copyWith =>
      __$$SettingsModelImplCopyWithImpl<_$SettingsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SettingsModelImplToJson(
      this,
    );
  }
}

abstract class _SettingsModel extends SettingsModel {
  const factory _SettingsModel(
      {@ThemeModeConverter() required final ThemeMode themeMode,
      @LocaleConverter() required final Locale locale,
      required final String currencyCode,
      final double? salary,
      @SalaryCycleConverter() final SalaryCycle salaryCycle,
      final bool hasThirteenthSalary}) = _$SettingsModelImpl;
  const _SettingsModel._() : super._();

  factory _SettingsModel.fromJson(Map<String, dynamic> json) =
      _$SettingsModelImpl.fromJson;

  @override
  @ThemeModeConverter()
  ThemeMode get themeMode;
  @override
  @LocaleConverter()
  Locale get locale;
  @override
  String get currencyCode; // --- NEUE FELDER ---
  @override
  double? get salary;
  @override
  @SalaryCycleConverter()
  SalaryCycle get salaryCycle;
  @override
  bool get hasThirteenthSalary;

  /// Create a copy of SettingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SettingsModelImplCopyWith<_$SettingsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
