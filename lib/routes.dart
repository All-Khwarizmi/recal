import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:recal_mobile2/presentation/auth/pages/new_home_page.dart';

import 'presentation/auth/pages/login_screen.dart';
import 'presentation/quiz/quizzes_screen.dart';

var appRoutes = {
  '/': (context) => const NewHomeScreen(),
  '/login': (context) => LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/quizzes': (context) => const QuizzesScreen(),
};
