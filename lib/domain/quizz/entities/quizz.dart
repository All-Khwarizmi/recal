// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'question.dart';

@immutable
class Quizz extends Equatable {
  final String id;
  final List<Question> questions;

  Quizz({
    required this.id,
    required this.questions,
  });

  bool isValid() {
    return id.isNotEmpty;
  }

  Quizz copyWith({
    String? id,
    List<Question>? questions,
  }) {
    return Quizz(
      id: id ?? this.id,
      questions: questions ?? this.questions,
    );
  }

  @override
  List<Object> get props => [id, questions];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'questions': questions.map((x) => x.toMap()).toList(),
    };
  }

  factory Quizz.fromMap(Map<String, dynamic> map) {
    return Quizz(
      id: map['id'] as String,
      questions: List<Question>.from(
        (map['questions'] as List<int>).map<Question>(
          (x) => Question.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Quizz.fromJson(String source) =>
      Quizz.fromMap(json.decode(source) as Map<String, dynamic>);
}
