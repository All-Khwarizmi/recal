import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recal_mobile2/domain/quizz/entities/user.dart';

class UserModelConverter {
  static Map<String, Object> toFirestore(UserEntity user) {
    return {
      "userId": user.userId,
      "userName": user.userName,
      "classId": user.classId,
      "userNotificationTokenId": user.userNotificationTokenId,
      "userScore": user.userScore,
      "lastConnection": Timestamp.fromDate(user.lastConnection),
      "connectionStreak": user.connectionStreak,
    };
  }

  static UserEntity fromFirestore(user) {
    
    var lcCasting = user['lastConnection'] as Timestamp;
    var lcCastingDate = lcCasting.toDate();

    UserEntity returnUser = UserEntity(
        userId: user['userId'],
        userName: user['userName'],
        classId: user['classId'],
        userNotificationTokenId: user['userNotificationTokenId'],
        userScore: user['userScore'],
        lastConnection: lcCastingDate,
        connectionStreak: user['connectionStreak']);
    return returnUser;
  }
}
