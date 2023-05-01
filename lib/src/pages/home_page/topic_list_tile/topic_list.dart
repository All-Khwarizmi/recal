import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import '../../../providers/main_provider.dart';
import '../../../shared/theme.dart';
import 'topic_list_tile.dart';

class TopicsList extends StatefulWidget {
  const TopicsList({super.key});

  @override
  State<TopicsList> createState() => _TopicsListState();
}

class _TopicsListState extends State<TopicsList> {
  @override
  void dispose() {
    Hive.box("Test_box").close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var boxValues = appState.getTopicsSync();
    var recalTheme = RecalTheme();

    // print("Boxvalues $boxValues");
    if (appState.syncBox.isEmpty) {
      return Center(
        child: Text(
          "No topics just yet",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: boxValues.length,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TopicListTile(
            boxValues: boxValues,
            appState: appState,
            index: index,
            recalTheme: recalTheme,
          ),
        );
      },
    );
  }
}
