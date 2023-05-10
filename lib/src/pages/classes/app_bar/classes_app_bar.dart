import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/src/pages/home_page/widgets/topic_list_tile/topic_list.dart';
import 'package:workmanager/workmanager.dart';
import '../../../../services/workmanager/bg_w_backmanager.dart';
import '../../../providers/hive/main_provider.dart';
import '../../../shared/theme.dart';
import '../../home_page/widgets/topic_form/topic_form.dart';

class ClassesAppBar extends StatelessWidget {
  const ClassesAppBar({
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
                      onPressed: () async {
                        print("Score");
                        Workmanager().initialize(
                          callbackDispatcher,
                          isInDebugMode: true,
                        );
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
                        Workmanager().registerPeriodicTask(
                          failedTaskKey,
                          failedTaskKey,
                          inputData: <String, dynamic>{
                            'int': 1,
                            'bool': true,
                            'double': 1.0,
                            'string': 'string',
                            'array': [1, 2, 3],
                          },
                          initialDelay: Duration(seconds: 5),
                        );
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
