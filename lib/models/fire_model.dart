
import 'package:json_annotation/json_annotation.dart';
part 'fire_model.g.dart';

@JsonSerializable()
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

  /// Connect the generated [_$QuestionFromJson] function to the `fromJson`
  /// factory.
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Category {
  Category({this.categoryId = '', this.categoryName = ''});
  String categoryId;
  String categoryName;

  /// Connect the generated [_$QuestionFromJson] function to the `fromJson`
  /// factory.
  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);

  /// Connect the generated [_$CategoryToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
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
  final DateTime lastStudy;
  final DateTime nextStudy;
  final List<DateTime> studySessions;

  /// Connect the generated [_$QuizzFromJson] function to the `fromJson`
  /// factory.
  factory Quizz.fromJson(Map<String, dynamic> json) => _$QuizzFromJson(json);

  /// Connect the generated [_$QuizzToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$QuizzToJson(this);
}

@JsonSerializable()
class Question {
  Question({
    this.question = '',
    this.correctAnswer = '',
    required this.answers,
  });
  final String question;
  final String correctAnswer;
  final List<String> answers;

  /// Connect the generated [_$QuestionFromJson] function to the `fromJson`
  /// factory.
  factory Question.fromJson(Map<String, dynamic> json) => _$QuestionFromJson(json);

  /// Connect the generated [_$QuestionToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
