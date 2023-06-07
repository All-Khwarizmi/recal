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
  User user;
  AuthRepositoryImpl({
    required this.messaging,
    required this.firebaseAuth,
    required this.firebaseFirestore,
    required this.user,
  });
  @override
  Future<String?> getUserNotificationToken() async {
    var token = await messaging.getToken();
    return token;
  }

  @override
  Future<void> signUserAnonymously(user) async {
    // TODO: implement signUserAnonymously
    var result = await firebaseAuth.signInAnonymously();
    // result.user!.uid;
    await addUser(user);
  }

  @override
  Future<void> addUser(User user) async {
    // TODO: implement addUser
    // Get collection reference
    var usersRef = firebaseFirestore.collection("users");
    await usersRef.doc(user.userNotificationTokenId).set(user.toMap());
  }
}
