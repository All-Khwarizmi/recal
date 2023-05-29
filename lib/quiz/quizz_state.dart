import 'package:flutter/material.dart';
import 'package:recal_mobile2/models/fire_model.dart';

class QuizzState with ChangeNotifier {
  double _progress = 0;
  Quizz? _quizz;
  List<Question>? _questions;
  Map _tempMap = {};
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

  void setQuestions(List<Question> questions) {
    _questions = questions;

    questions.forEach((element) {
      _tempMap[element.question] = {
        "question": element.question,
        "answers": element.answers,
        "correctAnswer": element.correctAnswer,
        "selectedAnswer": ''
      };
    });
    print('Number of Questions Setted: ${questions.length}');
  }

  void setAnswer({
    required String question,
    required String selectedAnswer,
  }) {
    _tempMap[question]["selectedAnswer"] = selectedAnswer;

    print('updating _tempMap $_tempMap');
  }

  get quizzRapport => _tempMap;
}
