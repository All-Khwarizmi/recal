import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/quiz/quiz.dart';

class QuizzItem extends StatelessWidget {
  const QuizzItem({super.key, required this.quizz});
  final Quizz quizz;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: quizz.image,
      child: Card(
        color: Color.fromARGB(255, 231, 133, 64),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => QuizScreen(
                        quizz: quizz,
                      )),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  flex: 3,
                  child: SizedBox(
                    child: Image.network(quizz.image, fit: BoxFit.contain),
                  )),
              Flexible(
                  child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: Text(
                  quizz.quizzName,
                  style: TextStyle(
                    color: Colors.white70,
                    height: 1.5,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.fade,
                  softWrap: false,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizzScreen extends StatelessWidget {
  const QuizzScreen({super.key, required this.quizz});
  final Quizz quizz;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            FontAwesomeIcons.xmark,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: ListView(
        children: [
          Hero(
            tag: quizz.image,
            child: Image.network(
              quizz.image,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          Text(
            quizz.quizzName,
            style: TextStyle(
              height: 2,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text("Start Quizz"),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((BuildContext context) {
                  return QuizScreen(
                    quizz: quizz,
                  );
                })));
              },
            ),
          )
        ],
      ),
    );
  }
}
