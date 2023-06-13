import 'package:flutter/material.dart';

void showSnack({
  required BuildContext context,
  String? message,
  bool loading = true,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
    children: [
      CircularProgressIndicator(),
      SizedBox(
        width: 20,
      ),
      Center(child: Text('Loading...'))
    ],
  )));
  ScaffoldMessenger.of(context);
}
