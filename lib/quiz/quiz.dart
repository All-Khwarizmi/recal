import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/quiz/quizz_state.dart';
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
            //print('Num of questions ${questions.length}');
            state.setQuizz(quizz);
            state.setQuestions(questions);
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

class CongratsPage extends StatelessWidget {
  const CongratsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizzState>(context);
    var rapport = state.quizzRapport;
    print(rapport);

    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
              "https://media.giphy.com/media/7rj2ZgttvgomY/giphy.gif"),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Congrats you did it! 🔥',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Column(children: [
              ...state.quizzRapport.entries.map((element) {
                return Column(
                  children: [Text("")],
                );
              })
            ]),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/quizzes',
                  (route) => false,
                );
              },
              child: Text("Close")),
        ],
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage(
      {super.key,
      required this.questions,
      required this.idx,
      required this.quizzName,
      required this.quizz});
  final List<Question> questions;
  final int idx;
  final String quizzName;
  final Quizz quizz;
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizzState>(context);
    //final Question question = questions[idx];

    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Hero(
            tag: quizz.image,
            child: Image.network(
              quizz.image,
              width: MediaQuery.of(context).size.width,
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
    final Question question = questions[idx - 1];
    question.answers.shuffle();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: Text(
              question.question,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        QuestionsList(question: question)
      ],
    );
  }
}

class QuestionsList extends StatefulWidget {
  const QuestionsList({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  State<QuestionsList> createState() {
    return _QuestionsListState();
  }
}

class _QuestionsListState extends State<QuestionsList> {
  String selectedAnswer = '';
  @override
  Widget build(BuildContext context) {
    var state = Provider.of<QuizzState>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...widget.question.answers
              .map((e) => Container(
                  height: 90,
                  margin: const EdgeInsets.only(bottom: 10),
                  color: selectedAnswer == e
                      ? Color.fromARGB(255, 234, 181, 48)
                      : Colors.blueGrey[900],
                  padding: EdgeInsets.all(8),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedAnswer = e;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(
                        16,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            selectedAnswer == e
                                ? FontAwesomeIcons.circleCheck
                                : FontAwesomeIcons.circle,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 16),
                              child: Text(
                                e,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )))
              .toList(),
          const SizedBox(
            height: 20,
          ),
          const SizedBox(
            height: 20,
          ),
          OutlinedButton(
            onPressed: () {
              if (selectedAnswer != null) {
                state.setAnswer(
                    question: widget.question.question,
                    selectedAnswer: selectedAnswer);
                state.nextPage();
              }
            },
            child: Text(
              "Validate",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
