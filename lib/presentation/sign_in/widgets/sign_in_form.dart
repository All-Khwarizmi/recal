import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:recal_mobile2/application/auth/bloc/auth_bloc.dart';
import 'package:recal_mobile2/application/auth/sign_in_form/sign_in_form_bloc.dart';
import 'package:recal_mobile2/presentation/shared/theme.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final theming = RecalTheme();
    var authBloc = BlocProvider.of<SignInFormBloc>(context);
    return BlocConsumer<SignInFormBloc, SignInFormState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
          () => null,
          (either) => either.fold(
            (failure) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(failure.map(
                cancelledByUser: (_) => "Cancelled",
                serverError: (_) => "Server error",
                emailAlreadyInUse: (_) => "Email already in use",
                invalidEmailAndPasswordCombination: (_) =>
                    "Either email or password is wrong",
              ))))
            },
            (_) => {
              //! TODO: navigate to another page
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
                const Text(
                  "🔥",
                  style: TextStyle(
                    fontSize: 100,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.email,
                      color: theming.primaryColor,
                    ),
                    labelText: "Email",
                    labelStyle: const TextStyle(color: Colors.white),
                  ),
                  autocorrect: false,
                  onChanged: (value) => authBloc.add(
                    SignInFormEvent.emailChanged(value),
                  ),
                  validator: (_) => authBloc.state.emailAddress.value.fold(
                    (f) => f.maybeMap(
                      invalidEmail: (_) => 'Invalid Email',
                      orElse: () => null,
                    ),
                    (r) => null,
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock,
                      color: theming.primaryColor,
                    ),
                    labelText: "Password",
                    labelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  autocorrect: false,
                  obscureText: true,
                  onChanged: (value) => authBloc.add(
                    SignInFormEvent.passwordChanged(value),
                  ),
                  validator: (_) => authBloc.state.password.value.fold(
                    (f) => f.maybeMap(
                      shortPassword: (_) => 'Invalid Password',
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
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
