import 'package:flutter/material.dart';
import 'package:recal_mobile2/models/fire_model.dart';

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
    rapport.forEach((key, value) {
      // print(value);
    });
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
  double easeFactor = 0;
  int? repetitions;
  rapport.forEach((key, value) {
    if (value['correctAnswer'] == value["selectedAnswer"]) {
      score++;
    }
  });
  print("The score $score, the numberOfQuestions ${quizz.numberOfQuestions} ");
  easeFactor = score / quizz.numberOfQuestions * 5;
//  print("easeFactor: $easeFactor");
  return {"score": score, "easeFactor": easeFactor};
}
