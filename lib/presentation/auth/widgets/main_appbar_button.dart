import 'package:flutter/material.dart';
import 'package:recal_mobile2/application/auth/authentication_bloc/authentication_bloc.dart';

import 'package:recal_mobile2/domain/user/user_repository.dart';

import '../../../Legacy/utils/logger.dart';
import '../../../injection.dart';

class AppBarButton extends StatelessWidget {
  final Function() onPressedFunction;
  final IconData icon;
  const AppBarButton({
    Key? key,
    required this.onPressedFunction,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 3),
              blurRadius: 20,
              blurStyle: BlurStyle.inner,
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.5),
            ),
          ],
        ),
        child: CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 203, 76, 30),
          child: IconButton(
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            onPressed: onPressedFunction,
          ),
        ),
      ),
    );
  }
}

Future<void> updateScoreButtonMethod() async {
  await getIt<UserRepository>().updateUserScore(20);
}

Function() signOutButtonHolderMethod(
    AuthenticationBloc repo, BuildContext context) {
  return () => {
        repo.add(const AuthenticationEvent.signOut()),
        Logger.warning('SignOut')
      };
}
