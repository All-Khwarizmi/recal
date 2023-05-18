import 'package:provider/provider.dart';
import 'package:recal_mobile2/topics/topics_app_bar.dart';
import 'package:recal_mobile2/providers/firestore_state/fire_state.dart';
import 'package:recal_mobile2/shared/theme.dart';

import '../providers/hive/main_provider.dart';
import 'package:flutter/material.dart';

class TopicListTile extends StatelessWidget {
  const TopicListTile(
      {super.key,
      required this.topics,
      required this.appState,
      required this.index,
      required this.recalTheme});

  final int index;
  final topics;
  final RecalTheme recalTheme;
  final MyAppState appState;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.all(10),
        tileColor: !index.isEven
            ? Theme.of(context).colorScheme.onPrimary
            : recalTheme.primaryColorBis,
        textColor: !index.isEven ? recalTheme.primaryColor : Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        title: Text(
          topics[index],
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        leading: OutlinedButton(
          child: Icon(
            Icons.delete,
            color: Colors.black,
          ),
          onPressed: () => {
            appState.removeTopic(topics[index]),
            print(index),
          },
        ),
        trailing: CircleAvatar(
          backgroundColor: recalTheme.secondaryColor,
          child: IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: recalTheme.primaryColor,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Classes(
                          recalTheme: recalTheme,
                        )),
              );
            },
          ),
        ));
  }
}

class FireTopicListTile extends StatelessWidget {
  const FireTopicListTile(
      {super.key,
      required this.topics,
      required this.appState,
      required this.index,
      required this.recalTheme});

  final int index;
  final List<dynamic> topics;
  final RecalTheme recalTheme;
  final FireState appState;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding: EdgeInsets.all(10),
        tileColor: !index.isEven
            ? Theme.of(context).colorScheme.onPrimary
            : recalTheme.primaryColorBis,
        textColor: !index.isEven ? recalTheme.primaryColor : Colors.black,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        title: Text(
          topics[index].name,
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        leading: OutlinedButton(
          child: Icon(
            Icons.delete,
            color: Colors.black,
          ),
          onPressed: () => {
            print(index),
          },
        ),
        trailing: CircleAvatar(
          backgroundColor: recalTheme.secondaryColor,
          child: IconButton(
            icon: Icon(
              Icons.arrow_forward_ios,
              color: recalTheme.primaryColor,
            ),
            onPressed: () {},
          ),
        ));
  }
}

class Classes extends StatelessWidget {
  Classes({super.key, required this.recalTheme});
  RecalTheme recalTheme;
  @override
  Widget build(BuildContext context) {
    return TopicsAppBar();
  }
}
