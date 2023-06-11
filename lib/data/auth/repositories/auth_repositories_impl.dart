// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

import 'package:recal_mobile2/domain/auth/repositories/auth_repositories.dart';

import '../../../core/error/failure.dart';
import '../../../domain/quizz/entities/user.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  FirebaseMessaging messaging;
  FirebaseAuth firebaseAuth;
  FirebaseFirestore firebaseFirestore;
  AuthRepositoryImpl({
    required this.messaging,
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });
  @override
  Future<Either<Failure, String>> getUserNotificationToken() async {
    try {
      String? token = await messaging.getToken();
      if (token == null) {
        return left(Failure("Could not get user notification token"));
      } else {
        return right(token);
      }
    } catch (e) {
      return left(Failure("Could not get user notification token"));
    }
  }

  //! Modify contract:
  //* Change to Either<Failure, UserEntity>
  @override
  Future<void> signUserAnonymously(
      {required String classId, required String userName}) async {
    try {
      // Get token
      String? token = await messaging.getToken();

      // Sign in user
      UserCredential result = await firebaseAuth.signInAnonymously();

      // Create user instance
      String userId = result.user!.uid;

      UserEntity user = UserEntity(
          userId: userId,
          userName: userName,
          classId: classId,
          userNotificationTokenId: token!,
          userScore: 50,
          lastConnection: DateTime.now(),
          connectionStreak: 1);

      // Saving user instance
      await addUser(user);
    } on FirebaseAuthException {
      throw Failure('Firebase auth exeption');
    } on FirebaseException {
      throw Failure('Firebase exeption');
    }
  }

  @override
  Future<void> addUser(UserEntity user) async {
    // Get collection reference
    var usersRef = firebaseFirestore.collection("users");

    // Add user to DB
    await usersRef.doc(user.userNotificationTokenId).set(user.toMap());
  }

  @override
  Future<Either<Failure, UserEntity>> getUser(userId) async {
    try {
      // Get collection reference
      var usersRef = firebaseFirestore.collection("users");

      // Get user
      var data = await usersRef.doc(userId).get();

      // Parse data
      var userFromDB = UserEntity.fromMap(data.data()!);

      return right(userFromDB);
    } on FirebaseException catch (e) {
      return left(Failure('Firebase exeption'));
    }
  }

  @override
  Stream<User?> userStream() {
    return firebaseAuth.authStateChanges();
  }
}
