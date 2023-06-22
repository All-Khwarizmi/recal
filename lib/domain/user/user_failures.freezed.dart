// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_failures.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserFailures {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noUserData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noUserData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noUserData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoUserData value) noUserData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoUserData value)? noUserData,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NoUserData value)? noUserData,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserFailuresCopyWith<$Res> {
  factory $UserFailuresCopyWith(
          UserFailures value, $Res Function(UserFailures) then) =
      _$UserFailuresCopyWithImpl<$Res, UserFailures>;
}

/// @nodoc
class _$UserFailuresCopyWithImpl<$Res, $Val extends UserFailures>
    implements $UserFailuresCopyWith<$Res> {
  _$UserFailuresCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$NoUserDataCopyWith<$Res> {
  factory _$$NoUserDataCopyWith(
          _$NoUserData value, $Res Function(_$NoUserData) then) =
      __$$NoUserDataCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NoUserDataCopyWithImpl<$Res>
    extends _$UserFailuresCopyWithImpl<$Res, _$NoUserData>
    implements _$$NoUserDataCopyWith<$Res> {
  __$$NoUserDataCopyWithImpl(
      _$NoUserData _value, $Res Function(_$NoUserData) _then)
      : super(_value, _then);
}

/// @nodoc

class _$NoUserData implements NoUserData {
  const _$NoUserData();

  @override
  String toString() {
    return 'UserFailures.noUserData()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NoUserData);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() noUserData,
  }) {
    return noUserData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? noUserData,
  }) {
    return noUserData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? noUserData,
    required TResult orElse(),
  }) {
    if (noUserData != null) {
      return noUserData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(NoUserData value) noUserData,
  }) {
    return noUserData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(NoUserData value)? noUserData,
  }) {
    return noUserData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(NoUserData value)? noUserData,
    required TResult orElse(),
  }) {
    if (noUserData != null) {
      return noUserData(this);
    }
    return orElse();
  }
}

abstract class NoUserData implements UserFailures {
  const factory NoUserData() = _$NoUserData;
}
