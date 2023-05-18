import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/providers/firestore_state/fire_state.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Here are the topics you need to study today",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
    );
  }
}
