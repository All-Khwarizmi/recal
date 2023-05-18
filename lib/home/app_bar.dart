import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recal_mobile2/services/authentication/fire_auth.dart';
import '../services/local_notifications/notification_service.dart';

import '../shared/theme.dart';
import 'body.dart';
import 'topic_form.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late final LocalNotificationService service;
    service = LocalNotificationService();
    service.setup();

    const recalTheme = RecalTheme();

    return HomeScaffold(
      recalTheme: recalTheme,
    );
  }
}

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({
    super.key,
    required this.recalTheme,
  });

  final RecalTheme recalTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: recalTheme.backGroundColor,
            title: Text(
              "Recal",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0),
            ),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: recalTheme.primaryColorBis,
                    child: IconButton(
                      icon: Icon(Icons.score),
                      onPressed: () async {
                        print("Score");
                      },
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: recalTheme.primaryColorBis,
                    child: IconButton(
                      icon: Icon(Icons.notifications,
                          color: recalTheme.secondaryColor),
                      onPressed: () async {
                        print("Notifications");
                      },
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: recalTheme.primaryColorBis,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        //appState.createTopicSync("whatever sync");
                        showModalBottomSheet(
                            context: context,
                            builder: ((context) {
                              return FormInModal();
                            }));
                        print("Add");
                      },
                    ),
                  )),
              Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: recalTheme.primaryColorBis,
                    child: IconButton(
                      icon: Icon(FontAwesomeIcons.arrowRightFromBracket),
                      onPressed: () {
                        //appState.createTopicSync("whatever sync");
                        AuthService().signOut();
                        print("Signout");
                      },
                    ),
                  )),
            ]),
        body: MyAppBody());
  }
}
