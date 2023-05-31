import 'package:flutter/material.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/services/database/firestore.dart';
import 'package:recal_mobile2/utils/sm2/sm2.dart';
import 'package:recal_mobile2/utils/sm2/sm_response.dart';

class QuizzState with ChangeNotifier {
  double _progress = 0;
  Quizz? _quizz;
  List<Question>? _questions;
  Map<String, Map> _tempMap = {};
  Map<String, Map> _score = {};

  final PageController controller = PageController();

  get getProgress => _progress;

  void nextPage() async {
    await controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  void setQuizz(Quizz quizz) {
    _quizz = quizz;

    print('Quizz Setted ${_quizz?.quizzName}');
  }

  void setQuestions({
    required List<Question> questions,
  }) {
    _questions = questions;

    questions.forEach((element) {
      _tempMap[element.question] = {
        "question": element.question,
        "answers": element.answers,
        "correctAnswer": element.correctAnswer,
        "selectedAnswer": '',
        "index": 0,
      };
    });
    print('Number of Questions Setted: ${questions.length}');
    print('Size of _tempMap: ${_tempMap.length}');
  }

  void setAnswer({
    required int index,
    required String question,
    required String selectedAnswer,
  }) {
    _tempMap[question]!["selectedAnswer"] = selectedAnswer;
    _tempMap[question]!["index"] = index;

    print('updating _tempMap $_tempMap');
  }

  Map<String, Map> quizzRapport() {
    _score["rapport"] =
        calculateRapportScore(quizz: _quizz!, rapport: _tempMap);
    var rapport = _tempMap;

    return rapport;
  }

  get scoreRapport => _score;
}

/// Retrieve old values from Quizz
/// Calcultes if it's time to take the quizz and thus hit endpoint onQuizzDone to update user todoQuizz subcollection
/// Calculates new values from results
/// Updates user score accordingly
///
///
calculateRapportScore({
  required Map<String, Map> rapport,
  required Quizz quizz,
}) {
  double score = 0;
  final int oldRepetitions = quizz.repetitions;
  final int previousInterval = quizz.previousInterval;
  num previousEaseFactor = quizz.previousEaseFactor;
  final nextStudyDay = quizz.nextStudyDay;
  print(nextStudyDay);
  var dbService = FirestoreService().updateUserScore;

// Calculating new values
  rapport.forEach((key, value) {
    if (value['correctAnswer'] == value["selectedAnswer"]) {
      score++;
    }
  });
  double quality = score / quizz.numberOfQuestions * 5;

  final Sm sm2 = Sm();
  SmResponse sm2Results = sm2.calc(
      quality: quality,
      repetitions: oldRepetitions,
      previousInterval: previousInterval,
      previousEaseFactor: previousEaseFactor);

  /// Checking whether or not it's time to take a quizz
  if (nextStudyDay.isBefore(DateTime.now())) {
    // If it's not time to take the quizz

    updateScore(quality);
  } else if (nextStudyDay.isAfter(DateTime.now())) {
    // If it's not time to take the quizz
    updateScore(quality);
  } else {
    // If it's time to take the quizz
    /// Call quizzDone endpoint

    dbService(50);
  }

  print("The score $score, the numberOfQuestions ${quizz.numberOfQuestions} ");

//  print("easeFactor: $easeFactor");
  return {"score": quality, "easeFactor": sm2Results.easeFactor};
}

void updateScore(double quality) {
  var dbService = FirestoreService().updateUserScore;
  if (quality >= 4) {
    dbService(10);
  } else if (quality >= 2.5 && quality > 4) {
    dbService(5);
  } else if (quality < 2.5) {
    dbService(3);
  }
}
