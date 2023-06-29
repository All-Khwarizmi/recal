import 'package:flutter/material.dart';
import 'package:recal_mobile2/presentation/core/design/app_colors.dart';
import 'package:recal_mobile2/presentation/core/design/styles.dart';

class RecText extends StatelessWidget {
  final String text;
  final TextStyle style;

  RecText.headingOne(this.text) : style = heading1Style;
  RecText.headingTwo(this.text) : style = heading2Style;
  RecText.headingThree(this.text) : style = heading3Style;
  RecText.headlineStyle(this.text) : style = headlineStyle;
  RecText.subheadingStyle(this.text) : style = subheadingStyle;
  RecText.captionStyle(this.text) : style = captionStyle;
  RecText.body(this.text, {Color color = kcMediumGreyColor})
      : style = bodyStyle.copyWith(color: color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
    );
  }
}
