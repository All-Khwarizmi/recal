import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/question/question_screen.dart';
import 'package:recal_mobile2/quiz/congrats_page.dart';
import 'package:recal_mobile2/quiz/quizz_state.dart';
import 'package:recal_mobile2/quiz/start_page.dart';
import 'package:recal_mobile2/services/database/firestore.dart';
import 'package:recal_mobile2/shared/error_screen.dart';


class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key, required this.quizz});

  final Quizz quizz;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizzState(),
      child: FutureBuilder(
        future: FirestoreService().getQuestions(quizz.quizzName),
        builder: (context, snapshot) {
          var state = Provider.of<QuizzState>(context);
          if (!snapshot.hasData || snapshot.hasError) {
            return ErrorScreen();
          } else {
            var questions = snapshot.data!;
            print('Num of questions ${questions.length}');
            state.setQuizz(quizz);
            state.setQuestions(questions: questions);
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  quizz.quizzName,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: Colors.transparent,
                leading: IconButton(
                  icon: Icon(
                    FontAwesomeIcons.xmark,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              body: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                controller: state.controller,
                onPageChanged: (int idx) => (idx / (questions.length + 1)),
                itemBuilder: (context, int idx) {
                  print('index: $idx');
                  if (idx == 0) {
                    return StartPage(
                      questions: questions,
                      idx: idx,
                      quizzName: quizz.quizzName,
                      quizz: quizz,
                    );
                  } else if (idx == questions.length + 1) {
                    return CongratsPage();
                  } else {
                    return QuestionPage(
                      idx: idx,
                      questions: questions,
                    );
                  }
                },
              ),
            );
          }
        },
      ),
    );
  }
}
