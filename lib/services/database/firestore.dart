import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/services/authentication/fire_auth.dart';

import '../../utils/quizz_helper.dart';

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
    try {
      // Doc ref
      CollectionReference<Map<String, dynamic>> userRef =
          _db.collection("users");

      // get user token
      var token = await getToken();

      await userRef.doc(token).set({
        "userId": userId,
        "userName": userName,
        "userNotificationTokenId": token,
        "classId": classId,
        "userScore": 50
      });
    } on FirebaseException catch (e) {
      print("Error in addUser FirestoreService method");
    }
  }

  // Get categories (classes)
  Future<List<Category>> getCategories() async {
    try {
      // Doc ref
      CollectionReference<Map<String, dynamic>> categoryRef =
          _db.collection('category');

      // Get categories
      var snapshot = await categoryRef.get();
      var data = snapshot.docs.map((e) => e.data());
      var categories = data.map((d) => Category.fromJson(d));

      return categories.toList();

      //
    } on FirebaseException catch (e) {
      print("Error in addUser FirestoreService method $e");
      Category defaultCategory = Category(
          categoryId: "no category", categoryName: "No category just yet");
      return [defaultCategory];
    }
  }

  // Get Quizzes
  Future<List<Quizz>> getQuizzes() async {
    // Get Token
    String? token = await getToken();
    /* // Get user classId
    var rawUer = await _db.collection('users').doc(token).get();
    User user = User.fromJson(rawUer.data()!); */
    // Doc ref
    CollectionReference<Map<String, dynamic>> quizzesRef =
        _db.collection("users").doc(token).collection("todoQuizz");
    List<Quizz> quizzes = [];
    // Get quizzes
    var snapshot = await quizzesRef.get();

    snapshot.docs.forEach((e) {
      quizzes.add(quizzSerializer(e));
    });

    return quizzes;
  }

  // Get quizz questions
  Future<List<Question>> getQuestions(String quizzName) async {
    String? token = await getToken();
    // Doc ref
    var questionsRef = _db
        .collection("users")
        .doc(token)
        .collection("todoQuizz")
        .doc(quizzName)
        .collection("questions");
    var snapshot = await questionsRef.get();
    var data = snapshot.docs.map((element) {
      return element.data();
    });
    var questions = data.map((e) => Question.fromJson(e)).toList();
    print("Num of question in firestore method ${questions.length}");
    questions.forEach((element) {
      print(element.question);
    });

    return questions;
  }

  Future userScoreStram() async {
    String? token = await getToken();
    var userRef = _db.collection('users').doc(token);
    return await userRef.snapshots().listen(
      (event) {
        print('Real time event ${event.data()}');
       
      },
      onError: (error) => print("Listen failed: $error"),
    );
  }
}
