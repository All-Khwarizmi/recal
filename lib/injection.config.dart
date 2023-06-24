// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:firebase_messaging/firebase_messaging.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;
import 'package:recal_mobile2/application/auth/authentication_bloc/authentication_bloc.dart'
    as _i15;
import 'package:recal_mobile2/application/auth/bloc/auth_bloc.dart' as _i17;
import 'package:recal_mobile2/application/auth/sign_in_form/sign_in_form_bloc.dart'
    as _i10;
import 'package:recal_mobile2/application/user/user_connection_bloc/user_connection_bloc.dart'
    as _i16;
import 'package:recal_mobile2/data/auth/repositories/auth_repositories_impl.dart'
    as _i14;
import 'package:recal_mobile2/domain/auth/i_auth_facade.dart' as _i8;
import 'package:recal_mobile2/domain/auth/repositories/auth_repositories.dart'
    as _i13;
import 'package:recal_mobile2/domain/user/user_repository.dart' as _i11;
import 'package:recal_mobile2/infrastructure/auth/firebase_auth_facade.dart'
    as _i9;
import 'package:recal_mobile2/infrastructure/core/firebase_injectable_module.dart'
    as _i6;
import 'package:recal_mobile2/infrastructure/user/user_repository_impl.dart'
    as _i12;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final firebaseInjectableModule = _$FirebaseInjectableModule();
    gh.lazySingleton<_i3.FirebaseAuth>(
        () => firebaseInjectableModule.firebaseAuth);
    gh.lazySingleton<_i4.FirebaseFirestore>(
        () => firebaseInjectableModule.store);
    gh.lazySingleton<_i5.FirebaseMessaging>(
        () => firebaseInjectableModule.messaging);
    await gh.factoryAsync<_i6.FirebaseService>(
      () => firebaseInjectableModule.firebaseService,
      preResolve: true,
    );
    gh.lazySingleton<_i7.GoogleSignIn>(
        () => firebaseInjectableModule.googleSignIn);
    gh.lazySingleton<_i8.IAuthFacade>(() => _i9.FirebaseAuthFacade(
          gh<_i3.FirebaseAuth>(),
          gh<_i7.GoogleSignIn>(),
          gh<_i5.FirebaseMessaging>(),
          gh<_i4.FirebaseFirestore>(),
        ));
    gh.factory<_i10.SignInFormBloc>(
        () => _i10.SignInFormBloc(gh<_i8.IAuthFacade>()));
    gh.lazySingleton<_i11.UserRepository>(() => _i12.UserRepositoryImpl(
          gh<_i4.FirebaseFirestore>(),
          gh<_i8.IAuthFacade>(),
        ));
    gh.factory<_i13.AuthRepository>(() => _i14.AuthRepositoryImpl(
          messaging: gh<_i5.FirebaseMessaging>(),
          firebaseAuth: gh<_i3.FirebaseAuth>(),
          firebaseFirestore: gh<_i4.FirebaseFirestore>(),
        ));
    gh.factory<_i15.AuthenticationBloc>(
        () => _i15.AuthenticationBloc(gh<_i8.IAuthFacade>()));
    gh.factory<_i16.UserConnectionBloc>(
        () => _i16.UserConnectionBloc(gh<_i11.UserRepository>()));
    gh.factory<_i17.AuthBloc>(
        () => _i17.AuthBloc(authRepository: gh<_i13.AuthRepository>()));
    return this;
  }
}

class _$FirebaseInjectableModule extends _i6.FirebaseInjectableModule {}
