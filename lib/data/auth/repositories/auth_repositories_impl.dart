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

  //! Modify contract:
  //* change function parameter to only
  //? classId
  //? userName
  @override
  Future<void> signUserAnonymously(
      {required String classId, required String userName}) async {
    //* Get token
    String? token = await messaging.getToken();
    //* Get uid from user
    //? Create User instance
    //* Save user in db
    UserCredential result = await firebaseAuth.signInAnonymously();
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

    if (result.user != null) {
      print(user);
    } else {
      print("Check for user: no user");
    }

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
