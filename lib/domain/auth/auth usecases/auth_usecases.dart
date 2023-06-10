// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:recal_mobile2/domain/auth/repositories/auth_repositories.dart';

import '../../../core/error/failure.dart';
import '../../quizz/entities/user.dart';

class SignUserAnonymously {
  final AuthRepository repository;
  final String classId;
  final String userName;

  SignUserAnonymously(
    this.repository,
    this.classId,
    this.userName,
  );

  Future<void> call() async {
    return repository.signUserAnonymously(classId: classId, userName: userName);
  }
}

class GetUserNotificationToken {
  final AuthRepository repository;

  GetUserNotificationToken(this.repository);

  Future<Either<Failure, String>>  call() async {
    return repository.getUserNotificationToken();
  }
}

class AddUser {
  final AuthRepository repository;
  final UserEntity user;
  AddUser({
    required this.repository,
    required this.user,
  });

  Future<void> call() async {
    return repository.addUser(user);
  }
}
