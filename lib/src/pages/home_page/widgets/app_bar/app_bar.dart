import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../providers/main_provider.dart';
import '../../../../shared/theme.dart';
import '../body/body.dart';
import '../topic_form/topic_form.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const recalTheme = RecalTheme();

    var appState = context.watch<MyAppState>();
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
                      onPressed: () {
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
                      onPressed: () {
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
            ]),
        body: MyAppBody());
  }
}
