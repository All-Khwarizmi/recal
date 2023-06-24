import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void connectionSnackBar(BuildContext context, String msg, bool isCongrats) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.white30,
      showCloseIcon: false,
      closeIconColor: Colors.orange,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            msg,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 4,
          ),
          isCongrats
              ? const Icon(
                  FontAwesomeIcons.check,
                  color: Colors.green,
                )
              : const Icon(
                  FontAwesomeIcons.x,
                  color: Colors.red,
                ),
        ],
      ),
      duration: const Duration(seconds: 3),
    ),
  );
}
