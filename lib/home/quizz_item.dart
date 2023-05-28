import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:recal_mobile2/models/fire_model.dart';

class QuizzItem extends StatelessWidget {
  const QuizzItem({super.key, required this.quizz});
  final Quizz quizz;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Hero(
        tag: quizz.image,
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (BuildContext context) => QuizzScreen(quizz: quizz)),
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
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Text(
                    quizz.quizzName,
                    style: TextStyle(
                      height: 1.5,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.fade,
                    softWrap: false,
                  ),
                ))
              ],
            ),
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
          )
        ],
      ),
    );
  }
}
