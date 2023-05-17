import 'package:cloud_firestore/cloud_firestore.dart';
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
  var isInit = false;
  var topicsList = [];

  Future<void> getSubtopics(String docName) async {
    final list = await FirebaseFirestore.instance
        .collection('topics')
        .doc(docName)
        .collection('subTopic')
        .get();
    const parsedList = [];
    list.docs.forEach((element) => parsedList.add(element));
    topicsList = parsedList;
  }

  @override
  void initState() async {
    super.initState();
    if (!isInit) {
      await getSubtopics("Algebra");
    }
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
    // var subTopics = fireState.getSubTopicList;

    if (topicsList.isEmpty) {
      return Center(
        child: Text(
          "No subTopics just yet",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: topicsList.length,
      itemBuilder: (BuildContext context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: TopicPageListTile(
            subTopics: topicsList,
            fireState: fireState,
            index: index,
            recalTheme: recalTheme,
          ),
        );
      },
    );
  }
}
