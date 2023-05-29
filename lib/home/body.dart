import 'package:flutter/material.dart';
import 'package:recal_mobile2/home/home_quizz_list.dart';
import 'package:recal_mobile2/home/show_all_quizzes_button.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/services/database/firestore.dart';
import 'button_primary.dart';
import 'main_title.dart';

class MyAppBody extends StatelessWidget {
  const MyAppBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 40.0),
        child: Wrap(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MainTitle(),
              // MyCustomWidget(),
              const SizedBox(
                height: 40,
              ),

              FutureBuilder<List<Quizz>>(
                future: FirestoreService().getQuizzes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Something went wrong");
                  } else if (snapshot.hasData) {
                    var quizzes = snapshot.data!;
                    return HomeQuizzList(quizzes: quizzes);
                  } else {
                    return Text("Something went wrong");
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ShowAllQuizzes(),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
