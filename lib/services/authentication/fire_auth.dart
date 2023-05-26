import 'package:firebase_auth/firebase_auth.dart';
import 'package:recal_mobile2/services/database/firestore.dart';

class AuthService {
  final userStram = FirebaseAuth.instance.authStateChanges();
  final user = FirebaseAuth.instance.currentUser;

  Future<void> anonymousLogin({required userName, required classId}) async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
      final newUser = FirebaseAuth.instance.currentUser;
      if (newUser != null) {
        await FirestoreService()
            .addUser(userName: userName, classId: classId, userId: newUser.uid);
      } else {
        print(user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      print('Error in anonymous login process $e');
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
