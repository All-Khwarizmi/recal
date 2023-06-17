import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../sign_in/sign_in_page.dart';
import '../../application/auth/bloc/auth_bloc.dart';
import '../../core/router/routes.dart';
import '../../injection.dart';
import '../shared/theme.dart';

class AppWidget extends StatelessWidget {
  final recalTheme = RecalTheme();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: recalTheme.toThemeData(),
        home: SignInPage(),
      ),
    );
  }
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
