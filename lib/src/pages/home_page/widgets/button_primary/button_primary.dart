import 'package:flutter/material.dart';
import '../../../../shared/theme.dart';


class ButtonPrimary extends StatelessWidget {
  final String title;
  const ButtonPrimary(this.title);

  @override
  Widget build(BuildContext context) {
    const recalTheme = RecalTheme();
    return OutlinedButton(
        style: ButtonStyle(
            minimumSize:
                MaterialStateProperty.resolveWith((states) => Size(70, 60)),
            backgroundColor:
                MaterialStateColor.resolveWith((states) => Colors.white)),
        onPressed: () {},
        child: Text(
          title,
          style: TextStyle(color: recalTheme.primaryColor),
        ));
  }
}
