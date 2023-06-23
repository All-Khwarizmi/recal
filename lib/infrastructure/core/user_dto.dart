import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:recal_mobile2/domain/core/value_objects.dart';
import 'package:recal_mobile2/domain/user/user.dart';
import 'package:recal_mobile2/domain/user/user_failures.dart';

class UserDTO {
  const UserDTO._({
    required String id,
    required lastConnection,
    String name = "",
    String notificationToken = "",
    String bio = "",
    List<String> topicsFollowed = const [""],
    List<String> topicsOwn = const [""],
    List<String> domains = const [""],
    int connectionStreak = 1,
    int score = 50,
  });

  static Map<String, dynamic> toFirestore(UserEntity user) {
    return {
      "id": user.id.value.fold(
        (f) => f.toString(),
        (r) => r,
      ),
      "lastConnection": Timestamp.fromDate(user.lastConnection),
      "bio": user.bio,
      "connectionStreak": user.connectionStreak,
      "domains": user.domains,
      "name": user.name,
      "notificationToken": user.notificationToken,
      "score": user.score,
      "topicsFollowed": user.topicsFollowed,
      "topicsOwn": user.topicsOwn,
    };
  }

  static Either<UserFailure, UserEntity> fromFirestore(DocumentSnapshot doc) {
    try {
      var data = doc.data()! as Map<String, dynamic>;
      final date = data['lastConnection'] as Timestamp;
      final user = UserEntity(
          id: UniqueId.fromUniqueString(data["id"]),
          lastConnection: date.toDate(),
          bio: data["bio"],
          connectionStreak: data["connectionStreak"],
          domains: listParser(data["domains"]),
          name: data["name"],
          notificationToken: data["notificationToken"],
          score: data["score"],
          topicsFollowed: listParser(data["topicsFollowed"]),
          topicsOwn: listParser(data["topicsOwn"]));

      return right(user);
    } catch (e) {
      return left(UserFailure.unexpectedError(e));
    }
  }

  static List<String> listParser(List<dynamic> list) {
    return list.map((e) {
      if (e == null) "";
      return e.toString();
    }).toList();
  }
}
