import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:recal_mobile2/src/providers/firestore_state/fire_state.dart';
import '../../../../providers/hive/main_provider.dart';
import '../../../../shared/theme.dart';
import 'topic_list_tile.dart';

class TopicsList extends StatefulWidget {
  const TopicsList({super.key});

  @override
  State<TopicsList> createState() => _TopicsListState();
}

class _TopicsListState extends State<TopicsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Hive.box("Test_box").close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var boxValues = appState.getTopicsSync();
    var recalTheme = RecalTheme();
    var fireState = context.watch<FireState>();
    var topics = fireState.getTopicList;
    
    if (topics.isEmpty) {
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
      itemCount: topics.length,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: FireTopicListTile(
            topics: topics,
            appState: fireState,
            index: index,
            recalTheme: recalTheme,
          ),
        );
      },
    );
  }
}
