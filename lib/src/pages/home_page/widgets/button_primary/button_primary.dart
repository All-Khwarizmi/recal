import 'package:flutter/material.dart';
import 'package:recal_mobile2/src/pages/chapters/chapter_page.dart';
import '../../../../shared/theme.dart';

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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ChaptersPage()));
          }
        },
        child: Text(
          title,
          style: TextStyle(color: recalTheme.primaryColor),
        ));
  }
}
