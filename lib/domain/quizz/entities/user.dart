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
  List<Object> get props {
    return [
      userId,
      userName,
      classId,
      userNotificationTokenId,
      userScore,
      lastConnection,
      connectionStreak,
    ];
  }

  User copyWith({
    String? userId,
    String? userName,
    String? classId,
    String? userNotificationTokenId,
    int? userScore,
    DateTime? lastConnection,
    int? connectionStreak,
  }) {
    return User(
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      classId: classId ?? this.classId,
      userNotificationTokenId: userNotificationTokenId ?? this.userNotificationTokenId,
      userScore: userScore ?? this.userScore,
      lastConnection: lastConnection ?? this.lastConnection,
      connectionStreak: connectionStreak ?? this.connectionStreak,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'classId': classId,
      'userNotificationTokenId': userNotificationTokenId,
      'userScore': userScore,
      'lastConnection': lastConnection.millisecondsSinceEpoch,
      'connectionStreak': connectionStreak,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      classId: map['classId'] as String,
      userNotificationTokenId: map['userNotificationTokenId'] as String,
      userScore: map['userScore'] as int,
      lastConnection: DateTime.fromMillisecondsSinceEpoch(map['lastConnection'] as int),
      connectionStreak: map['connectionStreak'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
