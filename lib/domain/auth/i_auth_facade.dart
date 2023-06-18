import 'package:dartz/dartz.dart';
import 'package:recal_mobile2/domain/auth/auth%20usecases/auth_usecases.dart';
import 'package:recal_mobile2/domain/auth/auth_failures.dart';
import 'package:recal_mobile2/domain/auth/user.dart';

import './value_objects.dart';

abstract class IAuthFacade {
  Future<Either<Unit, String>> getUserNotificationToken();
  Either<Unit, UserEntity> getSignedInUser();
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  });
  Future<Either<AuthFailure, Unit>> signInWithGoogle();
  Future<void> signOut();
}
