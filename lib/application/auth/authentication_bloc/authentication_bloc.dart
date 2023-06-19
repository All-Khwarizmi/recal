import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:recal_mobile2/Legacy/utils/logger.dart';

import '../../../domain/auth/i_auth_facade.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final IAuthFacade _authFacade;

  AuthenticationBloc(this._authFacade)
      : super(const AuthenticationState.initial()) {
    on<AuthenticationEvent>((event, emit) async {
      await event.when(
        authRequested: () async {
          final isUser = _authFacade.getSignedInUser();
          if (isUser.isLeft()) {
            log(location: "Authentication bloc", msg: 'Unauthenticated');
            emit(const AuthenticationState.unauthenticated());
          } else {
            log(location: "Authentication bloc", msg: 'Authenticated');

            emit(const AuthenticationState.authenticated());
          }
        },
        signOut: () async {
          await _authFacade.signOut();
          log(location: "Authentication bloc", msg: 'Unauthenticated');

          emit(const AuthenticationState.unauthenticated());
        },
      );
    });
  }
}
