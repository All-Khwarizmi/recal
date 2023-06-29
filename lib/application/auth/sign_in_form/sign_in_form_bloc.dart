import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:recal_mobile2/domain/auth/auth_failures.dart';
import 'package:recal_mobile2/domain/auth/i_auth_facade.dart';
import '../../../domain/auth/value_objects.dart';
part 'sign_in_form_event.dart';
part 'sign_in_form_state.dart';
part 'sign_in_form_bloc.freezed.dart';

@injectable
class SignInFormBloc extends Bloc<SignInFormEvent, SignInFormState> {
  final IAuthFacade _authFacade;

  SignInFormBloc(this._authFacade) : super(SignInFormState.initial()) {
    on<SignInFormEvent>(
      (event, emit) async {
        Future<void> registerOrSignInHelper(Function func) async {
          Either<AuthFailure, Unit> failureOrSuccess;
          final isEmailValid = state.emailAddress.isValid();
          final passwordValid = state.password.isValid();
          if (isEmailValid && passwordValid) {
            emit(state.copyWith(
              authFailureOrSuccessOption: none(),
              isSubmitting: true,
            ));
            failureOrSuccess = await func(
                emailAddress: state.emailAddress, password: state.password);
            if (failureOrSuccess.isLeft()) {
              emit(state.copyWith(
                isSubmitting: false,
                showErrorMessages: true,
                authFailureOrSuccessOption: optionOf(failureOrSuccess),
              ));
            } else {
              emit(state.copyWith(
                isSubmitting: false,
                authFailureOrSuccessOption: some(failureOrSuccess),
              ));
              emit(SignInFormState.initial());
            }
          } else {
            failureOrSuccess =
                const Left(AuthFailure.invalidEmailAndPasswordCombination());
            emit(state.copyWith(
              isSubmitting: false,
              showErrorMessages: true,
              authFailureOrSuccessOption: optionOf(failureOrSuccess),
            ));
          }
        }

        await event.when(emailChanged: (String emailAddress) {
          emit(state.copyWith(
            emailAddress: EmailAddress(emailAddress),
            authFailureOrSuccessOption: none(),
          ));
        }, passwordChanged: (String password) {
          emit(state.copyWith(
            password: Password(password),
            authFailureOrSuccessOption: none(),
          ));
        }, registerWithEmailAndPasswordPressed: () async {
          await registerOrSignInHelper(
              _authFacade.registerWithEmailAndPassword);
        }, signInWithEmailAndPasswordPressed: () async {
          await registerOrSignInHelper(_authFacade.signInWithEmailAndPassword);
        }, signInWithGooglePressed: () async {
          emit(state.copyWith(
              authFailureOrSuccessOption: none(), isSubmitting: true));
          var failureOrSuccess = await _authFacade.signInWithGoogle();
          if (failureOrSuccess.isLeft() == true) {
            emit(state.copyWith(
              authFailureOrSuccessOption: some(failureOrSuccess),
              isSubmitting: false,
              showErrorMessages: true,
            ));
          } else {
            emit(state.copyWith(
              isSubmitting: false,
              showErrorMessages: false,
              authFailureOrSuccessOption: some(failureOrSuccess),
            ));
          }
        });
      },
    );
  }
}
