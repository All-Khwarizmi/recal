import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:recal_mobile2/services/authentication/fire_auth.dart';

class TopicsDB {
  final user = AuthService().user;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  var db = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getSubTopics() async {
    return db.collection('users').doc(user!.uid).collection('topics').get();
  }

  Future<String?> getToken() async {
// use the returned token to send messages to users from your custom server
    String? token = await messaging.getToken(
      vapidKey:
          'BOyhTGf45cwhjMYWi4DSvf1Q9Q9Tc8O6ECDkbww8OBia3WZabIJ0dblWk_zF0on1kL5CgYlBxErRN1vsj8fsImE',
    );

    // print("Here's the user permission token $token");
    return token;
  }

  Future<void> addUser() async {
    final token = await getToken();
    final isUserInDb =
        await db.collection('users').where("token", isEqualTo: "token").get();

    if (isUserInDb.size > 0) {
      print('User already in DB ${isUserInDb.size}');
    } else {
      print('User not in db yet ${isUserInDb.size}');
      return db.collection('users').doc(user!.uid).set({
        "uid": user!.uid,
        "token": token,
      });
    }
  }
}
