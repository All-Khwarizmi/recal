// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

import 'package:recal_mobile2/domain/auth/auth_failures.dart';
import 'package:recal_mobile2/domain/auth/i_auth_facade.dart';
import 'package:recal_mobile2/domain/core/value_objects.dart';
import 'package:recal_mobile2/domain/user/user.dart';
import 'package:recal_mobile2/domain/auth/value_objects.dart';
import 'package:recal_mobile2/domain/user/user_failures.dart';
import '../../core/error/error.dart';
import '../core/user_dto.dart';
import './firebase_user_mapper.dart';

@LazySingleton(as: IAuthFacade)
class FirebaseAuthFacade implements IAuthFacade {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FirebaseMessaging _firebaseMessaging;
  final FirebaseFirestore _firebaseFirestore;

  FirebaseAuthFacade(
    this._firebaseAuth,
    this._googleSignIn,
    this._firebaseMessaging,
    this._firebaseFirestore,
  );

  Future<Either<UserFailures, Unit>> addUserToFirestore(User user) async {
    // Get user notification token
    var token = await getUserNotificationToken();
    token.fold(
      (failure) => throw CustomError(failure.toString()),
      (r) => r,
    );

    try {
      // Get doc reference
      final CollectionReference<Map<String, dynamic>> usersCollection =
          _firebaseFirestore.collection("users");

      // Check if user already in DB
      final isUserInDB = await usersCollection.doc(user.uid).get();

      if (!isUserInDB.exists) {
        // Save user to firestore
        await usersCollection.doc(user.uid).set(
              UserDTO.toFirestore(
                UserEntity(
                  id: UniqueId.fromUniqueString(user.uid),
                  lastConnection: DateTime.now(),
                  notificationToken: token.getOrElse(
                    () => throw CustomError("No notification token"),
                  ),
                ),
              ),
            );
      }
      return right(unit);
    } catch (e) {
      return left(const UserFailures.couldNotAddUserToFirestore());
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      UserCredential userCredentail =
          await _firebaseAuth.createUserWithEmailAndPassword(
              email: emailAddressStr, password: passwordStr);

      // TODO: Add user to firestore
      if (userCredentail.user != null) {
        await addUserToFirestore(userCredentail.user!);
        return right(unit);
      } else {
        return left(const AuthFailure.serverError());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else if (e.code == 'email-already-in-use') {
        return left(const AuthFailure.emailAlreadyInUse());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword({
    required EmailAddress emailAddress,
    required Password password,
  }) async {
    final emailAddressStr = emailAddress.getOrCrash();
    final passwordStr = password.getOrCrash();
    try {
      UserCredential userCredentail =
          await _firebaseAuth.signInWithEmailAndPassword(
              email: emailAddressStr, password: passwordStr);

      userCredentail.user;
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email' ||
          e.code == 'user-disabled' ||
          e.code == 'wrong-password' ||
          e.code == 'user-not-found') {
        return left(const AuthFailure.invalidEmailAndPasswordCombination());
      } else {
        return left(const AuthFailure.serverError());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithGoogle() async {
    try {
      GoogleSignInAccount? signInAccount = await _googleSignIn.signIn();
      if (signInAccount == null) {
        return left(const AuthFailure.cancelledByUser());
      } else {
        final googleAuth = await signInAccount.authentication;
        final authCredential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        UserCredential userCredentail =
            await _firebaseAuth.signInWithCredential(authCredential);

        if (userCredentail.user != null) {
          await addUserToFirestore(userCredentail.user!);
          return right(unit);
        } else {
          return left(const AuthFailure.serverError());
        }
      }
    } on FirebaseAuthException catch (_) {
      // TODO : catch exceptions
      return left(const AuthFailure.serverError());
    }
  }

  @override
  Either<AuthFailure, UserEntity> getSignedInUser() {
    if (_firebaseAuth.currentUser != null) {
      return right(
        _firebaseAuth.currentUser!.toDomain(),
      );
    }
    // TODO: Modify failure
    return left(const AuthFailure.serverError());
  }

  @override
  Future<void> signOut() => Future.wait([
        _googleSignIn.signOut(),
        _firebaseAuth.signOut(),
      ]);

  @override
  Future<Either<AuthFailure, String>> getUserNotificationToken() async {
    final String? token = await _firebaseMessaging.getToken();
    if (token != null) {
      return right(token);
    } else {
      return left(const AuthFailure.noNotificationToken());
    }
  }
}
