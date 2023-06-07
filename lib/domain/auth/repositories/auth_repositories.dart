import '../../quizz/entities/user.dart';

abstract class AuthRepository {
  Future<void> signUserAnonymously(User user);
  Future<String?> getUserNotificationToken();
  Future<void> addUser(User user);
}
