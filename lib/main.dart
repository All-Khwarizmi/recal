import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:recal_mobile2/core/router/routes.dart';
import 'package:recal_mobile2/injection.dart';

import 'application/auth/bloc/auth_bloc.dart';

import 'presentation/shared/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  await configureInjection(Environment.prod);
  // await configureDependencies();

  runApp(App());
}

class App extends StatelessWidget {
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
