import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/failure.dart';
import '../../quizz/entities/user.dart';

abstract class AuthRepository {
  Future<void> signUserAnonymously(
      {required String classId, required String userName});

  Future<Either<Failure, String>> getUserNotificationToken();

  Future<void> addUser(UserEntity user);

  Future<Either<Failure, UserEntity>> getUser(String userId);

  Stream<User?> userStream();

  Future<void> signOutRequested();
}
