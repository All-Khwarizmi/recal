import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({
    super.key,
    required this.text
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
    );
  }
}
