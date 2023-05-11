import 'package:flutter/material.dart';
import 'package:recal_mobile2/src/pages/chapters/chapter_page.dart';
import '../../../../shared/theme.dart';
import '../topic_list_tile/topic_list_tile.dart';

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
