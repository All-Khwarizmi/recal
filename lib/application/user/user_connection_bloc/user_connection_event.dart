part of 'user_connection_bloc.dart';

@freezed
class UserConnectionEvent with _$UserConnectionEvent {
  const factory UserConnectionEvent.started() = _Started;
  const factory UserConnectionEvent.userConnected() = UserConnected;
}