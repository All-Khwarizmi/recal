class Topic {
  Topic(this.name);
  String name;
}

class Subtopic {
  Subtopic(this.name);
  String name;
}

class Quizz {
  Quizz({
    required this.questions,
    required this.subtopicName,
    required this.topicName,
    required this.userMsgToken,
    required this.userUid,
    required this.nextStudy,
    required this.studySessions,
  });
  String userMsgToken;
  String userUid;
  String topicName;
  String subtopicName;
  List<Question> questions;
  DateTime lastStudy = DateTime.now();
  DateTime nextStudy;
  List<DateTime> studySessions;
}

abstract class Question {
  late String question;
  late String correctAnswer;
  late List<String> answers;
  
}
