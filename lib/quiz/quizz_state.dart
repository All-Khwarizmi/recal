import 'dart:async';

import 'package:flutter/material.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/services/database/firestore.dart';
import 'package:recal_mobile2/utils/sm2/sm2.dart';
import 'package:recal_mobile2/utils/sm2/sm_response.dart';
import 'package:http/http.dart' as http;

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

  Future<Map<String, Map>> quizzRapport() async {
    try {
      _score["rapport"] =
          await calculateRapportScore(quizz: _quizz!, rapport: _tempMap);
      var rapport = _tempMap;

      return rapport;
    } catch (err) {
      print('Error trying execute calculateRapport in quizzState $err');
      return {};
    }
  }

  get scoreRapport => _score;
}

Future calculateRapportScore({
  required Map<String, Map> rapport,
  required Quizz quizz,
}) async {
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

  // Checking whether or not it's time to take a quizz
  if (nextStudyDay.isBefore(DateTime.now())) {
    // If it's not time to take the quizz

    updateScore(quality);
  } else if (nextStudyDay.isAfter(DateTime.now())) {
    // If it's not time to take the quizz
    updateScore(quality);
  } else {
    // If it's time to take the quizz

    ///TODO : find a way to make nextStudyDay a future date using interval
    /// TODO : Find a way to get userName
    try {
      Map<String, dynamic> requestBody = {
        "userId": quizz.userNotificationTokenId,
        "quizzName": quizz.quizzName,
        "nextStudyDay": DateTime.now().toString(),
        "userName": "Jon",
        "userNotificationTokenId": quizz.userNotificationTokenId,
        "repetitions": sm2Results.repetitions.toString(),
        "previousInterval": sm2Results.interval.toString(),
        "previousEaseFactor": sm2Results.easeFactor.toString(),
      };
      var url = Uri.https(
          "us-central1-recal-25c33.cloudfunctions.net", "/quizz-api/quizzDone");
      var response = await http.post(url, body: requestBody);
      print(
          'Hitting quizz done endpoint. Here is the response statusCode: ${response.statusCode}, and the response body ${response.body}');
    } catch (err) {
      print("HTTP request went wrong: $err");
    }
    print(
        "The score $score, the numberOfQuestions ${quizz.numberOfQuestions} ");

    dbService(50);
  }

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
