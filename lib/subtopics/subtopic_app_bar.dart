import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/subtopics/subtopic_page_list.dart';
import 'package:recal_mobile2/subtopics/topic_page_title.dart';
import 'package:recal_mobile2/providers/firestore_state/fire_state.dart';
import '../shared/theme.dart';
import '../home/topic_form.dart';


class SubtopicAppBar extends StatelessWidget {
  const SubtopicAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const recalTheme = RecalTheme();

    var fireState = context.watch<FireState>();
    return Scaffold(
        appBar: AppBar(
            backgroundColor: recalTheme.backGroundColor,
            title: Text(
              "Recal",
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
                        print("Notifications single topic page");
                        fireState.addSubTopic('Algebra', "Linear Algebra");
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
          child: Column(children: [
            SizedBox(height: 20),
            SubTopicPageTitle(),
            SizedBox(height: 40),
            SubTopicPageList(),
          ]),
        ));
  }
}
