import 'package:recal_mobile2/infrastructure/auth/firebase_user_mapper.dart';

import 'barrel.dart';

void main() {
  late FirebaseAuthFacade sut;
  late FirebaseAuth fakeFirebaseAuth;
  late FirebaseAuth mockFirebaseAuth;
  late FirebaseMessaging firebaseMessaging;
  late String expectedToken;
  late FirebaseFirestore firebaseFirestore;
  late GoogleSignIn googleSignIn;
  late MockUser fakeUser;
  late EmailAddress emailAddress;
  late Password password;
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late UserCredential fakeUserCredential;

  setUp(() {
    //* Setting up authentication
    fakeUser = MockUser(
      isAnonymous: true,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    fakeFirebaseAuth = MockFirebaseAuth(
      signedIn: false,
      mockUser: fakeUser,
    );
    mockFirebaseAuth = MockFirebaseAuth1();
    googleSignIn = MockGoogleSignIn1();
    fakeUserCredential = MockUserCredential(true);
    emailAddress = EmailAddress("test@gmail.com");
    password = Password("1234567");

    //* Setting up DB
    firebaseFirestore = MockFirebaseFirestore();
    fakeFirebaseFirestore = FakeFirebaseFirestore();

    //* Setting up messaging
    firebaseMessaging = MockFirebaseMessaging();
    expectedToken = "DEVICE-TOKEN";

    //* Initializing system to be tested
    sut = FirebaseAuthFacade(
      mockFirebaseAuth,
      googleSignIn,
      firebaseMessaging,
      firebaseFirestore,
    );
  });

//* Arranging methods
  void mockFirebaseMessagingGetTokenCall() {
    when(
      () => firebaseMessaging.getToken(),
    ).thenAnswer((_) async => expectedToken);
  }

  void arrangeRegisterWEmailPwd() {
    when(
      () => mockFirebaseAuth.createUserWithEmailAndPassword(
          email: emailAddress.getOrCrash(), password: password.getOrCrash()),
    ).thenAnswer((_) async => fakeUserCredential);
  }

  void arrangeCollectionRef() {
    when(() => firebaseFirestore.collection("users"))
        .thenReturn(fakeFirebaseFirestore.collection('users'));
  }

  group("getUserNotificationToken", () {
    test(
      "Should handle exeptions gracefully by mapping it to a Failure",
      () async {
        when(
          () => firebaseMessaging.getToken(),
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
          () => firebaseMessaging.getToken(),
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

    void arrangeRegisterWEmailPwdWException() {
      when(
        () => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: emailAddress.getOrCrash(), password: password.getOrCrash()),
      ).thenAnswer(
          (_) async => throw FirebaseAuthException(code: 'invalid-email'));
    }

    test(
      "Should call createUserWithEmailAndPassword from firebaseAuth ",
      () async {
        mockFirebaseMessagingGetTokenCall();
        arrangeRegisterWEmailPwd();

        await sut.registerWithEmailAndPassword(
            emailAddress: emailAddress, password: password);

        verify(
          () => mockFirebaseAuth.createUserWithEmailAndPassword(
              email: emailAddress.getOrCrash(),
              password: password.getOrCrash()),
        ).called(1);
      },
    );

    test(
      "Should handle FirebaseAuthException gracefully",
      () async {
        arrangeRegisterWEmailPwdWException();

        final result = await sut.registerWithEmailAndPassword(
            emailAddress: emailAddress, password: password);
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure.toString(),
              "AuthFailure.invalidEmailAndPasswordCombination()");
        }, (r) => null);
      },
    );

    test(
      "Should call addUserToFirestore method",
      () async {
        mockFirebaseMessagingGetTokenCall();
        arrangeCollectionRef();
        arrangeRegisterWEmailPwd();

        await sut.registerWithEmailAndPassword(
            emailAddress: emailAddress, password: password);

        final userFromFirestore = await firebaseFirestore
            .collection('users')
            .doc(fakeUserCredential.user!.uid)
            .get();

        verify(
          () => firebaseFirestore.collection("users"),
        ).called(2);
        expect(userFromFirestore.data()!["id"], fakeUserCredential.user!.uid);
      },
    );
  });

  group('addUserToFirestore', () {
    test(
      "Should call getUserNotificationToken method",
      () async {
        mockFirebaseMessagingGetTokenCall();
        arrangeCollectionRef();
        await fakeFirebaseAuth.signInAnonymously();
        var user = fakeFirebaseAuth.currentUser!;
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
        await fakeFirebaseAuth.signInAnonymously();
        var user = fakeFirebaseAuth.currentUser!;
        await sut.addUserToFirestore(user);
        verify(
          () => firebaseFirestore.collection('users'),
        ).called(1);
      },
    );
    test(
      "Should add user to DB",
      () async {
        //* Arranging tests
        mockFirebaseMessagingGetTokenCall();
        arrangeCollectionRef();
        await fakeFirebaseAuth.signInAnonymously();
        var user = fakeFirebaseAuth.currentUser!;

        //* Adding and getting use to/from DB
        await sut.addUserToFirestore(user);
        final userFromFirestore =
            await firebaseFirestore.collection('users').doc(fakeUser.uid).get();

        //* Setting comparison members
        final expectedUser = UserDTO.fromFirestore(userFromFirestore).getOrElse(
          () => throw Exception(),
        );
        final userEntity = UserEntity(
            id: UniqueId.fromUniqueString(user.uid),
            lastConnection: DateTime.now(),
            notificationToken: expectedToken);

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

  group("signInWithEmailAndPassword", () {
    //* Arranging methods
    void arrangeSignInWEmailPwd() {
      when(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: emailAddress.getOrCrash(), password: password.getOrCrash()),
      ).thenAnswer((invocation) async => fakeUserCredential);
    }

    void arrangeSignInWEmailPwdWException() {
      when(
        () => mockFirebaseAuth.signInWithEmailAndPassword(
            email: emailAddress.getOrCrash(), password: password.getOrCrash()),
      ).thenAnswer(
          (invocation) => throw FirebaseAuthException(code: 'user-disabled'));
    }

    test(
      "Should call _firebaseAuth.signInWithEmailAndPassword method",
      () async {
        arrangeSignInWEmailPwd();
        await sut.signInWithEmailAndPassword(
            emailAddress: emailAddress, password: password);

        verify(
          () => mockFirebaseAuth.signInWithEmailAndPassword(
              email: emailAddress.getOrCrash(),
              password: password.getOrCrash()),
        );
      },
    );

    test(
      "Should handle FirebaseAuthException gracefully",
      () async {
        arrangeSignInWEmailPwdWException();
        final result = await sut.signInWithEmailAndPassword(
            emailAddress: emailAddress, password: password);

        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure.toString(),
              "AuthFailure.invalidEmailAndPasswordCombination()");
        }, (r) => null);
      },
    );
  });

  group("signInWithGoogle", () {
    void arrangeSignInWCredential() {}

    void arrangeSignInWGoogleWException() {
      when(
        () => googleSignIn.signIn(),
      ).thenAnswer((invocation) async => null);
    }

    test(
      "Should handle FirebaseAuthException gracefully",
      () async {
        arrangeSignInWGoogleWException();
        final result = await sut.signInWithGoogle();

        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure.toString(), "AuthFailure.cancelledByUser()");
        }, (r) => null);
      },
    );
  });

  group("getSignedInUser", () {
    test(
      "Should get the current signed in user",
      () async {
        when(
          () => mockFirebaseAuth.currentUser,
        ).thenReturn(fakeUser);
        final result = sut.getSignedInUser();

        verify(
          () => mockFirebaseAuth.currentUser,
        ).called(1);

        result.fold((failure) {}, (r) {
          expect(r.bio, fakeUser.toDomain().bio);
          expect(r.notificationToken, fakeUser.toDomain().notificationToken);
          expect(r.id, fakeUser.toDomain().id);
        });
      },
    );
  });
}

class MockOAuthCredential extends Mock implements OAuthCredential {}

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockFirebaseAuth1 extends Mock implements FirebaseAuth {}

class MockUserCredential1 extends Mock implements UserCredential {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockGoogleSignIn1 extends Mock implements GoogleSignIn {}

class MockUserCredential implements UserCredential {
  final MockUser _mockUser;

  MockUserCredential(bool isAnonymous, {MockUser? mockUser})
      // Ensure no mocked credentials or mocked for Anonymous
      : assert(mockUser == null || mockUser.isAnonymous == isAnonymous),
        _mockUser = mockUser ?? MockUser(isAnonymous: isAnonymous);

  @override
  User get user => mockUser;

  // Strongly typed for use within the project.
  MockUser get mockUser => _mockUser;

  @override
  // TODO: implement additionalUserInfo
  AdditionalUserInfo? get additionalUserInfo => throw UnimplementedError();

  @override
  // TODO: implement credential
  AuthCredential? get credential => throw UnimplementedError();
}

class MockGoogleAuthProvider extends Mock implements GoogleAuthProvider {}
