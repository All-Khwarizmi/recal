import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recal_mobile2/core/error/error.dart';
import 'package:recal_mobile2/domain/auth/auth_failures.dart';
import 'package:recal_mobile2/domain/auth/value_objects.dart';
import 'package:recal_mobile2/domain/core/value_objects.dart';
import 'package:recal_mobile2/domain/user/user.dart';
import 'package:recal_mobile2/infrastructure/auth/firebase_auth_facade.dart';
import 'package:recal_mobile2/infrastructure/core/user_dto.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockFirebaseAuth1 extends Mock implements FirebaseAuth {}

class MockUserCredential1 extends Mock implements UserCredential {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  late FirebaseAuthFacade sut;
  late FirebaseAuth _fakeFirebaseAuth;
  late FirebaseAuth _mockFirebaseAuth;
  late FirebaseMessaging _firebaseMessaging;
  late String expectedToken;
  late FirebaseFirestore _firebaseFirestore;
  late GoogleSignIn _googleSignIn;
  late MockUser fakeUser;
  late MockUserCredential1 _mockUserCredential;
  late EmailAddress _emailAddress;
  late Password _password;
  late FakeFirebaseFirestore fakeFirebaseFirestore;

  setUp(() {
    //* Setting up authentication
    fakeUser = MockUser(
      isAnonymous: true,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    _fakeFirebaseAuth = MockFirebaseAuth(mockUser: fakeUser);
    _mockFirebaseAuth = MockFirebaseAuth1();
    _googleSignIn = MockGoogleSignIn();
    _mockUserCredential = MockUserCredential1();
    _emailAddress = EmailAddress("test@gmail.com");
    _password = Password("1234567");

    //* Setting up DB
    _firebaseFirestore = MockFirebaseFirestore();
    fakeFirebaseFirestore = FakeFirebaseFirestore();

    //* Setting up messaging
    _firebaseMessaging = MockFirebaseMessaging();
    expectedToken = "DEVICE-TOKEN";

    //* Initializing system to be tested
    sut = FirebaseAuthFacade(
      _mockFirebaseAuth,
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

  void arrangeCollectionRef() {
    when(() => _firebaseFirestore.collection("users"))
        .thenReturn(fakeFirebaseFirestore.collection('users'));
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

  group("registerWithEmailAndPassword", () {
    //* Arranging tests
    void arrangeRegisterWEmailPwd() {
      when(
        () => _mockFirebaseAuth.createUserWithEmailAndPassword(
            email: _emailAddress.getOrCrash(),
            password: _password.getOrCrash()),
      ).thenAnswer((_) async => _mockUserCredential);
    }

    void arrangeRegisterWEmailPwdWException() {
      when(
        () => _mockFirebaseAuth.createUserWithEmailAndPassword(
            email: _emailAddress.getOrCrash(),
            password: _password.getOrCrash()),
      ).thenAnswer(
          (_) async => throw FirebaseAuthException(code: 'invalid-email'));
    }

    test(
      "Should call createUserWithEmailAndPassword from firebaseAuth ",
      () async {
        mockFirebaseMessagingGetTokenCall();

        arrangeRegisterWEmailPwd();
        await sut.registerWithEmailAndPassword(
            emailAddress: _emailAddress, password: _password);

        verify(
          () => _mockFirebaseAuth.createUserWithEmailAndPassword(
              email: _emailAddress.getOrCrash(),
              password: _password.getOrCrash()),
        ).called(1);
      },
    );

    test(
      "Should handle FirebaseAuthException gracefully",
      () async {
        arrangeRegisterWEmailPwdWException();

        final result = await sut.registerWithEmailAndPassword(
            emailAddress: _emailAddress, password: _password);
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure.toString(),
              "AuthFailure.invalidEmailAndPasswordCombination()");
        }, (r) => null);
      },
    );
    // TODO: implement
    //* arrange token - collection reference
    test(
      "Should call addUserToFirestore method",
      () async {},
    );
  });

// TODO: implement
  group('addUserToFirestore', () {
    Map<String, dynamic> getUserToFirestore(User user) {
      return UserDTO.toFirestore(
        UserEntity(
          id: UniqueId.fromUniqueString(user.uid),
          lastConnection: DateTime.now(),
          notificationToken: expectedToken,
        ),
      );
    }

    test(
      "Should call getUserNotificationToken method",
      () async {
        mockFirebaseMessagingGetTokenCall();
        arrangeCollectionRef();
        await _fakeFirebaseAuth.signInAnonymously();
        var user = _fakeFirebaseAuth.currentUser!;
        print(user);
        await sut.addUserToFirestore(user);
        verify(
          () => sut.getUserNotificationToken(),
        ).called(1);
      },
    );
    test(
      "Should call firebaseFirestore.collection",
      () async {
        mockFirebaseMessagingGetTokenCall();
        arrangeCollectionRef();
        await _fakeFirebaseAuth.signInAnonymously();
        var user = _fakeFirebaseAuth.currentUser!;
        print(user);
        await sut.addUserToFirestore(user);
        verify(
          () => _firebaseFirestore.collection('users'),
        ).called(1);
      },
    );
    test(
      "Should add user to DB",
      () async {
        //* Arranging tests
        mockFirebaseMessagingGetTokenCall();
        arrangeCollectionRef();
        await _fakeFirebaseAuth.signInAnonymously();
        var user = _fakeFirebaseAuth.currentUser!;

        //* Adding and getting use to/from DB
        await sut.addUserToFirestore(user);
        final userFromFirestore = await _firebaseFirestore
            .collection('users')
            .doc(fakeUser.uid)
            .get();

        //* Setting comparison members
        final expectedUser = UserDTO.fromFirestore(userFromFirestore).getOrElse(
          () => throw Exception(),
        );
        final userEntity = UserEntity(
            id: UniqueId.fromUniqueString(user.uid),
            lastConnection: DateTime.now(),
            notificationToken: expectedToken);
        print(userFromFirestore.data());

        //* Testing some fields since comparing entities does not work because of nanoseconds difference in lastConnection field
        expect(UserDTO.toMap(userEntity)['connectionStreak'],
            UserDTO.toMap(expectedUser)['connectionStreak']);
        expect(UserDTO.toMap(userEntity)['domains'],
            UserDTO.toMap(expectedUser)['domains']);
        expect(UserDTO.toMap(userEntity)['notificationToken'],
            UserDTO.toMap(expectedUser)['notificationToken']);
      },
    );
  });
}
