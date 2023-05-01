import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../models/topic/topic.dart';

class MyAppState extends ChangeNotifier {
  var topics = <String>[];
  var syncBox = Hive.box("Test_box");

/*   Future<void> createItem(String item) async {
    var box = await Hive.openBox("Topics_Box");
    await box.add(item);
    notifyListeners();
    print("CreateItem(), $topics");
  }

  Future getItem() async {
    var box = await Hive.openBox("Topics_Box");
    var boxItems = box.values.toList();
    topics = [...topics, ...boxItems];
    notifyListeners();
    print(boxItems);
    return topics;
  }
 */
  getTopicsSync() {
    /* var val = syncBox.get('Test');
    print("Val $val"); */
    return syncBox.keys.toList();
  }

  createTopicSync(String item) {
    var topic = Topic(item);
    // print(topic.getNextRecall);
    final valJson = topic.toJson();
    // print("JSON : $valJson");

    syncBox.put(item, valJson);
    print("syncbox keys${syncBox.keys}");
    notifyListeners();
  }

  int getTopicsLength() {
    return syncBox.length;
  }

  void removeTopic(String item) {
    syncBox.delete(item);
    notifyListeners();
    print(syncBox.values);
  }
}
