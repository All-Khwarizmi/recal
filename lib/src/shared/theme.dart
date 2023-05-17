import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecalTheme extends ThemeExtension<RecalTheme> {
  const RecalTheme({
    this.primaryColor = const Color(0xFFFF6D00),
    this.primaryColorBis = const Color.fromARGB(255, 250, 154, 82),
    this.secondaryColor = const Color(0xFF212121),
    this.neutralColor = const Color(0xFF616161),
    this.backGroundColor = const Color.fromARGB(221, 35, 35, 35),
  });

  final Color primaryColor,
      secondaryColor,
      neutralColor,
      backGroundColor,
      primaryColorBis;

  ThemeData toThemeData() {
    return ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor, background: Colors.white),
        scaffoldBackgroundColor: backGroundColor);
  }

  Color getPrimary() {
    return primaryColor;
  }

  Color getSecondary() {
    return secondaryColor;
  }

  Color getNeutral() {
    return neutralColor;
  }

  ThemeData _base() {
    final primaryTextTheme = GoogleFonts.interTextTheme();
    final secondaryTextTheme = GoogleFonts.montserratTextTheme();
    final textTheme = primaryTextTheme.copyWith(
        displaySmall: secondaryTextTheme.displaySmall);
    return ThemeData(textTheme: textTheme);
  }

  @override
  ThemeExtension<RecalTheme> copyWith({
    Color? primaryColor,
    Color? secondaryColor,
    Color? neutralColor,
    Color? backGroundColor,
  }) =>
      RecalTheme(
        primaryColor: primaryColor ?? this.primaryColor,
        secondaryColor: secondaryColor ?? this.secondaryColor,
        neutralColor: neutralColor ?? this.neutralColor,
      );

  @override
  RecalTheme lerp(covariant ThemeExtension<RecalTheme>? other, double t) {
    if (other is! RecalTheme) return this;
    return RecalTheme(
        primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
        secondaryColor: Color.lerp(secondaryColor, other.secondaryColor, t)!,
        neutralColor: Color.lerp(neutralColor, other.neutralColor, t)!);
  }
}
