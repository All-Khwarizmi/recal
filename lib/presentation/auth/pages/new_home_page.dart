import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recal_mobile2/domain/auth/bloc/auth_bloc.dart';
import 'package:recal_mobile2/home/app_bar.dart';
import 'package:recal_mobile2/login/login_form.dart';
import 'package:recal_mobile2/models/fire_model.dart';
import 'package:recal_mobile2/shared/error_screen.dart';
import 'package:recal_mobile2/shared/loading_screen.dart';

import '../../../shared/theme.dart';

class NewHomeScreen extends StatelessWidget {
  const NewHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const recalTheme = RecalTheme();

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        print(state);
        if (state == UnAuthenticated()) {
          //! TODO : Implement
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
    );
  }
}
