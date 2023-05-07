import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/src/pages/home_page/topic_list_tile/topic_list.dart';

import '../../../shared/theme.dart';
import '../../providers/main_provider.dart';
import '../../shared/theme.dart';
import '../home_page/widgets/topic_form/topic_form.dart';


class ChaptersPage extends StatelessWidget {
  const ChaptersPage({
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
              "Topics",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
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
                      },
                    ),
                  )),
            ]),
        body: Container(
          padding: EdgeInsets.all(10),
          child: Column(children: [TopicsList()]),
        ));
  }
}
