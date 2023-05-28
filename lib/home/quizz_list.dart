import 'package:flutter/material.dart';
import 'package:recal_mobile2/home/quizz_item.dart';
import 'package:recal_mobile2/shared/theme.dart';

import '../models/fire_model.dart';

class QuizzList extends StatelessWidget {
  QuizzList({super.key, required this.quizzes});
  final List<Quizz> quizzes;
  final RecalTheme recalTheme = RecalTheme();
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      padding: EdgeInsets.all(20.0),
      crossAxisSpacing: 10.0,
      crossAxisCount: 2,
      primary: true,
      children: quizzes.map((e) => QuizzItem(quizz: e)).toList(),
    );
  }
}


/* ListView.builder(
        itemCount: quizzes.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final Quizz quizz = quizzes[index];
          return ListTile(
            tileColor: Color.fromARGB(255, 234, 133, 60),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.network(quizz.image),
            ),
            title: Text(
              quizz.quizzName,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
                "Next session in: ${quizz.nextStudyDay.difference(DateTime.now()).inDays.toString()} days"),
          );
        },
      ); */