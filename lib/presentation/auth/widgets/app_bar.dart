import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recal_mobile2/Legacy/utils/logger.dart';
import 'package:recal_mobile2/application/auth/authentication_bloc/authentication_bloc.dart';
import 'package:recal_mobile2/application/user/user_connection_bloc/user_connection_bloc.dart';
import '../../core/connection_snackbar.dart';
import '../../shared/theme.dart';
import 'main_appbar_button.dart';
import 'user_score_appbar_icon.dart';
import './home_screen_body.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    super.key,
    required this.recalTheme,
  });

  final RecalTheme recalTheme;

  @override
  Widget build(BuildContext context) {
    var authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            state.maybeWhen(
              orElse: () {},
              unauthenticated: () {
                log(location: 'home page', msg: 'Go sign in page');
                context.go('/signIn');
              },
            );
          },
        ),
        BlocListener<UserConnectionBloc, UserConnectionState>(
          listener: (context, state) {
            state.when(
              (connectionStreak, lastConnection) => null,
              userStreakKept: (connectionStreak, lastconnection) {
                connectionSnackBar(
                    context, 'Connection Streak: $connectionStreak', true);
              },
              userStreakBroke: (lastconnection) {
                connectionSnackBar(
                    context, 'Connect every day to get more points', false);
              },
            );
          },
        )
      ],
      child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: const Text(
                "Recal",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40.0),
              ),
              actions: <Widget>[
                const UserScoreAppBarIcon(),
                const AppBarButton(
                  onPressedFunction: updateScoreButtonMethod,
                  icon: Icons.add,
                ),
                AppBarButton(
                  onPressedFunction:
                      signOutButtonHolderMethod(authenticationBloc, context),
                  icon: Icons.exit_to_app,
                ),
              ]),
          body: const MyAppBody()),
    );
  }
}
