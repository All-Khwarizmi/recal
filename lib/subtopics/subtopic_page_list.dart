import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recal_mobile2/topics/topic_page_list_tile.dart';

import '../providers/firestore_state/fire_state.dart';
import '../shared/theme.dart';

class SubTopicPageList extends StatefulWidget {
  const SubTopicPageList({super.key});

  @override
  State<SubTopicPageList> createState() => _SubTopicPageListState();
}

class _SubTopicPageListState extends State<SubTopicPageList> {
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
