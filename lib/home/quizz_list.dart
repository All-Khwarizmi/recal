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
            tileColor: Color.fromARGB(255, 234, 133, 60),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.network(snapshot.data![index].image),
            ),
            title: Text(
              snapshot.data![index].quizzName,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle:
                Text(snapshot.data![index].nextStudyDay.toUtc().toString()),
          );
        },
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}
