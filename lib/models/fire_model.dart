import 'package:cloud_firestore/cloud_firestore.dart';


class User {
  User({
    this.userId = '',
    this.classId = '',
    this.userNotificationTokenId = '',
    this.userName = '',
    this.userScore = 0,
  });

  String userId;
  String userName;
  String classId;
  String userNotificationTokenId;
  int userScore;
}

class Category {
  Category({this.categoryId = '', this.categoryName = ''});
  String categoryId;
  String categoryName;
}

class Quizz {
  Quizz({
    required this.questions,
    this.subtopicName = "",
    this.topicName = "",
    this.userNotificationTokenId = "",
    this.userId = "",
    required this.lastStudy,
    required this.nextStudy,
    required this.studySessions,
  });
  final String userNotificationTokenId;
  final String userId;
  final String topicName;
  final String subtopicName;
  final List<Question> questions;
  final Timestamp lastStudy;
  final Timestamp nextStudy;
  final List<Timestamp> studySessions;
}

class Question {
  Question({
    this.question = '',
    this.correctAnswer = '',
    required this.answers,
  });
  final String question;
  final String correctAnswer;
  final List<String> answers;
}
