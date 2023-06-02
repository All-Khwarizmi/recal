import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hive/hive.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/services/authentication/fire_auth.dart';

import '../../utils/quizz_helper.dart';

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
    var tokenBox = Hive.box('token');
    tokenBox.put('token', token);
    // print(token);

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
      print("Error in addUser FirestoreService method $e");
    }
  }

  Future<User> getUser() async {
    // Get user token
    String? token = await getToken();

    // Get user doc ref
    var userRef = _db.collection('users').doc(token);

    // Get user doc
    var userDoc = await userRef.get();

    if (userDoc.exists) {
      // Serializing user
      User userData = User.fromJson(userDoc.data()!);
      return userData;
    } else {
      return User();
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

    // Doc ref
    CollectionReference<Map<String, dynamic>> quizzesRef =
        _db.collection("users").doc(token).collection("todoQuizz");
    List<Quizz> quizzes = [];
    // Get quizzes
    var snapshot = await quizzesRef.get();

    snapshot.docs.forEach((e) {
      try {
        quizzes.add(quizzSerializer(e));
      } catch (err) {
        print("Error trying serializing quizz $err");
      }
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
    return userRef.snapshots;
  }

  Future updateUserScore(int score) async {
    // Get user token
    String? token = await getToken();

    // Get doc ref
    var userRef = _db.collection('users').doc(token);

    // Getting user score

    var user = await userRef.get();
    // Destructuring user data
    int oldScore = user.data()!["userScore"];

    // Updating user score
    userRef.update(
      {"userScore": oldScore + score},
    );
  }
}
