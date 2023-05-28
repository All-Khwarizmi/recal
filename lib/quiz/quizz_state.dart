import 'package:flutter/foundation.dart'; // used in test.dat
import 'package:flutter/material.dart';

class QuizzState with ChangeNotifier {
  double _progress = 0;
 
  final PageController controller = PageController();

  get getProgress => _progress;

  void nextPage() async {
    await controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }
}
