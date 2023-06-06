import 'package:recal_mobile2/domain/auth/repositories/auth_repositories.dart';

class SignUserAnonymously {
  final AuthRepository repository;

  SignUserAnonymously(this.repository);

  Future<void> call() async {
    return repository.signUserAnonymously();
  }
}

class GetUserNotificationToken {
  final AuthRepository repository;

  GetUserNotificationToken(this.repository);

  Future<String?> call() async {
    return repository.getUserNotificationToken();
  }
}
