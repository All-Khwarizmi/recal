import 'package:flutter/material.dart';
import 'package:recal_mobile2/quiz/quizz_item.dart';
import 'package:recal_mobile2/shared/theme.dart';

import '../models/fire_model.dart';

class HomeQuizzList extends StatelessWidget {
  HomeQuizzList({super.key, required this.quizzes});
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
