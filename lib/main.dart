import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recal_mobile2/firebase_options.dart';
import 'package:recal_mobile2/home/home.dart';
import 'package:recal_mobile2/quiz/quizzes_screen.dart';
import 'package:recal_mobile2/login/login.dart';
import 'package:recal_mobile2/profile/profile.dart';


import 'shared/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final recalTheme = RecalTheme();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: recalTheme.toThemeData(),
      routes: appRoutes,
    );
  }
}

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/quizzes': (context) => const QuizzesScreen(),
  
};
