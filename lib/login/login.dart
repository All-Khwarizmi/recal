import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recal_mobile2/login/login_button.dart';
import 'package:recal_mobile2/login/login_form.dart';
import 'package:recal_mobile2/services/authentication/fire_auth.dart';

import 'package:recal_mobile2/shared/theme.dart';

import '../services/database/firestore.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final recalTheme = RecalTheme();
  @override
  Widget build(BuildContext context)  {
    return FutureBuilder(
        future: FirestoreService().getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var list = snapshot.data!;
            list.map((e) => print(e.categoryName));

            return Scaffold(
              body: Container(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const FlutterLogo(
                      size: 150,
                    ),
                    LoginForm(
                      list: list,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Text('No topics found in Firestore. Check database');
          }
        });
  }
}

/* FutureBuilder(
      future: FirestoreService().getCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var list = snapshot.data;
          
          
          Scaffold(
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            LoginForm(),
            
          ],
        ),
      ),
    );

         } } else {
          return const Text('No topics found in Firestore. Check database');
        }
         
          */