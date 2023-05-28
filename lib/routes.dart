import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:recal_mobile2/home/home.dart';
import 'package:recal_mobile2/login/login.dart';
import 'package:recal_mobile2/quiz/quiz.dart';


var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login' : (context) =>  LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
  

};
