// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
      json['name'] as String,
    )
      ..lastRecall = DateTime.parse(json['lastRecall'] as String)
      ..nextRecall = DateTime.parse(json['nextRecall'] as String);

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'name': instance.name,
      'lastRecall': instance.lastRecall.toIso8601String(),
      'nextRecall': instance.nextRecall.toIso8601String(),
    };
