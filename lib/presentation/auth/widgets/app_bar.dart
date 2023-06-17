import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:recal_mobile2/application/auth/bloc/auth_bloc.dart';
import 'package:recal_mobile2/Legacy/services/database/firestore.dart';

import '../../shared/theme.dart';
import 'user_score_appbar_icon.dart';
import './home_screen_body.dart';

class HomeScaffold extends StatelessWidget {
  HomeScaffold({
    super.key,
    required this.recalTheme,
  });

  final RecalTheme recalTheme;

  @override
  Widget build(BuildContext context) {
    var repo = BlocProvider.of<AuthBloc>(context);
    ScaffoldMessenger.of(context).clearSnackBars();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Recal",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0),
            ),
            actions: <Widget>[
              UserScoreAppBarIcon(),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 203, 76, 30),
                    child: IconButton(
                      icon: Icon(
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
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 203, 76, 30),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.arrowRightFromBracket,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        repo.add(SignOutRequested());
                        print("Signout");
                        print(repo.state);
                      },
                    ),
                  ))
            ]),
        body: MyAppBody());
  }
}
