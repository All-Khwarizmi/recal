import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/src/providers/hive/main_provider.dart';
import 'package:go_router/go_router.dart';
import 'src/pages/home_page/home_page.dart';
import 'src/pages/home_page/widgets/app_bar/app_bar.dart';
import 'src/providers/firestore_state/fire_state.dart';
import 'src/shared/theme.dart';

Future<void> initializeFireApp() async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeFireApp();
  // Back service initializer
  // background_service
  // await initializeService();

  // Workmanager
/*   Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  ); */
  /*Workmanager().registerOneOffTask(
    simpleTaskKey,
    simpleTaskKey,
  ); */

// Hive DB initializers
  await Hive.initFlutter();
  await Hive.openBox("Test_box");
  await Hive.openBox("tempBox");

  // Hive with adapter
  // Hive.registerAdapter(MemoAdapter());
  // await Hive.openBox<Memo>("Memo");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const recalTheme = RecalTheme();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyAppState()),
        ChangeNotifierProvider(create: (context) => FireState()),
      ],
      child: MaterialApp(
        theme: recalTheme.toThemeData(),
        home: HomePage(),
      ),
    );
  }
}




/* 
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const recalTheme = RecalTheme();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MyAppState()),
        ChangeNotifierProvider(create: (context) => FireState()),
      ],
      child: MaterialApp(
        theme: recalTheme.toThemeData(),
        home: HomePage(),
      ),
    );
  }
} */