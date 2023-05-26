import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:recal_mobile2/services/authentication/fire_auth.dart';

class TopicsDB {
  final user = AuthService().user;
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  var db = FirebaseFirestore.instance;

  Future addTopic(String topicName) async {
    return db
        .collection('topics')
        .doc(user!.uid)
        .collection('topic')
        .doc(topicName);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getTopics() async {
    return db.collection('topics').doc(user!.uid).get();
  }

  Future addSubTopic({
    required String topicName,
    required String subtopicName,
  }) async {
    return db
        .collection("topics")
        .doc(user!.uid)
        .collection("topic")
        .doc(topicName)
        .collection('subtopics')
        .doc(subtopicName);
  }

  // TODO
  Future addSubTopicQuestion(
      {required String topicName,
      required String subtopicName,
      Map<String, dynamic> data = const {
        "question": "Whats my name?",
        "correctAnswer": "Mike",
        "answers": ["Jon", "Mike", "Sara", "Emy"]
      }}) async {
    return db
        .collection("topics")
        .doc(user!.uid)
        .collection("topic")
        .doc(topicName)
        .collection('subtopics')
        .doc(subtopicName)
        .set(data);
  }

  // TODO: rename getTopics
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

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final user = AuthService().user;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<String?> getToken() async {
// use the returned token to send messages to users from your custom server
    String? token = await messaging.getToken(
      vapidKey:
          'BOyhTGf45cwhjMYWi4DSvf1Q9Q9Tc8O6ECDkbww8OBia3WZabIJ0dblWk_zF0on1kL5CgYlBxErRN1vsj8fsImE',
    );

    // print("Here's the user permission token $token");
    return token;
  }

  Future<void> addUser({
    required String userName,
    required String classId,
    required String userId,
  }) async {
    // Doc ref
    CollectionReference<Map<String, dynamic>> userRef = _db.collection("users");

    // get user token
    var token = await getToken();

    await userRef.doc(token).set({
      "userId": userId,
      "userName": userName,
      "userNotificationTokenId": token,
      "classId": classId,
      "userScore": 50
    });
  }
}
