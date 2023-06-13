import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:recal_mobile2/presentation/shared/custom_placeholder.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomPlaceHolder(text: text),
      ),
    );
  }
}
