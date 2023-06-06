// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:recal_mobile2/domain/auth/repositories/auth_repositories.dart';

class AuthRepositoryImpl implements AuthRepository {
  FirebaseMessaging messaging;
  AuthRepositoryImpl({
    required this.messaging,
  });
  @override
  Future<String?> getUserNotificationToken() async {
    var token = await messaging.getToken();
    return token;
  }

  @override
  Future<void> signUserAnonymously() {
    // TODO: implement signUserAnonymously
    throw UnimplementedError();
  }
}
