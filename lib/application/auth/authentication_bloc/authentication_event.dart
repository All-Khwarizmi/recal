part of 'authentication_bloc.dart';

@freezed
class AuthenticationEvent with _$AuthenticationEvent {
  const factory AuthenticationEvent.authRequested() = _Started;
  const factory AuthenticationEvent.signOut() = SignOut;
}
