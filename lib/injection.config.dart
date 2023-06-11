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
import 'package:injectable/injectable.dart' as _i2;

import 'core/app/firebase%20module/app_module.dart' as _i10;
import 'core/app/firebase%20module/firebase_service.dart' as _i6;
import 'data/auth/repositories/auth_repositories_impl.dart' as _i8;
import 'domain/auth/bloc/auth_bloc.dart' as _i9;
import 'domain/auth/repositories/auth_repositories.dart' as _i7;

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
    final appModule = _$AppModule();
    gh.factory<_i3.FirebaseAuth>(() => appModule.auth);
    gh.factory<_i4.FirebaseFirestore>(() => appModule.store);
    gh.factory<_i5.FirebaseMessaging>(() => appModule.messaging);
    await gh.factoryAsync<_i6.FirebaseService>(
      () => appModule.fireService,
      preResolve: true,
    );
    gh.factory<_i7.AuthRepository>(() => _i8.AuthRepositoryImpl(
          messaging: gh<_i5.FirebaseMessaging>(),
          firebaseAuth: gh<_i3.FirebaseAuth>(),
          firebaseFirestore: gh<_i4.FirebaseFirestore>(),
        ));
    gh.factory<_i9.AuthBloc>(
        () => _i9.AuthBloc(authRepository: gh<_i7.AuthRepository>()));
    return this;
  }
}

class _$AppModule extends _i10.AppModule {}
