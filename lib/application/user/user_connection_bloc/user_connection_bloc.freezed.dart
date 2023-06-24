// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_connection_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$UserConnectionEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() userConnected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? userConnected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? userConnected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(UserConnected value) userConnected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(UserConnected value)? userConnected,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(UserConnected value)? userConnected,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserConnectionEventCopyWith<$Res> {
  factory $UserConnectionEventCopyWith(
          UserConnectionEvent value, $Res Function(UserConnectionEvent) then) =
      _$UserConnectionEventCopyWithImpl<$Res, UserConnectionEvent>;
}

/// @nodoc
class _$UserConnectionEventCopyWithImpl<$Res, $Val extends UserConnectionEvent>
    implements $UserConnectionEventCopyWith<$Res> {
  _$UserConnectionEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$_StartedCopyWith<$Res> {
  factory _$$_StartedCopyWith(
          _$_Started value, $Res Function(_$_Started) then) =
      __$$_StartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_StartedCopyWithImpl<$Res>
    extends _$UserConnectionEventCopyWithImpl<$Res, _$_Started>
    implements _$$_StartedCopyWith<$Res> {
  __$$_StartedCopyWithImpl(_$_Started _value, $Res Function(_$_Started) _then)
      : super(_value, _then);
}

/// @nodoc

class _$_Started implements _Started {
  const _$_Started();

  @override
  String toString() {
    return 'UserConnectionEvent.started()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() userConnected,
  }) {
    return started();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? userConnected,
  }) {
    return started?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? userConnected,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(UserConnected value) userConnected,
  }) {
    return started(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(UserConnected value)? userConnected,
  }) {
    return started?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(UserConnected value)? userConnected,
    required TResult orElse(),
  }) {
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements UserConnectionEvent {
  const factory _Started() = _$_Started;
}

/// @nodoc
abstract class _$$UserConnectedCopyWith<$Res> {
  factory _$$UserConnectedCopyWith(
          _$UserConnected value, $Res Function(_$UserConnected) then) =
      __$$UserConnectedCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserConnectedCopyWithImpl<$Res>
    extends _$UserConnectionEventCopyWithImpl<$Res, _$UserConnected>
    implements _$$UserConnectedCopyWith<$Res> {
  __$$UserConnectedCopyWithImpl(
      _$UserConnected _value, $Res Function(_$UserConnected) _then)
      : super(_value, _then);
}

/// @nodoc

class _$UserConnected implements UserConnected {
  const _$UserConnected();

  @override
  String toString() {
    return 'UserConnectionEvent.userConnected()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$UserConnected);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() started,
    required TResult Function() userConnected,
  }) {
    return userConnected();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? started,
    TResult? Function()? userConnected,
  }) {
    return userConnected?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? started,
    TResult Function()? userConnected,
    required TResult orElse(),
  }) {
    if (userConnected != null) {
      return userConnected();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Started value) started,
    required TResult Function(UserConnected value) userConnected,
  }) {
    return userConnected(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Started value)? started,
    TResult? Function(UserConnected value)? userConnected,
  }) {
    return userConnected?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Started value)? started,
    TResult Function(UserConnected value)? userConnected,
    required TResult orElse(),
  }) {
    if (userConnected != null) {
      return userConnected(this);
    }
    return orElse();
  }
}

abstract class UserConnected implements UserConnectionEvent {
  const factory UserConnected() = _$UserConnected;
}

/// @nodoc
mixin _$UserConnectionState {
  DateTime get lastConnection => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int connectionStreak, DateTime lastConnection) $default, {
    required TResult Function(int streakConnection, DateTime lastConnection)
        userStreakKept,
    required TResult Function(DateTime lastConnection) userStreakBroke,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int connectionStreak, DateTime lastConnection)?
        $default, {
    TResult? Function(int streakConnection, DateTime lastConnection)?
        userStreakKept,
    TResult? Function(DateTime lastConnection)? userStreakBroke,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int connectionStreak, DateTime lastConnection)? $default, {
    TResult Function(int streakConnection, DateTime lastConnection)?
        userStreakKept,
    TResult Function(DateTime lastConnection)? userStreakBroke,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Initial value) $default, {
    required TResult Function(UserStreaKept value) userStreakKept,
    required TResult Function(UserStreakBroke value) userStreakBroke,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Initial value)? $default, {
    TResult? Function(UserStreaKept value)? userStreakKept,
    TResult? Function(UserStreakBroke value)? userStreakBroke,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Initial value)? $default, {
    TResult Function(UserStreaKept value)? userStreakKept,
    TResult Function(UserStreakBroke value)? userStreakBroke,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserConnectionStateCopyWith<UserConnectionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserConnectionStateCopyWith<$Res> {
  factory $UserConnectionStateCopyWith(
          UserConnectionState value, $Res Function(UserConnectionState) then) =
      _$UserConnectionStateCopyWithImpl<$Res, UserConnectionState>;
  @useResult
  $Res call({DateTime lastConnection});
}

/// @nodoc
class _$UserConnectionStateCopyWithImpl<$Res, $Val extends UserConnectionState>
    implements $UserConnectionStateCopyWith<$Res> {
  _$UserConnectionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastConnection = null,
  }) {
    return _then(_value.copyWith(
      lastConnection: null == lastConnection
          ? _value.lastConnection
          : lastConnection // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_InitialCopyWith<$Res>
    implements $UserConnectionStateCopyWith<$Res> {
  factory _$$_InitialCopyWith(
          _$_Initial value, $Res Function(_$_Initial) then) =
      __$$_InitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int connectionStreak, DateTime lastConnection});
}

/// @nodoc
class __$$_InitialCopyWithImpl<$Res>
    extends _$UserConnectionStateCopyWithImpl<$Res, _$_Initial>
    implements _$$_InitialCopyWith<$Res> {
  __$$_InitialCopyWithImpl(_$_Initial _value, $Res Function(_$_Initial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connectionStreak = null,
    Object? lastConnection = null,
  }) {
    return _then(_$_Initial(
      connectionStreak: null == connectionStreak
          ? _value.connectionStreak
          : connectionStreak // ignore: cast_nullable_to_non_nullable
              as int,
      lastConnection: null == lastConnection
          ? _value.lastConnection
          : lastConnection // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_Initial implements _Initial {
  const _$_Initial(
      {required this.connectionStreak, required this.lastConnection});

  @override
  final int connectionStreak;
  @override
  final DateTime lastConnection;

  @override
  String toString() {
    return 'UserConnectionState(connectionStreak: $connectionStreak, lastConnection: $lastConnection)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Initial &&
            (identical(other.connectionStreak, connectionStreak) ||
                other.connectionStreak == connectionStreak) &&
            (identical(other.lastConnection, lastConnection) ||
                other.lastConnection == lastConnection));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, connectionStreak, lastConnection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      __$$_InitialCopyWithImpl<_$_Initial>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int connectionStreak, DateTime lastConnection) $default, {
    required TResult Function(int streakConnection, DateTime lastConnection)
        userStreakKept,
    required TResult Function(DateTime lastConnection) userStreakBroke,
  }) {
    return $default(connectionStreak, lastConnection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int connectionStreak, DateTime lastConnection)?
        $default, {
    TResult? Function(int streakConnection, DateTime lastConnection)?
        userStreakKept,
    TResult? Function(DateTime lastConnection)? userStreakBroke,
  }) {
    return $default?.call(connectionStreak, lastConnection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int connectionStreak, DateTime lastConnection)? $default, {
    TResult Function(int streakConnection, DateTime lastConnection)?
        userStreakKept,
    TResult Function(DateTime lastConnection)? userStreakBroke,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(connectionStreak, lastConnection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Initial value) $default, {
    required TResult Function(UserStreaKept value) userStreakKept,
    required TResult Function(UserStreakBroke value) userStreakBroke,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Initial value)? $default, {
    TResult? Function(UserStreaKept value)? userStreakKept,
    TResult? Function(UserStreakBroke value)? userStreakBroke,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Initial value)? $default, {
    TResult Function(UserStreaKept value)? userStreakKept,
    TResult Function(UserStreakBroke value)? userStreakBroke,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class _Initial implements UserConnectionState {
  const factory _Initial(
      {required final int connectionStreak,
      required final DateTime lastConnection}) = _$_Initial;

  int get connectionStreak;
  @override
  DateTime get lastConnection;
  @override
  @JsonKey(ignore: true)
  _$$_InitialCopyWith<_$_Initial> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserStreaKeptCopyWith<$Res>
    implements $UserConnectionStateCopyWith<$Res> {
  factory _$$UserStreaKeptCopyWith(
          _$UserStreaKept value, $Res Function(_$UserStreaKept) then) =
      __$$UserStreaKeptCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int streakConnection, DateTime lastConnection});
}

/// @nodoc
class __$$UserStreaKeptCopyWithImpl<$Res>
    extends _$UserConnectionStateCopyWithImpl<$Res, _$UserStreaKept>
    implements _$$UserStreaKeptCopyWith<$Res> {
  __$$UserStreaKeptCopyWithImpl(
      _$UserStreaKept _value, $Res Function(_$UserStreaKept) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? streakConnection = null,
    Object? lastConnection = null,
  }) {
    return _then(_$UserStreaKept(
      null == streakConnection
          ? _value.streakConnection
          : streakConnection // ignore: cast_nullable_to_non_nullable
              as int,
      null == lastConnection
          ? _value.lastConnection
          : lastConnection // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$UserStreaKept implements UserStreaKept {
  const _$UserStreaKept(this.streakConnection, this.lastConnection);

  @override
  final int streakConnection;
  @override
  final DateTime lastConnection;

  @override
  String toString() {
    return 'UserConnectionState.userStreakKept(streakConnection: $streakConnection, lastConnection: $lastConnection)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStreaKept &&
            (identical(other.streakConnection, streakConnection) ||
                other.streakConnection == streakConnection) &&
            (identical(other.lastConnection, lastConnection) ||
                other.lastConnection == lastConnection));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, streakConnection, lastConnection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStreaKeptCopyWith<_$UserStreaKept> get copyWith =>
      __$$UserStreaKeptCopyWithImpl<_$UserStreaKept>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int connectionStreak, DateTime lastConnection) $default, {
    required TResult Function(int streakConnection, DateTime lastConnection)
        userStreakKept,
    required TResult Function(DateTime lastConnection) userStreakBroke,
  }) {
    return userStreakKept(streakConnection, lastConnection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int connectionStreak, DateTime lastConnection)?
        $default, {
    TResult? Function(int streakConnection, DateTime lastConnection)?
        userStreakKept,
    TResult? Function(DateTime lastConnection)? userStreakBroke,
  }) {
    return userStreakKept?.call(streakConnection, lastConnection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int connectionStreak, DateTime lastConnection)? $default, {
    TResult Function(int streakConnection, DateTime lastConnection)?
        userStreakKept,
    TResult Function(DateTime lastConnection)? userStreakBroke,
    required TResult orElse(),
  }) {
    if (userStreakKept != null) {
      return userStreakKept(streakConnection, lastConnection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Initial value) $default, {
    required TResult Function(UserStreaKept value) userStreakKept,
    required TResult Function(UserStreakBroke value) userStreakBroke,
  }) {
    return userStreakKept(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Initial value)? $default, {
    TResult? Function(UserStreaKept value)? userStreakKept,
    TResult? Function(UserStreakBroke value)? userStreakBroke,
  }) {
    return userStreakKept?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Initial value)? $default, {
    TResult Function(UserStreaKept value)? userStreakKept,
    TResult Function(UserStreakBroke value)? userStreakBroke,
    required TResult orElse(),
  }) {
    if (userStreakKept != null) {
      return userStreakKept(this);
    }
    return orElse();
  }
}

abstract class UserStreaKept implements UserConnectionState {
  const factory UserStreaKept(
          final int streakConnection, final DateTime lastConnection) =
      _$UserStreaKept;

  int get streakConnection;
  @override
  DateTime get lastConnection;
  @override
  @JsonKey(ignore: true)
  _$$UserStreaKeptCopyWith<_$UserStreaKept> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$UserStreakBrokeCopyWith<$Res>
    implements $UserConnectionStateCopyWith<$Res> {
  factory _$$UserStreakBrokeCopyWith(
          _$UserStreakBroke value, $Res Function(_$UserStreakBroke) then) =
      __$$UserStreakBrokeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({DateTime lastConnection});
}

/// @nodoc
class __$$UserStreakBrokeCopyWithImpl<$Res>
    extends _$UserConnectionStateCopyWithImpl<$Res, _$UserStreakBroke>
    implements _$$UserStreakBrokeCopyWith<$Res> {
  __$$UserStreakBrokeCopyWithImpl(
      _$UserStreakBroke _value, $Res Function(_$UserStreakBroke) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lastConnection = null,
  }) {
    return _then(_$UserStreakBroke(
      null == lastConnection
          ? _value.lastConnection
          : lastConnection // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$UserStreakBroke implements UserStreakBroke {
  const _$UserStreakBroke(this.lastConnection);

  @override
  final DateTime lastConnection;

  @override
  String toString() {
    return 'UserConnectionState.userStreakBroke(lastConnection: $lastConnection)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserStreakBroke &&
            (identical(other.lastConnection, lastConnection) ||
                other.lastConnection == lastConnection));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lastConnection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserStreakBrokeCopyWith<_$UserStreakBroke> get copyWith =>
      __$$UserStreakBrokeCopyWithImpl<_$UserStreakBroke>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(int connectionStreak, DateTime lastConnection) $default, {
    required TResult Function(int streakConnection, DateTime lastConnection)
        userStreakKept,
    required TResult Function(DateTime lastConnection) userStreakBroke,
  }) {
    return userStreakBroke(lastConnection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(int connectionStreak, DateTime lastConnection)?
        $default, {
    TResult? Function(int streakConnection, DateTime lastConnection)?
        userStreakKept,
    TResult? Function(DateTime lastConnection)? userStreakBroke,
  }) {
    return userStreakBroke?.call(lastConnection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(int connectionStreak, DateTime lastConnection)? $default, {
    TResult Function(int streakConnection, DateTime lastConnection)?
        userStreakKept,
    TResult Function(DateTime lastConnection)? userStreakBroke,
    required TResult orElse(),
  }) {
    if (userStreakBroke != null) {
      return userStreakBroke(lastConnection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_Initial value) $default, {
    required TResult Function(UserStreaKept value) userStreakKept,
    required TResult Function(UserStreakBroke value) userStreakBroke,
  }) {
    return userStreakBroke(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_Initial value)? $default, {
    TResult? Function(UserStreaKept value)? userStreakKept,
    TResult? Function(UserStreakBroke value)? userStreakBroke,
  }) {
    return userStreakBroke?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_Initial value)? $default, {
    TResult Function(UserStreaKept value)? userStreakKept,
    TResult Function(UserStreakBroke value)? userStreakBroke,
    required TResult orElse(),
  }) {
    if (userStreakBroke != null) {
      return userStreakBroke(this);
    }
    return orElse();
  }
}

abstract class UserStreakBroke implements UserConnectionState {
  const factory UserStreakBroke(final DateTime lastConnection) =
      _$UserStreakBroke;

  @override
  DateTime get lastConnection;
  @override
  @JsonKey(ignore: true)
  _$$UserStreakBrokeCopyWith<_$UserStreakBroke> get copyWith =>
      throw _privateConstructorUsedError;
}
