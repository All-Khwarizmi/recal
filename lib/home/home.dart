import 'package:flutter/material.dart';
import 'package:recal_mobile2/home/app_bar.dart';
import 'package:recal_mobile2/login/login.dart';
import 'package:recal_mobile2/services/authentication/fire_auth.dart';
import '../shared/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const recalTheme = RecalTheme();
   

    return StreamBuilder(
      stream: AuthService().userStram,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingScreen();
        } else if (snapshot.hasError) {
          return Center(
            child: ErrorMessage(),
          );
        } else if (snapshot.hasData) {
          return HomeScaffold(
            recalTheme: recalTheme,
          );
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

class ErrorMessage extends StatelessWidget {
  const ErrorMessage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text("Error");
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("Loading...");
  }
}
