// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:recal_mobile2/domain/auth/repositories/auth_repositories.dart';

class AuthRepositoryImpl implements AuthRepository {
  FirebaseMessaging messaging;
  FirebaseAuth firebaseAuth;
  AuthRepositoryImpl({
    required this.messaging,
    required this.firebaseAuth,
  });
  @override
  Future<String?> getUserNotificationToken() async {
    var token = await messaging.getToken();
    return token;
  }

  @override
  Future<void> signUserAnonymously() async {
    // TODO: implement signUserAnonymously
    await firebaseAuth.signInAnonymously();
  }
}
