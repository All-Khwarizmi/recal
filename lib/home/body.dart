import 'package:flutter/material.dart';
import 'package:recal_mobile2/home/home_quizz_list.dart';
import 'package:recal_mobile2/home/show_all_quizzes_button.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/services/database/firestore.dart';
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
              FutureBuilder<List<Quizz>>(
                future: FirestoreService().getQuizzes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    var err = snapshot.error;
                    return Text(
                      "Something went wrong 🩸 $err",
                      style: TextStyle(color: Colors.red),
                    );
                  } else if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Text(
                        "No topics just yet",
                        style: TextStyle(color: Colors.white),
                      );
                    } else {
                      var quizzes = snapshot.data!;
                      List<Quizz> filteredQuizes = quizzes
                          .where((element) =>
                              element.nextStudyDay
                                  .difference(DateTime.now())
                                  .inHours <
                              16)
                          .toList();
                      return Column(
                        children: [
                          filteredQuizes.isEmpty
                              ? MainTitle(
                                  text:
                                      "You are up to date already! Check all the quizes for more...")
                              : MainTitle(
                                  text: 'Here are the quiz you have today'),
                          // MyCustomWidget(),
                          filteredQuizes.isEmpty
                              ? const SizedBox()
                              : const SizedBox(
                                  height: 40,
                                ),
                          HomeQuizzList(quizzes: quizzes),
                          filteredQuizes.isEmpty
                              ? const SizedBox()
                              : const SizedBox(
                                  height: 20,
                                ),
                          ShowAllQuizzes(),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      );
                    }
                  } else {
                    return Text("Something went wrong");
                  }
                },
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
