import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';

import '../../../firebase_options.dart';

FirebaseMessaging messaging = FirebaseMessaging.instance;

class FireState extends ChangeNotifier {
  FireState() {
    init();
  }
  bool _loggedIn = false;

  Future<void> init() async {
    // Initializing App
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
      // ... other providers
    ]);

    // use the returned token to send messages to users from your custom server
    String? token = await messaging.getToken(
      vapidKey:
          'BOyhTGf45cwhjMYWi4DSvf1Q9Q9Tc8O6ECDkbww8OBia3WZabIJ0dblWk_zF0on1kL5CgYlBxErRN1vsj8fsImE',
    );
    await storeToken(token!);
    print("Here's the user permission token $token");
  }

  Future<DocumentReference> storeToken(String token) {
    return FirebaseFirestore.instance.collection('usersFcm').add({
      "token": token,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }
}
