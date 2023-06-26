import 'package:go_router/go_router.dart';
import 'package:recal_mobile2/presentation/auth/widgets/app_bar.dart';
import 'package:recal_mobile2/presentation/core/design/theme.dart';
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
