import '../../models/fire_model.dart';

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
  var returnStudyDay = studyDay ?? DateTime.now();
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
  final Calendar calendar = calendarMaker(rawQuizz["calendar"]);
  final String classId = rawQuizz["classId"];
  final String image = rawQuizz["image"];
  final String quizzId = rawQuizz["quizzId"];
  final String quizzName = rawQuizz["quizzName"];
  final num previousEaseFactor = rawQuizz["previousEaseFactor"];
  final int repetitions = rawQuizz["repetitions"];
  final int numberOfQuestions = rawQuizz["numberOfQuestions"];
  final int previousInterval = rawQuizz["previousInterval"];
  final String userNotificationTokenId = rawQuizz["userNotificationTokenId"];
  final DateTime lastStudyDay = studyDayMaker(rawQuizz["lastStudyDay"]);
  final DateTime nextStudyDay = studyDayMaker(rawQuizz["nextStudyDay"]);
  final List<DateTime> studySessions =
      studySessionsMaker(rawQuizz["studySessions"]);
  final Quizz quizz = Quizz(
    lastStudyDay: lastStudyDay,
    nextStudyDay: nextStudyDay,
    studySessions: studySessions,
    repetitions: repetitions,
    previousInterval: previousInterval,
    previousEaseFactor: previousEaseFactor,
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
