import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:recal_mobile2/Legacy/utils/logger.dart';
import 'package:recal_mobile2/application/auth/authentication_bloc/authentication_bloc.dart';
import 'package:recal_mobile2/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:recal_mobile2/presentation/core/design/rec_barel.dart';
import 'package:recal_mobile2/presentation/core/design/theme.dart';
import 'package:recal_mobile2/presentation/core/design/widgets/rec_input_field.dart';

import '../../core/design/widgets/rec_button.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    const theming = RecalTheme();
    var authBloc = BlocProvider.of<SignInFormBloc>(context);

    var authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        log(location: "Sign In form", msg: 'State is $state');
        state.authFailureOrSuccessOption.fold(
          () => null,
          (either) => either.fold(
            (failure) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  closeIconColor: theming.primaryColor,
                  showCloseIcon: true,
                  content: Text(failure.map(
                    // TODO: modify to ask again
                    noNotificationToken: (_) =>
                        "Please accept recieving notifications",
                    cancelledByUser: (_) => "Cancelled",
                    serverError: (_) => "Server error",
                    emailAlreadyInUse: (_) => "Email already in use",
                    invalidEmailAndPasswordCombination: (_) =>
                        "Either email or password is wrong",
                  ))))
            },
            (_) => {
              log(location: "Sign In form", msg: 'Going home page'),
              authenticationBloc.add(const AuthenticationEvent.authRequested()),
              log(location: "Sign In form", msg: 'Auth requested'),
              context.go('/home'),
            },
          ),
        );
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 8,
              right: 8,
            ),
            child: ListView(
              children: [
                const SizedBox(height: 30),
                const Text(
                  "🔥",
                  style: TextStyle(
                    fontSize: 100,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                RecInputField(
                  placeholder: "Email",
                  leading: const Icon(
                    Icons.email,
                    color: kcPrimaryColor,
                  ),
                  onChanged: (value) => authBloc.add(
                    SignInFormEvent.emailChanged(value),
                  ),
                  validator: authBloc.state.emailAddress.value.fold(
                    (f) => f.maybeMap(
                      invalidEmail: (_) => () => 'Invalid Email',
                      orElse: () => null,
                    ),
                    (r) => null,
                  ),
                ),
                const SizedBox(height: 10),
                RecInputField(
                  placeholder: "Password",
                  password: true,
                  leading: const Icon(Icons.lock, color: kcPrimaryColor),
                  onChanged: (value) => authBloc.add(
                    SignInFormEvent.passwordChanged(value),
                  ),
                  validator: authBloc.state.password.value.fold(
                    (f) => f.maybeMap(
                      shortPassword: (_) => () => 'Invalid Password',
                      orElse: () => null,
                    ),
                    (r) => null,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => authBloc.add(const SignInFormEvent
                            .signInWithEmailAndPasswordPressed()),
                        child: const Text(
                          "SIGN IN",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(content: Text('failure.toString()')));
                          authBloc.add(
                            const SignInFormEvent
                                .registerWithEmailAndPasswordPressed(),
                          );
                        },
                        child: const Text(
                          "REGISTER",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  icon: const Icon(FontAwesomeIcons.google),
                  onPressed: () => authBloc
                      .add(const SignInFormEvent.signInWithGooglePressed()),
                  label: const Text('Continue with Google'),
                ),
                const SizedBox(height: 10),
                RecButton(
                  title: 'SIGN IN',
                  onTap: () => authBloc.add(const SignInFormEvent
                      .signInWithEmailAndPasswordPressed()),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
