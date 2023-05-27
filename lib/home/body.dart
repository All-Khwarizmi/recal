import 'package:flutter/material.dart';
import 'package:recal_mobile2/home/quizz_list.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/services/database/firestore.dart';
import 'button_primary.dart';
import 'main_title.dart';

class MyAppBody extends StatelessWidget {
  const MyAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0),
      child: Wrap(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MainTitle(),
            // MyCustomWidget(),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ButtonPrimary("Classes"),
                  ButtonPrimary("Chapitres"),
                ],
              ),
            ),
            OutlinedButton(
                onPressed: () async {
                  var quizzes = await FirestoreService().getQuizzes();

                  quizzes.forEach((element) {
                    print(element.image);
                  });
                  //print('Subtopics= ${subtopics.docs.first}');
                },
                child: Text('Get quizzes')),
            OutlinedButton(
                onPressed: () async {
                  List<Question> questions =
                      await FirestoreService().getQuestions("El Problema");
                  questions.forEach((element) {
                    print(element.question);
                  });

                  // print('Subtopics= ${subtopics.docs.first}');
                },
                child: Text('Get questions')),
            FutureBuilder(
              future: FirestoreService().getQuizzes(),
              builder: (context, snapshot) {
                return QuizzList(snapshot: snapshot);
              },
            )
          ],
        ),
      ]),
    );
  }
}
