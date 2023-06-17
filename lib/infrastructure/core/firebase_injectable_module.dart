import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

@module
abstract class FirebaseInjectableModule {
  @preResolve
  Future<FirebaseService> get firebaseService => FirebaseService.init();
  @lazySingleton
  GoogleSignIn get googleSignIn => GoogleSignIn();

  @lazySingleton
  FirebaseAuth get firebaseAuth => FirebaseAuth.instance;

  @lazySingleton
  FirebaseFirestore get store => FirebaseFirestore.instance;

  @lazySingleton
  FirebaseMessaging get messaging => FirebaseMessaging.instance;
}

class FirebaseService {
  static Future<FirebaseService> init() async {
    await Firebase.initializeApp();
    return FirebaseService();
  }
}
