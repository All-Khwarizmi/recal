import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recal_mobile2/domain/auth/bloc/auth_bloc.dart';
import 'package:recal_mobile2/home/app_bar.dart';
import 'package:recal_mobile2/login/login_form.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/shared/error_screen.dart';
import 'package:recal_mobile2/shared/loading_screen.dart';

import '../../../injection.dart';
import '../../../shared/theme.dart';

class NewHomeScreen extends StatelessWidget {
  const NewHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const recalTheme = RecalTheme();

    return BlocListener<AuthBloc, AuthState>(
      bloc: getIt<AuthBloc>(),
      listener: (context, state) {
        // TODO: implement listener
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state == UnAuthenticated()) {
            List<Category> list = [
              Category(categoryId: "1234", categoryName: '502'),
              Category(categoryId: "412345", categoryName: '404'),
            ];
            return LoginForm(list: list);
          } else if (state == Loading()) {
            return LoadingScreen();
          } else if (state == Authenticated()) {
            return HomeScaffold(recalTheme: recalTheme);
          } else {
            return ErrorScreen();
          }
        },
      ),
    );
  }
}

class NewLoginScreen extends StatelessWidget {
  const NewLoginScreen({
    super.key,
    required this.recalTheme,
  });

  final RecalTheme recalTheme;

  @override
  Widget build(BuildContext context) {
    List<Category> list = [
      Category(categoryId: "1234", categoryName: '502'),
      Category(categoryId: "412345", categoryName: '404'),
    ];

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
            LoginForm(list: list),
          ],
        ),
      ),
    );
  }
}
