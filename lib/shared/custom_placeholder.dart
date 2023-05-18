import 'package:flutter/material.dart';

class CustomPlaceHolder extends StatelessWidget {
  const CustomPlaceHolder({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.button,
            textDirection: TextDirection.ltr,
          ),
        ),
      ),
    );
    ;
  }
}
