import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recal_mobile2/application/auth/authentication_bloc/authentication_bloc.dart';
import 'package:recal_mobile2/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:recal_mobile2/core/config/router/go_router_config.dart';
import '../sign_in/sign_in_page.dart';
import '../../application/auth/bloc/auth_bloc.dart';
import '../../core/router/routes.dart';
import '../../injection.dart';
import '../shared/theme.dart';

class AppWidget extends StatelessWidget {
  final recalTheme = const RecalTheme();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<SignInFormBloc>()),
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AuthenticationBloc>()
            ..add(const AuthenticationEvent.authRequested()),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: recalTheme.toThemeData(),
        routerConfig: router,
      ),
    );
  }
}

class App extends StatelessWidget {
  final recalTheme = const RecalTheme();

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
