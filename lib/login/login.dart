import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recal_mobile2/login/login_button.dart';
import 'package:recal_mobile2/services/authentication/fire_auth.dart';

import 'package:recal_mobile2/shared/theme.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final recalTheme = RecalTheme();
  @override
  Widget build(BuildContext context) {
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
            Flexible(
              child: LoginButton(
                icon: FontAwesomeIcons.userNinja,
                text: 'Continue as Guest',
                loginMethod: AuthService().anonymousLogin,
                color: recalTheme.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
