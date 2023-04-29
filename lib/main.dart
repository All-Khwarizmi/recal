import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/src/providers/main_provider.dart';
import 'src/pages/home_page/widgets/app_bar/app_bar.dart';
import 'src/shared/theme.dart';
import './services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setup();

  await Hive.initFlutter();
  await Hive.openBox("Test_box");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const recalTheme = RecalTheme();
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        theme: recalTheme.toThemeData(),
        home: MyAppBar(),
      ),
    );
  }
}
