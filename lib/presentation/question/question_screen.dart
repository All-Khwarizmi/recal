import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/presentation/question/question_list.dart';
import 'package:recal_mobile2/presentation/quiz/quizz_state.dart';

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
        QuestionsList(
          question: question,
          index: idx,
        )
      ],
    );
  }
}
