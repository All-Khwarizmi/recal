import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:recal_mobile2/Legacy/utils/logger.dart';
import 'package:recal_mobile2/application/auth/authentication_bloc/authentication_bloc.dart';
import 'package:recal_mobile2/Legacy/services/database/firestore.dart';

import '../../../core/dependency injection/injection.dart';
import '../../../domain/user/user_repository.dart';
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
    var repo = BlocProvider.of<AuthenticationBloc>(context);
    log(location: 'home page', msg: 'State is : ${repo.state}');

    ScaffoldMessenger.of(context).clearSnackBars();
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        print('State in home page ${state.toString()}');
        state.when(
          initial: () {},
          authenticated: () {},
          unauthenticated: () {
            log(location: 'home page', msg: 'Go sign in page');
            context.go('/signIn');
          },
        );
      },
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
                  onPressedFunction: signOutHolder(repo),
                  icon: Icons.exit_to_app,
                ),
              ]),
          body: const MyAppBody()),
    );
  }
}
