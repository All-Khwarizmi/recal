import 'package:dartz/dartz.dart';
import 'package:recal_mobile2/domain/auth/auth_failures.dart';
import 'package:recal_mobile2/domain/user/user.dart';

import './value_objects.dart';

abstract class IAuthFacade {
  Future<Either<AuthFailure, String>> getUserNotificationToken();
  Either<AuthFailure, UserEntity> getSignedInUser();
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
