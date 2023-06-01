import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/quiz/quizz_state.dart';

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
