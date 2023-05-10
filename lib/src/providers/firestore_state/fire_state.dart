import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import '../../../models/topic/topic.dart';

class FireState extends ChangeNotifier {
  var topics = <String>[];
  var tempBox = Hive.box("tempBox");
  getTopicsSync() {
    /* var val = syncBox.get('Test');
    print("Val $val"); */
    return tempBox.keys.toList();
  }

  createTopicSync(String item) {
    var topic = Topic(item);
    // print(topic.getNextRecall);
    final valJson = topic.toJson();
    // print("JSON : $valJson");

    tempBox.put(item, valJson);
    print("tempBox keys${tempBox.keys}");
    notifyListeners();
  }
}


