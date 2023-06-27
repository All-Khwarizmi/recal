import 'package:flutter/material.dart';
import 'package:recal_mobile2/presentation/core/design/rec_barel.dart';

class RecButton extends StatelessWidget {
  const RecButton({
    super.key,
    required this.title,
    this.disabled = false,
    this.busy = false,
  });
  final String title;
  final bool disabled;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        width: double.infinity,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: disabled ? kcDarkGreyColor : kcPrimaryColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: !busy
            ? RecText.body(
                title,
                color: Colors.white,
              )
            : const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
      ),
    );
  }
}
