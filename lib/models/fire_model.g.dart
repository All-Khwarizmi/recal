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
      image: json['image'] as String? ?? '',
      classId: json['classId'] as String? ?? '',
      repetitions: json['repetitions'] as int? ?? 0,
      previousInterval: json['previousInterval'] as int? ?? 0,
      previousEaseFactor: json['previousEaseFactor'] as num? ?? 2.5,
      numberOfQuestions: json['numberOfQuestions'] as int? ?? 0,
      lastStudyDay: DateTime.parse(json['lastStudyDay'] as String),
      nextStudyDay: DateTime.parse(json['nextStudyDay'] as String),
      studySessions: (json['studySessions'] as List<dynamic>)
          .map((e) => DateTime.parse(e as String))
          .toList(),
      calendar: Calendar.fromJson(json['calendar'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$QuizzToJson(Quizz instance) => <String, dynamic>{
      'calendar': instance.calendar,
      'classId': instance.classId,
      'image': instance.image,
      'lastStudyDay': instance.lastStudyDay.toIso8601String(),
      'nextStudyDay': instance.nextStudyDay.toIso8601String(),
      'quizzId': instance.quizzId,
      'quizzName': instance.quizzName,
      'studySessions':
          instance.studySessions.map((e) => e.toIso8601String()).toList(),
      'userNotificationTokenId': instance.userNotificationTokenId,
      'numberOfQuestions': instance.numberOfQuestions,
      'repetitions': instance.repetitions,
      'previousInterval': instance.previousInterval,
      'previousEaseFactor': instance.previousEaseFactor,
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

Calendar _$CalendarFromJson(Map<String, dynamic> json) => Calendar(
      recallOne: DateTime.parse(json['recallOne'] as String),
      recallTwo: DateTime.parse(json['recallTwo'] as String),
      recallThree: DateTime.parse(json['recallThree'] as String),
      recallFour: DateTime.parse(json['recallFour'] as String),
      recallFive: DateTime.parse(json['recallFive'] as String),
      recallSix: DateTime.parse(json['recallSix'] as String),
      recallSeven: DateTime.parse(json['recallSeven'] as String),
      recallEight: DateTime.parse(json['recallEight'] as String),
      recallNine: DateTime.parse(json['recallNine'] as String),
      recallTen: DateTime.parse(json['recallTen'] as String),
    );

Map<String, dynamic> _$CalendarToJson(Calendar instance) => <String, dynamic>{
      'recallOne': instance.recallOne.toIso8601String(),
      'recallTwo': instance.recallTwo.toIso8601String(),
      'recallThree': instance.recallThree.toIso8601String(),
      'recallFour': instance.recallFour.toIso8601String(),
      'recallFive': instance.recallFive.toIso8601String(),
      'recallSix': instance.recallSix.toIso8601String(),
      'recallSeven': instance.recallSeven.toIso8601String(),
      'recallEight': instance.recallEight.toIso8601String(),
      'recallNine': instance.recallNine.toIso8601String(),
      'recallTen': instance.recallTen.toIso8601String(),
    };
