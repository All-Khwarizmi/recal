import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/quiz/quizz_state.dart';

class QuestionsList extends StatefulWidget {
  const QuestionsList({
    super.key,
    required this.question,
    required this.index,
  });

  final Question question;
  final int index;

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
              if (selectedAnswer != "") {
                state.setAnswer(
                    index: widget.index,
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
