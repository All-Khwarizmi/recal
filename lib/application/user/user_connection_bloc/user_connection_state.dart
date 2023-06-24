part of 'user_connection_bloc.dart';

@freezed
class UserConnectionState with _$UserConnectionState {
  const factory UserConnectionState({
    required int connectionStreak,
    required DateTime lastConnection,
  }) = _Initial;

  factory UserConnectionState.initial() =>
      UserConnectionState(connectionStreak: 0, lastConnection: DateTime.now());
  const factory UserConnectionState.userStreakKept(
      int streakConnection, DateTime lastConnection) = UserStreaKept;
  const factory UserConnectionState.userStreakBroke(DateTime lastConnection) =
      UserStreakBroke;
}
