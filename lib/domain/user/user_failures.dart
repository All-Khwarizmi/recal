import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_failures.freezed.dart';

@freezed
abstract class UserFailure with _$UserFailure {
  const factory UserFailure.noUserData() = NoUserData;
  const factory UserFailure.couldNotAddUserToFirestore() =
      CouldNotAddUserToFirestore;
  const factory UserFailure.couldNotUpdateUserScore() = CouldNotUpdateUserScore;
  const factory UserFailure.couldNotGetUserConnectionData() =
      CouldNotUserLastConnection;
  const factory UserFailure.unexpectedError(error) = UnexpectedError;
}
