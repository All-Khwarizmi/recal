import 'package:flutter/material.dart';
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
              padding: const EdgeInsets.only(top: 30),
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
                  
                  final quizzes =
                      await FirestoreService().getQuizzes(classId: "502");
                  if (!quizzes.isEmpty) {
                    quizzes.forEach(
                      (element) => print(element),
                    );
                  }

                  //print('Subtopics= ${subtopics.docs.first}');
                },
                child: Text('Get quizzes')),
            OutlinedButton(
                onPressed: () async {
                  TopicsDB().addUser();

                  // print('Subtopics= ${subtopics.docs.first}');
                },
                child: Text('Add User'))
          ],
        ),
      ]),
    );
  }
}
