import 'package:flutter/material.dart';
import 'package:recal_mobile2/login/login_form.dart';
import 'package:recal_mobile2/shared/theme.dart';
import '../services/database/firestore.dart';
import '../shared/loading_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final recalTheme = RecalTheme();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirestoreService().getCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var list = snapshot.data!;
            list.map((e) => print(e.categoryName));

            return Scaffold(
              body: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Recal',
                      textAlign: TextAlign.center,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        color: recalTheme.primaryColor,
                        fontSize: 124,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.lineThrough,
                        decorationStyle: TextDecorationStyle.dashed,
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    LoginForm(
                      list: list,
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const LoadingScreen();
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