import 'package:flutter/material.dart';
import 'package:recal_mobile2/presentation/core/design/app_colors.dart';
import 'package:recal_mobile2/presentation/core/design/styles.dart';

class RecText extends StatelessWidget {
  final String text;
  final TextStyle style;

  const RecText.headingOne(this.text) : style = heading1Style;
  const RecText.headingTwo(this.text) : style = heading2Style;
  const RecText.headingThree(this.text) : style = heading3Style;
  const RecText.headlineStyle(this.text) : style = headlineStyle;
  const RecText.subheadingStyle(this.text) : style = subheadingStyle;
  const RecText.captionStyle(this.text) : style = captionStyle;
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
