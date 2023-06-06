// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class User extends Equatable {
  final String userId;
  final String userName;
  final String classId;
  final String userNotificationTokenId;
  final int userScore;
  final DateTime lastConnection;
  final int connectionStreak;
  User({
    required this.userId,
    required this.userName,
    required this.classId,
    required this.userNotificationTokenId,
    required this.userScore,
    required this.lastConnection,
    required this.connectionStreak,
  });

  @override
  List<Object?> get props => [
        userId,
        userName,
        classId,
        userNotificationTokenId,
        userScore,
        lastConnection,
        connectionStreak
      ];
}
