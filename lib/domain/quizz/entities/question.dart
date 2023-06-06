import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Question extends Equatable {
  final String id;
  final String question;
  final String answer;

  Question({
    required this.id,
    required this.question,
    required this.answer,
  });

  
  @override
  List<Object> get props => [id, question, answer];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'question': question,
      'answer': answer,
    };
  }

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      id: map['id'] as String,
      question: map['question'] as String,
      answer: map['answer'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Question.fromJson(String source) =>
      Question.fromMap(json.decode(source) as Map<String, dynamic>);
}
