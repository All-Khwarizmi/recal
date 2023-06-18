import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recal_mobile2/presentation/auth/pages/new_home_page.dart';
import 'package:recal_mobile2/presentation/auth/widgets/app_bar.dart';
import 'package:recal_mobile2/presentation/shared/theme.dart';
import 'package:recal_mobile2/presentation/sign_in/sign_in_page.dart';

import '../../../presentation/splash_page/splash_page.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScaffold(
        recalTheme: RecalTheme(),
      ),
    ),
    GoRoute(
      path: '/signIn',
      builder: (context, state) => const SignInPage(),
    ),
  ],
);
