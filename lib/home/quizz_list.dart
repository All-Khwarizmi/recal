import 'package:flutter/material.dart';
import 'package:recal_mobile2/shared/loading_screen.dart';
import 'package:recal_mobile2/shared/theme.dart';

import '../models/fire_model.dart';

class QuizzList extends StatelessWidget {
  QuizzList({super.key, required this.snapshot});
  final AsyncSnapshot<List<Quizz>> snapshot;
  final RecalTheme recalTheme = RecalTheme();
  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data!.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: recalTheme.primaryColor,
            shape: Border.all(style: BorderStyle.values.first),
            leading:
                CircleAvatar(child: Image.network(snapshot.data![index].image)),
            title: Text(
              snapshot.data![index].quizzName,
              style: TextStyle(color: Colors.amber),
            ),
          );
        },
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}
