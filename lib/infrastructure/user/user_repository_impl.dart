import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:recal_mobile2/Legacy/utils/logger.dart';
import 'package:recal_mobile2/core/error/error.dart';
import 'package:recal_mobile2/domain/auth/auth_failures.dart';
import 'package:recal_mobile2/domain/user/user_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:recal_mobile2/domain/user/user_repository.dart';
import 'package:recal_mobile2/infrastructure/core/user_dto.dart';

import '../../domain/auth/i_auth_facade.dart';
import '../../domain/user/user.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final FirebaseFirestore _firebaseFirestore;
  final IAuthFacade _authFacade;

  UserRepositoryImpl(
    this._firebaseFirestore,
    this._authFacade,
  );

  @override
  Future<Either<UserFailure, int>> getUserConnectionStreak() {
    // Get user from auth
    final user = _authFacade.getSignedInUser();
    return user.fold(
      (failure) async =>
          left(const UserFailure.couldNotGetUserLastConnection()),
      (r) async {
        try {
          // Get doc reference
          final docRef = getDocReference(r);

          // Get data
          final data = await docRef.get();
          final UserEntity userEntity = UserDTO.fromFirestore(data).fold(
            (failure) {
              throw CustomError(failure.toString());
            },
            id,
          );

          // Return data
          return right(userEntity.connectionStreak);
        } catch (e) {
          return left(const UserFailure.couldNotGetUserLastConnection());
        }
      },
    );
  }

  @override
  Future<Either<UserFailure, int>> updateUserConnectionStreak() {
    // Get user from auth
    final user = _authFacade.getSignedInUser();
    return user.fold(
      (failure) async =>
          left(const UserFailure.couldNotGetUserLastConnection()),
      (r) async {
        try {
          // Get doc reference
          final docRef = getDocReference(r);

          // Get data
          final data = await docRef.get();
          final UserEntity userEntity = UserDTO.fromFirestore(data).fold(
            (failure) {
              throw CustomError(failure.toString());
            },
            id,
          );

          // Update user data
          await docRef.update({
            'connectionStreak': userEntity.connectionStreak + 1,
          });

          // Return data
          return right(userEntity.connectionStreak + 1);
        } catch (e) {
          return left(const UserFailure.couldNotGetUserLastConnection());
        }
      },
    );
  }

  @override
  Future<Either<UserFailure, DateTime>> getUserLastConnection() {
    // TODO: implement getUserLastConnection
    throw UnimplementedError();
  }

  @override
  Future<Either<UserFailure, int>> updateUserScore(int newScore) async {
    // Get user from auth
    final user = _authFacade.getSignedInUser();
    return user.fold(
      (failure) => left(const UserFailure.couldNotUpdateUserScore()),
      (r) async {
        try {
          // Get doc reference
          final docRef = getDocReference(r);

          // Get score
          final data = await docRef.get();
          final UserEntity userEntity = UserDTO.fromFirestore(data).fold(
            (failure) {
              throw CustomError(failure.toString());
            },
            id,
          );

          // Update user score
          await docRef.update({
            'score': userEntity.score + newScore,
          });

          // Get newScore
          return right(userEntity.score + newScore);
        } catch (e) {
          return left(const UserFailure.couldNotUpdateUserScore());
        }
      },
    );
  }

  @override
  Future<Either<AuthFailure, Unit>> updateUserLastConnection() {
    // TODO: implement updateUserLastConnection
    throw UnimplementedError();
  }

  @override
  Stream<Either<UserFailure, int>> userScoreStream() {
    // TODO: implement userScoreStream
    throw UnimplementedError();
  }

  DocumentReference<Map<String, dynamic>> getDocReference(UserEntity user) {
    return _firebaseFirestore.collection('users').doc(
          user.id.value.getOrElse(
            () => throw CustomError('Could not get user ID'),
          ),
        );
  }
}
