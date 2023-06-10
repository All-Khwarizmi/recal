import '../../quizz/entities/user.dart';

abstract class AuthRepository {
  Future<void> signUserAnonymously(
      {required String classId, required String userName});
  Future<String?> getUserNotificationToken();
  Future<void> addUser(User user);
  Future<User> getUser(String userId);
  Stream<User> userStream();
}
