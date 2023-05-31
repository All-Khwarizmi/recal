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
  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  /// Connect the generated [_$CategoryToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}

@JsonSerializable()
class Quizz {
  Quizz({
    this.quizzName = "",
    this.userNotificationTokenId = "",
    this.quizzId = "",
    this.image = '',
    this.classId = '',
    this.repetitions = 0,
    this.previousInterval = 0,
    this.previousEaseFactor = 2.5,
    this.numberOfQuestions = 0,
    required this.lastStudyDay,
    required this.nextStudyDay,
    required this.studySessions,
    required this.calendar,
  });
  final Calendar calendar;
  final String classId;
  final String image;
  final DateTime lastStudyDay;
  final DateTime nextStudyDay;
  final String quizzId;
  final String quizzName;
  final List<DateTime> studySessions;
  final String userNotificationTokenId;
  final int numberOfQuestions;
  final int repetitions;
  final int previousInterval;
  final num previousEaseFactor;

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
  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  /// Connect the generated [_$QuestionToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}

@JsonSerializable()
class Calendar {
  final DateTime recallOne;
  final DateTime recallTwo;
  final DateTime recallThree;
  final DateTime recallFour;
  final DateTime recallFive;
  final DateTime recallSix;
  final DateTime recallSeven;
  final DateTime recallEight;
  final DateTime recallNine;
  final DateTime recallTen;

  /// Connect the generated [_$QuizzFromJson] function to the `fromJson`
  /// factory.
  factory Calendar.fromJson(Map<String, dynamic> json) =>
      _$CalendarFromJson(json);

  Calendar({
    required this.recallOne,
    required this.recallTwo,
    required this.recallThree,
    required this.recallFour,
    required this.recallFive,
    required this.recallSix,
    required this.recallSeven,
    required this.recallEight,
    required this.recallNine,
    required this.recallTen,
  });

  /// Connect the generated [_$CalendarToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$CalendarToJson(this);
}
