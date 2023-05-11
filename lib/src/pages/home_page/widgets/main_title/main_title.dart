import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/src/providers/firestore_state/fire_state.dart';
import 'package:recal_mobile2/src/providers/hive/main_provider.dart';

class MainTitle extends StatelessWidget {
  const MainTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    //  var appState = context.watch<MyAppState>();
    var fireState = context.watch<FireState>();
    return Text(
      fireState.isTopic
          ? "You have nothing to study today"
          : "Here are the topics you need to study today",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
    );
  }
}
