abstract class AuthRepository {
  Future<void> signUserAnonymously();
  Future<String?> getUserNotificationToken();
}
