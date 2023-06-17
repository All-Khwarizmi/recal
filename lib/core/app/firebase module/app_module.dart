import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';

import 'firebase_service.dart';

// @module
abstract class AppModule {
  @preResolve
  Future<FirebaseService> get fireService => FirebaseService.init();

    @injectable
  FirebaseFirestore get store => FirebaseFirestore.instance;

  @injectable
  FirebaseAuth get auth => FirebaseAuth.instance;
  
  @injectable
  FirebaseMessaging get messaging => FirebaseMessaging.instance;
}
