import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recal_mobile2/firebase_options.dart';
import 'package:recal_mobile2/home/app_bar.dart';
import 'package:recal_mobile2/home/home.dart';
import 'package:recal_mobile2/login/login.dart';
import 'package:recal_mobile2/profile/profile.dart';
import 'package:recal_mobile2/quiz/quiz.dart';
import 'package:recal_mobile2/shared/custom_placeholder.dart';
import 'package:recal_mobile2/shared/temp_scaffold.dart';
import 'package:recal_mobile2/topics/topics.dart';

import 'shared/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final recalTheme = RecalTheme();

  final Future<FirebaseApp> _initialization =
      Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        final localSnapshot = snapshot;
        print("Firebase init state ${localSnapshot.connectionState}");
        print("Firebase init data ${localSnapshot.hasData}");
        if (localSnapshot.hasError) {
          return MaterialApp(
              home: CustomPlaceHolder(text: localSnapshot.error.toString()));
        }
        if (localSnapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            theme: recalTheme.toThemeData(),
            routes: appRoutes,
          );
        }

        return MaterialApp(home: CustomScaffold(text: 'Loading...'));
      },
    );
  }
}

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => LoginScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/quiz': (context) => const QuizScreen(),
  '/topics': (context) => const TopicsScreen(),
};
