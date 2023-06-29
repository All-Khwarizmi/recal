import 'package:flutter/material.dart';
import 'package:recal_mobile2/presentation/core/design/rec_barel.dart';

class RecInputField extends StatelessWidget {
  final String placeholder;
  final Color fillColor;
  final Widget? leading;
  final Widget? trailing;
  final bool password;
  final void Function()? traillingTapped;
  final void Function(String value)? onChanged;
  final String Function()? validator;

  final circularBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  );

  RecInputField({
    super.key,
    this.placeholder = "",
    this.fillColor = kcLightGreyColor,
    this.leading,
    this.trailing,
    this.password = false,
    this.traillingTapped,
    this.onChanged,
    this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => onChanged != null ? onChanged!(value) : null,
      validator: (_) => validator != null ? validator!() : null,
      obscureText: password,
      style: const TextStyle(height: 2, color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: leading,
        suffixIcon: trailing != null
            ? GestureDetector(
                onTap: traillingTapped,
                child: trailing,
              )
            : null,
        labelText: placeholder,
        labelStyle: const TextStyle(color: Colors.white),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 10,
        ),
        filled: false,
        fillColor: fillColor,
        border: circularBorder.copyWith(
          borderSide: const BorderSide(color: kcDarkGreyColor),
        ),
        errorBorder: circularBorder.copyWith(
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: circularBorder.copyWith(
          borderSide: const BorderSide(color: kcDarkGreyColor),
        ),
        enabledBorder: circularBorder.copyWith(
          borderSide: const BorderSide(color: kcDarkGreyColor),
        ),
      ),
    );
  }
}
