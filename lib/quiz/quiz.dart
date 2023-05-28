import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/quiz/quizz_state.dart';
import 'package:recal_mobile2/services/database/firestore.dart';
import 'package:recal_mobile2/shared/error_screen.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key, required this.quizzId});
  final String quizzId;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuizzState(),
      child: FutureBuilder(
        future: FirestoreService().getQuestions(quizzId),
        builder: (context, snapshot) {
          var state = Provider.of<QuizzState>(context);
          if (!snapshot.hasData || snapshot.hasError) {
            return ErrorScreen();
          } else {
            var questions = snapshot.data!;
            return Scaffold(
              appBar: AppBar(
                
                title: Text(
                  quizzId,
                  style: TextStyle(color: Theme.of(context).primaryColor),
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
                  if (idx == 0) {
                    return StartPage(
                      questions: questions,
                      idx: idx,
                      quizzName: quizzId,
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

class CongratsPage extends StatelessWidget {
  const CongratsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Congrats you did it! 🔥'),
          const Divider(),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/quizzes',
                  (route) => false,
                );
              },
              child: Text("Close"))
        ],
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({
    super.key,
    required this.questions,
    required this.idx,
    required this.quizzName,
  });
  final List<Question> questions;
  final int idx;
  final String quizzName;
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizzState>(context);
    //final Question question = questions[idx];

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            quizzName,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton.icon(
                onPressed: state.nextPage,
                icon: Icon(Icons.poll),
                label: Text("Start Quizz"),
              )
            ],
          )
        ],
      ),
    );
  }
}

class QuestionPage extends StatelessWidget {
  const QuestionPage({
    super.key,
    required this.questions,
    required this.idx,
  });
  final List<Question> questions;
  final int idx;

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizzState>(context);
    final Question question = questions[idx];

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(
              question.question,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...question.answers
                  .map((e) => Text(
                        e,
                        style: TextStyle(color: Colors.white),
                      ))
                  .toList()
            ],
          ),
        )
      ],
    );
  }
}
