// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:recal_mobile2/domain/auth/repositories/auth_repositories.dart';

import '../../../domain/quizz/entities/user.dart';

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
  Future<String?> getUserNotificationToken() async {
    String? token = await messaging.getToken();
    return token;
  }

  @override
  Future<void> signUserAnonymously(
      {required String classId, required String userName}) async {
    // Get token
    String? token = await messaging.getToken();

    // Sign in user
    UserCredential result = await firebaseAuth.signInAnonymously();

    // Create user instance
    String userId = result.user!.uid;
    // result.user!.uid;
    User user = User(
        userId: userId,
        userName: userName,
        classId: classId,
        userNotificationTokenId: token!,
        userScore: 50,
        lastConnection: DateTime.now(),
        connectionStreak: 1);

    // Saving user instance
    await addUser(user);
  }

  @override
  Future<void> addUser(User user) async {
    // Get collection reference
    var usersRef = firebaseFirestore.collection("users");

    // Add user to DB
    await usersRef.doc(user.userNotificationTokenId).set(user.toMap());
  }

  @override
  Future<User> getUser(userId) async {
    // Get collection reference
    var usersRef = firebaseFirestore.collection("users");

    // Get user
    var data = await usersRef.doc(userId).get();

    // Parse data
    var userFromDB = User.fromMap(data.data()!);

    return userFromDB;
  }

  @override
  Stream userStream() {
    return firebaseAuth.authStateChanges();
  }
}
