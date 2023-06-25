import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recal_mobile2/domain/auth/auth_failures.dart';
import 'package:recal_mobile2/infrastructure/auth/firebase_auth_facade.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockFirebaseAuth1 extends Mock implements FirebaseAuth {}

class MockUserCredential1 extends Mock implements UserCredential {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  late FirebaseAuthFacade sut;
  late FirebaseAuth _firebaseAuth;
  late FirebaseMessaging _firebaseMessaging;
  late String expectedToken;
  late FirebaseFirestore _firebaseFirestore;
  late GoogleSignIn _googleSignIn;
  late MockUser fakeUser;

  setUp(() {
    //* Setting up authentication
    fakeUser = MockUser(
      isAnonymous: true,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    _firebaseAuth = MockFirebaseAuth(mockUser: fakeUser);
    _googleSignIn = MockGoogleSignIn();

    //* Setting up DB
    _firebaseFirestore = MockFirebaseFirestore();

    //* Setting up messaging
    _firebaseMessaging = MockFirebaseMessaging();
    expectedToken = "DEVICE-TOKEN";

    //* Initializing system to be tested
    sut = FirebaseAuthFacade(
      _firebaseAuth,
      _googleSignIn,
      _firebaseMessaging,
      _firebaseFirestore,
    );
  });

//* Arranging methods
  void mockFirebaseMessagingGetTokenCall() {
    when(
      () => _firebaseMessaging.getToken(),
    ).thenAnswer((_) async => expectedToken);
  }

  group("getUserNotificationToken", () {
    test(
      "Should handle exeptions gracefully by mapping it to a Failure",
      () async {
        when(
          () => _firebaseMessaging.getToken(),
        ).thenAnswer((_) {
          throw Exception('No token');
        });
        Either<AuthFailure, String> result =
            await sut.getUserNotificationToken();
        expect(result.isLeft(), true);
      },
    );

    test(
      "Get token using FCM",
      () async {
        mockFirebaseMessagingGetTokenCall();
        await sut.getUserNotificationToken();

        verify(
          () => _firebaseMessaging.getToken(),
        ).called(1);
      },
    );

    test(
      "Return type should be of type string",
      () async {
        mockFirebaseMessagingGetTokenCall();
        Either<AuthFailure, String> result =
            await sut.getUserNotificationToken();
        result.fold((l) => null, (r) => expect(r.runtimeType, String));
      },
    );

    test(
      "Return value should be [DEVICE-ID]",
      () async {
        mockFirebaseMessagingGetTokenCall();
        Either<AuthFailure, String> result =
            await sut.getUserNotificationToken();
        result.fold(
          (l) => null,
          (r) => expect(r, expectedToken),
        );
      },
    );
  });
}
