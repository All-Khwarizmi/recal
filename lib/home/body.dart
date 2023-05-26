import 'package:flutter/material.dart';
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
                  final categories = await FirestoreService().getCategories();
                  if (!categories.isEmpty) {
                    categories.forEach(
                      (element) => print(element),
                    );
                  }

                  //print('Subtopics= ${subtopics.docs.first}');
                },
                child: Text('Get categories')),
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
