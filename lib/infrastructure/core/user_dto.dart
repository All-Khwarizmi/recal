import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
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

  factory UserDTO.toFirestore(UserEntity user) {
    return UserDTO._(
      id: user.id.value.fold(
        (f) => f.toString(),
        (r) => r,
      ),
      lastConnection: Timestamp.fromDate(user.lastConnection),
      bio: user.bio,
      connectionStreak: user.connectionStreak,
      domains: user.domains,
      name: user.name,
      notificationToken: user.notificationToken,
      score: user.score,
      topicsFollowed: user.topicsFollowed,
      topicsOwn: user.topicsOwn,
    );
  }

  Either<UserFailures, UserEntity> fromFirestore(DocumentSnapshot doc) {
    if (doc.data() != null) {
      var data = doc.data()! as Map<String, dynamic>;
      return right(UserEntity(
        id: data["id"],
        lastConnection: doc['lastConnection'].toDate(),
        bio: doc["bio"],
        connectionStreak: doc["connectionStreak"],
        domains: doc["domains"],
        name: doc["name"],
        notificationToken: doc["notificationToken"],
        score: doc["score"],
        topicsFollowed: doc["topicsFollowed"],
        topicsOwn: doc["topicsOwn"],
      ));
    } else {
      return left(const UserFailures.noUserData());
    }
  }
}
