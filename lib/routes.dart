import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:recal_mobile2/home/home.dart';
import 'package:recal_mobile2/login/login.dart';
import 'package:recal_mobile2/presentation/auth/pages/new_home_page.dart';

import 'quiz/quizzes_screen.dart';

var appRoutes = {
  '/': (context) => const NewHomeScreen(),
  '/login': (context) => LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/quizzes': (context) => const QuizzesScreen(),
};
