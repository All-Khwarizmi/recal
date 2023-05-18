import 'package:flutter/material.dart';
import '../shared/theme.dart';
import 'topic_list_tile.dart';

class ButtonPrimary extends StatelessWidget {
  final String title;
  const ButtonPrimary(this.title);

  @override
  Widget build(BuildContext context) {
    title;

    const recalTheme = RecalTheme();
    return OutlinedButton(
        style: ButtonStyle(
            minimumSize:
                MaterialStateProperty.resolveWith((states) => Size(70, 60)),
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.white)),
        onPressed: () {
          if (title == "Chapitres") {
           
          }
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Classes(
                      recalTheme: recalTheme,
                    )),
          );
        },
        child: Text(
          title,
          style: TextStyle(color: recalTheme.primaryColor),
        ));
  }
}
