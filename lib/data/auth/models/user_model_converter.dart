import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recal_mobile2/domain/quizz/entities/user.dart';

class UserModelConverter {
  static Map<String, Object> toFirestore(UserEntity user) {
    return {
      "userId": user.classId,
      "userName": user.userName,
      "classId": user.classId,
      "userNotificationTokenId": user.userNotificationTokenId,
      "userScore": user.userScore,
      "lastConnection": Timestamp.fromDate(user.lastConnection),
      "connectionStreak": user.connectionStreak,
    };
  }

  static UserEntity fromFirestore(DocumentSnapshot<Map<String, dynamic>> user) {
    UserEntity returnUser = UserEntity(
        userId: user['userId'],
        userName: user['userName'],
        classId: user['classId'],
        userNotificationTokenId: user['userNotificationTokenId'],
        userScore: user['userScore'],
        lastConnection: user['lastConnection'],
        connectionStreak: user['connectionStreak']);
    return returnUser;
  }
}
