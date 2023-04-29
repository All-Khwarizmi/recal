import 'package:google_fonts/google_fonts.dart';
import 'package:recal_mobile2/src/shared/theme.dart';

import '../../../providers/main_provider.dart';
import 'package:flutter/material.dart';

class TopicListTile extends StatelessWidget {
  const TopicListTile(
      {super.key,
      required this.boxValues,
      required this.appState,
      required this.index,
      required this.recalTheme});

  final int index;
  final boxValues;
  final RecalTheme recalTheme;
  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(10),
      tileColor: !index.isEven
          ? Theme.of(context).colorScheme.onPrimary
          : recalTheme.primaryColorBis,
      textColor: !index.isEven ? recalTheme.primaryColor : Colors.black,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      title: Text(
        boxValues[index],
        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
      ),
      leading: OutlinedButton(
        child: Icon(
          Icons.delete,
          color: Colors.black,
        ),
        onPressed: () => {
          appState.removeTopic(boxValues[index]),
          print(index),
        },
      ),
    );
  }
}
