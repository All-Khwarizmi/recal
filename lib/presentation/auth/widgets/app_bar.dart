import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:recal_mobile2/Legacy/utils/logger.dart';
import 'package:recal_mobile2/application/auth/authentication_bloc/authentication_bloc.dart';
import 'package:recal_mobile2/Legacy/services/database/firestore.dart';

import '../../shared/theme.dart';
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
                UserScoreAppBarIcon(),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 203, 76, 30),
                      child: IconButton(
                        icon: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          FirestoreService().updateUserScore(
                              30); //appState.createTopicSync("whatever sync");
                          /* showModalBottomSheet(
                                        context: context,
                                        builder: ((context) {
                                          return FormInModal();
                                        }));
                                    print("Add"); */
                        },
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 203, 76, 30),
                      child: IconButton(
                        icon: const Icon(
                          FontAwesomeIcons.arrowRightFromBracket,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          repo.add(const AuthenticationEvent.signOut());

                          log(
                              location: 'home page',
                              msg: repo.state.toString());
                          print("Signout");
                          log(
                              location: 'home page',
                              msg: repo.state.toString());
                        },
                      ),
                    ))
              ]),
          body: const MyAppBody()),
    );
  }
}
