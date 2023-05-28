import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:recal_mobile2/home/quizz_list.dart';

import '../models/fire_model.dart';
import '../services/database/firestore.dart';

class QuizzesScreen extends StatelessWidget {
  const QuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<List<Quizz>>(
        future: FirestoreService().getQuizzes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
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
