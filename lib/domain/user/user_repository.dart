import 'package:dartz/dartz.dart';
import 'package:recal_mobile2/domain/auth/auth_failures.dart';
import 'package:recal_mobile2/domain/user/user_failures.dart';

abstract class UserRepository {
  // Stream displaying user score
  Stream<Either<UserFailures, int>> userScoreStream();

  // Update user score
  Future<Either<UserFailures, int>> updateUserScore(int newScore);

  // Get user last connection date
  Future<Either<UserFailures, DateTime>> getUserLastConnection();

  // Update user last connection
  Future<Either<AuthFailure, Unit>> updateUserLastConnection();

  // Get user connection streak
  Future<Either<UserFailures, int>> getUserConnectionStreak();
}
