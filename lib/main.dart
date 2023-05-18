import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:recal_mobile2/firebase_options.dart';
import 'package:recal_mobile2/routes.dart';

import 'package:recal_mobile2/shared/custom_placeholder.dart';
import 'package:recal_mobile2/shared/temp_scaffold.dart';

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
        if (snapshot.hasError) {
          return MaterialApp(
              home: CustomPlaceHolder(text: snapshot.error.toString()));
        }
        if (snapshot.connectionState == ConnectionState.done) {
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
