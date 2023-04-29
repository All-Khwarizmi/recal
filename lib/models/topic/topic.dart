import 'package:json_annotation/json_annotation.dart';

part 'topic.g.dart';

@JsonSerializable()
class Topic {
  late String name;
  late DateTime lastRecall = DateTime.now();
  late DateTime nextRecall = lastRecall.add(const Duration(days: 2));
  Topic(this.name);

  DateTime get getLastRecall {
    return lastRecall;
  }

  DateTime get getNextRecall {
    return nextRecall;
  }

  String get getname {
    return name;
  }

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  Map<String, dynamic> toJson() => _$TopicToJson(this);
}
