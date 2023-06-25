import 'package:dartz/dartz.dart';
import 'package:recal_mobile2/domain/user/user_failures.dart';

abstract class UserRepository {
  // Stream displaying user score
  Either<UserFailure, Stream<int>> userScoreStream();

  // Update user score
  Future<Either<UserFailure, int>> updateUserScore(int newScore);

  // Get user last connection date
  Future<Either<UserFailure, DateTime>> getUserLastConnection();

  // Update user last connection
  Future<Either<UserFailure, Unit>> updateUserLastConnection();

  // Get user connection streak
  Future<Either<UserFailure, int>> getUserConnectionStreak();

  // Update user connection streak
  Future<Either<UserFailure, int>> updateUserConnectionStreak(bool isBroke);
}
