import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/fire_model.dart';

List<DateTime> studySessionsMaker(dynamic sessions) {
  List<DateTime> list = [];
  sessions.forEach((d) {
    list.add(studyDayMaker(d));
  });

  return list;
}

DateTime studyDayMaker(
  dynamic studyDay,
) {
  var returnStudyDay = studyDay  ?? DateTime.now();
  return returnStudyDay.runtimeType == DateTime
      ? DateTime.now()
      : studyDay.toDate();
}

Calendar calendarMaker(calendar) {
  final DateTime recallOne = getDayFromCalendar(calendar, "recallOne");
  final DateTime recallTwo = getDayFromCalendar(calendar, "recallTwo");
  final DateTime recallThree = getDayFromCalendar(calendar, "recallThree");
  final DateTime recallFour = getDayFromCalendar(calendar, "recallFour");
  final DateTime recallFive = getDayFromCalendar(calendar, "recallFive");
  final DateTime recallSix = getDayFromCalendar(calendar, "recallSix");
  final DateTime recallSeven = getDayFromCalendar(calendar, "recallSeven");
  final DateTime recallEight = getDayFromCalendar(calendar, "recallEight");
  final DateTime recallNine = getDayFromCalendar(calendar, "recallNine");
  final DateTime recallTen = getDayFromCalendar(calendar, "recallTen");
  Calendar newCalendar = Calendar(
      recallOne: recallOne,
      recallTwo: recallTwo,
      recallThree: recallThree,
      recallFour: recallFour,
      recallFive: recallFive,
      recallSix: recallSix,
      recallSeven: recallSeven,
      recallEight: recallEight,
      recallNine: recallNine,
      recallTen: recallTen);

  return newCalendar;
}

DateTime getDayFromCalendar(calendar, dayName) {
  return studyDayMaker(calendar[dayName]);
}

Quizz quizzSerializer(rawQuizz) {
  Calendar calendar = calendarMaker(rawQuizz["calendar"]);
  String classId = rawQuizz["classId"];
  int numberOfQuestions = rawQuizz["numberOfQuestions"];
  String image = rawQuizz["image"];
  String quizzId = rawQuizz["quizzId"];
  String quizzName = rawQuizz["quizzName"];
  String userNotificationTokenId = rawQuizz["userNotificationTokenId"];
  DateTime lastStudyDay =
      studyDayMaker(rawQuizz["lastStudyDay"]) ?? DateTime.now();
  DateTime nextStudyDay = studyDayMaker(rawQuizz["nextStudyDay"]);
  List<DateTime> studySessions = studySessionsMaker(rawQuizz["studySessions"]);
  Quizz quizz = Quizz(
    lastStudyDay: lastStudyDay,
    nextStudyDay: nextStudyDay,
    studySessions: studySessions,
    calendar: calendar,
    classId: classId,
    numberOfQuestions: numberOfQuestions,
    quizzId: quizzId,
    quizzName: quizzName,
    userNotificationTokenId: userNotificationTokenId,
    image: image,
  );
  return quizz;
}
