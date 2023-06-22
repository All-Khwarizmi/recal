import 'package:firebase_auth/firebase_auth.dart';
import 'package:recal_mobile2/domain/user/user.dart';
import 'package:recal_mobile2/domain/core/value_objects.dart';

extension FirebaseUserMapper on User {
  UserEntity toDomain() {
    return UserEntity(
        id: UniqueId.fromUniqueString(uid), lastConnection: DateTime.now());
  }
}
