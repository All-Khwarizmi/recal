import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/firestore_state/fire_state.dart';
import '../../../shared/theme.dart';
import 'topic_page_list_tile.dart';

class TopicPageList extends StatefulWidget {
  const TopicPageList({super.key});

  @override
  State<TopicPageList> createState() => _TopicPageListState();
}

class _TopicPageListState extends State<TopicPageList> {
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
          child: TopicPageListTile(
            topics: topics,
            fireState: fireState,
            index: index,
            recalTheme: recalTheme,
          ),
        );
      },
    );
  }
}
