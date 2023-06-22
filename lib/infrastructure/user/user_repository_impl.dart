import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:recal_mobile2/core/error/error.dart';
import 'package:recal_mobile2/domain/auth/auth_failures.dart';
import 'package:recal_mobile2/domain/user/user_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:recal_mobile2/domain/user/user_repository.dart';

import '../../domain/auth/i_auth_facade.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl extends UserRepository {
  final FirebaseFirestore _firebaseFirestore;
  final IAuthFacade _authFacade;

  UserRepositoryImpl(
    this._firebaseFirestore,
    this._authFacade,
  );

  @override
  Future<Either<UserFailures, int>> getUserConnectionStreak() {
    // TODO: implement getUserConnectionStreak
    throw UnimplementedError();
  }

  @override
  Future<Either<UserFailures, DateTime>> getUserLastConnection() {
    // TODO: implement getUserLastConnection
    throw UnimplementedError();
  }

  @override
  Future<Either<UserFailures, int>> updateUserScore(int newScore) async {
    // Get user from auth
    final user = _authFacade.getSignedInUser();
    return user.fold(
      (failure) => left(const UserFailures.couldNotUpdateUserScore()),
      (r) async {
        try {
          // Get doc reference
          final docRef = _firebaseFirestore.collection('users').doc(
                r.id.value.getOrElse(
                  () => throw CustomError('Could not get user ID'),
                ),
              );

          // Get score
          final data = await docRef.get();
          int score = data.data()!["score"];

          // Update user score
          await docRef.update({
            'score': score + newScore,
          });

          // Get newScore
          return right(r.score + newScore);
        } catch (e) {
          return left(const UserFailures.couldNotUpdateUserScore());
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
  Stream<Either<UserFailures, int>> userScoreStream() {
    // TODO: implement userScoreStream
    throw UnimplementedError();
  }

}
