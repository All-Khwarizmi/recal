import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recal_mobile2/application/auth/authentication_bloc/authentication_bloc.dart';
import 'package:recal_mobile2/presentation/shared/loading_screen.dart';

import '../../Legacy/utils/logger.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        print("Splash page");
        print(state.toString());
        state.when(
          initial: () {},
          authenticated: () {
            log(location: 'Splash page', msg: 'Go home page');
            context.go('/home');
          },
          unauthenticated: () {
            log(location: 'Splash page', msg: 'Go sign in page');
            context.go('/signIn');
          },
        );
      },
      builder: (context, state) {
        BlocProvider.of<AuthenticationBloc>(context)
            .add(const AuthenticationEvent.authRequested());
        return const LoadingScreen();
      },
    );
  }
}
