// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fire_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['userId'] as String? ?? '',
      classId: json['classId'] as String? ?? '',
      userNotificationTokenId: json['userNotificationTokenId'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      userScore: json['userScore'] as int? ?? 0,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'classId': instance.classId,
      'userNotificationTokenId': instance.userNotificationTokenId,
      'userScore': instance.userScore,
    };

Category _$CategoryFromJson(Map<String, dynamic> json) => Category(
      categoryId: json['categoryId'] as String? ?? '',
      categoryName: json['categoryName'] as String? ?? '',
    );

Map<String, dynamic> _$CategoryToJson(Category instance) => <String, dynamic>{
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
    };

Quizz _$QuizzFromJson(Map<String, dynamic> json) => Quizz(
      quizzName: json['quizzName'] as String? ?? "",
      userNotificationTokenId: json['userNotificationTokenId'] as String? ?? "",
      quizzId: json['quizzId'] as String? ?? "",
      lastStudy: DateTime.parse(json['lastStudy'] as String),
      nextStudy: DateTime.parse(json['nextStudy'] as String),
      studySessions: (json['studySessions'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
    );

Map<String, dynamic> _$QuizzToJson(Quizz instance) => <String, dynamic>{
      'userNotificationTokenId': instance.userNotificationTokenId,
      'quizzId': instance.quizzId,
      'quizzName': instance.quizzName,
      'lastStudy': instance.lastStudy.toIso8601String(),
      'nextStudy': instance.nextStudy.toIso8601String(),
      'studySessions':
          instance.studySessions.map((e) => e.toIso8601String()).toList(),
    };

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      question: json['question'] as String? ?? '',
      correctAnswer: json['correctAnswer'] as String? ?? '',
      answers:
          (json['answers'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'question': instance.question,
      'correctAnswer': instance.correctAnswer,
      'answers': instance.answers,
    };
