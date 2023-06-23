import 'package:dartz/dartz.dart';
import 'package:recal_mobile2/domain/auth/auth_failures.dart';
import 'package:recal_mobile2/domain/user/user_failures.dart';

abstract class UserRepository {
  // Stream displaying user score
  Stream<Either<UserFailure, int>> userScoreStream();

  // Update user score
  Future<Either<UserFailure, int>> updateUserScore(int newScore);

  // Get user last connection date
  Future<Either<UserFailure, DateTime>> getUserLastConnection();

  // Update user last connection
  Future<Either<AuthFailure, Unit>> updateUserLastConnection();

  // Get user connection streak
  Future<Either<UserFailure, int>> getUserConnectionStreak();

  // Update user connection streak
  Future<Either<UserFailure, int>> updateUserConnectionStreak();
}
