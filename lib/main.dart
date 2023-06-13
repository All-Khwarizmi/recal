import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recal_mobile2/routes.dart';

import 'domain/auth/bloc/auth_bloc.dart';
import 'injection.dart';
import 'presentation/shared/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await configureDependencies();

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
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: MaterialApp(
        theme: recalTheme.toThemeData(),
        routes: appRoutes,
      ),
    );
  }
}
