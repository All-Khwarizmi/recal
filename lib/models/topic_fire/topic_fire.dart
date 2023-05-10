class TopicFireModel {
  TopicFireModel({
    required this.name,
    required this.lastDate,
    required this.nextDate,
    required this.studySessions,
  });

  final String name;
  final int lastDate;
  final int nextDate;
  final List<dynamic> studySessions;
}
