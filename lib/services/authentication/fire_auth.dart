import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

/* Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
} */
class MyCustomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          if (!state.user!.emailVerified) {
            Navigator.pushNamed(context, '/verify-email');
          } else {
            Navigator.pushReplacementNamed(context, '/profile');
          }
        }),
      ],
    );
  }
}

class MyLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext) {
    return Scaffold(
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: FirebaseUIActions(
              actions: [
                AuthStateChangeAction<SignedIn>((context, state) {
                  if (!state.user!.emailVerified) {
                    Navigator.pushNamed(context, '/verify-email');
                  } else {
                    Navigator.pushReplacementNamed(context, '/profile');
                  }
                }),
              ],
              child: LoginView(
                action: AuthAction.signUp,
                providers: FirebaseUIAuth.providersFor(
                  FirebaseAuth.instance.app,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

