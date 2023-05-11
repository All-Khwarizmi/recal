



import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/src/providers/firestore_state/fire_state.dart';

import '../../../shared/theme.dart';

class TopicPageListTile extends StatelessWidget {
  const TopicPageListTile(
      {super.key,
      required this.topics,
      required this.fireState,
      required this.index,
      required this.recalTheme});

  final int index;
  final topics;
  final RecalTheme recalTheme;
  final FireState fireState;

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
          "What",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        leading: OutlinedButton(
          child: Icon(
            Icons.delete,
            color: Colors.black,
          ),
          onPressed: () => {
           // appState.removeTopic(topics[index]),
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
                    builder: (context) => Placeholder()),
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
    var fireState = context.watch<FireState>();
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
            // appState.removeTopic(topics[index]),
            fireState.deleteTopicFire(topics[index].name),
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
                MaterialPageRoute(builder: (context) => Placeholder()),
              );
            },
          ),
        ));
  }
}


