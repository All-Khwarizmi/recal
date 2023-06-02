import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recal_mobile2/quiz/quizz_list.dart';
import '../models/fire_model.dart';
import '../services/database/firestore.dart';

class QuizzesScreen extends StatelessWidget {
  const QuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Quizzes",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              FontAwesomeIcons.xmark,
              color: Theme.of(context).primaryColor,
            )),
      ),
      body: FutureBuilder<List<Quizz>>(
        future: FirestoreService().getQuizzes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Something went wrong");
          } else if (snapshot.hasData) {
            var quizzes = snapshot.data!;
            return QuizzList(quizzes: quizzes);
          } else {
            return Text("Something went wrong");
          }
        },
      ),
    );
  }
}
