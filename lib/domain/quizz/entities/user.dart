// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
class User extends Equatable {
  final String id;
  final String firstName;
  final String lastName;
  final num score;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.score,
  });

  bool isValid() {
    return id.isNotEmpty &&
        firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        score >= 0;
  }

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    num? score,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      score: score ?? this.score,
    );
  }

  @override
  List<Object> get props => [id, firstName, lastName, score];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'score': score,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      score: map['score'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
