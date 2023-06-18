// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:recal_mobile2/domain/core/value_objects.dart';

class UserEntity extends Equatable {
  final UniqueId id;
  final String name;
  final String notificationToken;
  final String bio;
  final List<String> topicsFollowed;
  final List<String> topicsOwn;
  final List<String> domains;
  final int connectionStreak;
  final int score;
  final DateTime lastConnection;

  const UserEntity({
    required this.id,
    this.name = "",
    this.notificationToken = "",
    this.bio = "",
    this.topicsFollowed = const [""],
    this.topicsOwn = const [""],
    this.domains = const [""],
    this.connectionStreak = 1,
    this.score = 50,
    required this.lastConnection,
  });

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      name,
      notificationToken,
      bio,
      topicsFollowed,
      topicsOwn,
      domains,
      connectionStreak,
      score,
      lastConnection,
    ];
  }
}
