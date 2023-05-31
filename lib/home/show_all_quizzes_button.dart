import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ShowAllQuizzes extends StatelessWidget {
  const ShowAllQuizzes({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          FontAwesomeIcons.algolia,
          color: Theme.of(context).primaryColor,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: Colors.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, '/quizzes');
        },
        label: Text(
          "Show All",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
