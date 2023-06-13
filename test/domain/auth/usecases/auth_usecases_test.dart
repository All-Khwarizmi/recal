import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recal_mobile2/core/error/failure.dart';
import 'package:recal_mobile2/data/auth/models/user_model_converter.dart';
import 'package:recal_mobile2/data/auth/repositories/auth_repositories_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recal_mobile2/domain/quizz/entities/user.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockFirebaseAuth1 extends Mock implements FirebaseAuth {}

class MockUserCredential1 extends Mock implements UserCredential {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() async {
  late MockFirebaseMessaging mockFirebaseMessaging;
  late MockUserCredential1 mockUserCredential;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late MockFirebaseAuth1 mockFirebaseAuth;
  late MockFirebaseAuth fakeMockFirebaseAuth;
  late String expectedToken;
  late AuthRepositoryImpl sut;
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late UserEntity user;
  late MockUser fakeUser;
  late Map<String, Object> mockUserFromFirestore;

  setUp(() {
    expectedToken = "DEVICE-TOKEN";
    mockFirebaseMessaging = MockFirebaseMessaging();
    mockFirebaseAuth = MockFirebaseAuth1();
    // Setting up fake user

    fakeUser = MockUser(
      isAnonymous: true,
      uid: 'someuid',
      email: 'bob@somedomain.com',
      displayName: 'Bob',
    );
    fakeMockFirebaseAuth = MockFirebaseAuth(mockUser: fakeUser);
    mockUserCredential = MockUserCredential1();
    mockFirebaseFirestore = MockFirebaseFirestore();
    fakeFirebaseFirestore = FakeFirebaseFirestore();

    user = UserEntity(
        userId: "12345",
        userName: "Mike",
        classId: "502",
        userNotificationTokenId: "userNotificationTokenId",
        userScore: 50,
        lastConnection: DateTime.now(),
        connectionStreak: 5);

    mockUserFromFirestore = <String, Object>{
      "userId": user.userId,
      "userName": user.userName,
      "classId": user.classId,
      "userNotificationTokenId": user.userNotificationTokenId,
      "userScore": user.userScore,
      "lastConnection": Timestamp.fromDate(user.lastConnection),
      "connectionStreak": user.connectionStreak
    };
    sut = AuthRepositoryImpl(
      messaging: mockFirebaseMessaging,
      firebaseAuth: fakeMockFirebaseAuth,
      firebaseFirestore: mockFirebaseFirestore,
    );
  });
  void arrangeCollectionRef() {
    when(() => mockFirebaseFirestore.collection("users"))
        .thenReturn(fakeFirebaseFirestore.collection('users'));
  }

  void arrangeUserCredential() {
    when(
      () => mockFirebaseAuth.signInAnonymously(),
    ).thenAnswer((_) async => mockUserCredential);
  }

  void mockFirebaseMessagingGetTokenCall() {
    when(
      () => mockFirebaseMessaging.getToken(),
    ).thenAnswer((_) async => expectedToken);
  }

  group("getUserNotificationToken", () {
    test(
      "Should handle exeptions gracefully by mapping it to a Failure",
      () async {
        when(
          () => mockFirebaseMessaging.getToken(),
        ).thenAnswer((_) {
          throw Exception('No token');
        });
        Either<Failure, String> result = await sut.getUserNotificationToken();
        expect(result.isLeft(), true);
      },
    );
    test(
      "Get token using FCM",
      () async {
        mockFirebaseMessagingGetTokenCall();
        await sut.getUserNotificationToken();

        verify(
          () => mockFirebaseMessaging.getToken(),
        ).called(1);
      },
    );
    test(
      "Return type should be of type string",
      () async {
        mockFirebaseMessagingGetTokenCall();
        Either<Failure, String> result = await sut.getUserNotificationToken();
        result.fold((l) => null, (r) => expect(r.runtimeType, String));
      },
    );
    test(
      "Return value should be [DEVICE-ID]",
      () async {
        mockFirebaseMessagingGetTokenCall();
        Either<Failure, String> result = await sut.getUserNotificationToken();
        result.fold(
          (l) => null,
          (r) => expect(r, expectedToken),
        );
      },
    );
  });

  group("signUserAnonymously", () {
    test(
      "Should call getToken",
      () async {
        arrangeUserCredential();
        arrangeCollectionRef();
        mockFirebaseMessagingGetTokenCall();

        await sut.signUserAnonymously(classId: "502", userName: "Bob");
        verify(
          () => mockFirebaseMessaging.getToken(),
        ).called(1);
      },
    );
    test(
      "Should call addUser ",
      () async {
        arrangeUserCredential();
        arrangeCollectionRef();
        mockFirebaseMessagingGetTokenCall();

        await sut.signUserAnonymously(classId: "502", userName: "Bob");
        verify(
          () => mockFirebaseFirestore
              .collection('users')
              .doc(user.userNotificationTokenId)
              .set(user.toMap()),
        ).called(2); //! Call to check if user in DB and to create/update user
      },
    );
  });
  group('addUser', () {
    test(
      "Should call firestore instance to get doc reference",
      () async {
        arrangeCollectionRef();
        await sut.addUser(UserModelConverter.toFirestore(user));
        verify(
          () => mockFirebaseFirestore.collection("users"),
        ).called(1);
      },
    );
    test(
      "Should add user to database",
      () async {
        var userToken = user.userNotificationTokenId;
        arrangeCollectionRef();
        await sut.addUser(UserModelConverter.toFirestore(user));
        verify(
          () => mockFirebaseFirestore
              .collection('users')
              .doc(userToken)
              .set(user.toMap()),
        ).called(1);
      },
    );
  });
  group("getUser", () {
    Future<Map<String, dynamic>> arrangeFakeDocInDB() async {
      const String userId = "DEVICE-TOKEN";
      final instance = FakeFirebaseFirestore();
      final ref = instance.collection('users');
      await ref.doc(userId).set(UserModelConverter.toFirestore(user));
      var newUser = await instance.collection('users').doc(userId).get();

      Map<String, dynamic> returnMap = {
        'userId': userId,
        'ref': ref,
        'newUser': newUser
      };
      return returnMap;
    }

    test(
      "Shoul handle FirebaseExeption gracefully and display a Failure",
      () async {
        final Map data = await arrangeFakeDocInDB();

        when(
          () => mockFirebaseFirestore.collection('users'),
        ).thenAnswer(
          (_) => throw FirebaseException(message: "No user", plugin: ''),
        );
        Either<Failure, UserEntity> result = await sut.getUser(data['userId']);
        verify(
          () => mockFirebaseFirestore
              .collection('users')
              .doc(data['userId'])
              .get(),
        ).called(1);
        expect(result.isLeft(), true);
      },
    );
    test(
      "Should call DB get user from DB",
      () async {
        final Map data = await arrangeFakeDocInDB();

        when(
          () => mockFirebaseFirestore.collection('users'),
        ).thenAnswer(
          (invocation) => data['ref'],
        );
        Either<Failure, UserEntity> result = await sut.getUser(data['userId']);
        verify(
          () => mockFirebaseFirestore
              .collection('users')
              .doc(data['userId'])
              .get(),
        ).called(1);

        expect(result.isLeft(), false);
        result.fold((l) => null, (r) => expect(r.toMap(), user.toMap()));
      },
    );

    test(
      "Should return UserEntity",
      () async {
        final Map data = await arrangeFakeDocInDB();

        when(
          () => mockFirebaseFirestore.collection('users'),
        ).thenAnswer(
          (invocation) => data['ref'],
        );

        Either<Failure, UserEntity> result = await sut.getUser(data['userId']);

        verify(
          () => mockFirebaseFirestore
              .collection('users')
              .doc(data['userId'])
              .get(),
        ).called(1);

        expect(result.isLeft(), false);
        result.fold((l) => null, (r) => expect(r.toMap(), user.toMap()));
      },
    );
  });
  group('userStream', () {
    test(
      "Should return null when no user is logged in",
      () async {
        arrangeUserCredential();
        arrangeCollectionRef();
        mockFirebaseMessagingGetTokenCall();

        expect(fakeMockFirebaseAuth.currentUser, null);
      },
    );
    test(
      "Should notify that an user logged in",
      () async {
        arrangeUserCredential();
        arrangeCollectionRef();
        mockFirebaseMessagingGetTokenCall();

        await sut.signUserAnonymously(classId: 'classId', userName: 'userName');
        expect(fakeMockFirebaseAuth.currentUser, fakeUser);
      },
    );
  });

  group("signOutRequested", () {
    test(
      "Should sign out the current user",
      () async {
        arrangeUserCredential();
        arrangeCollectionRef();
        mockFirebaseMessagingGetTokenCall();

        await sut.signUserAnonymously(classId: 'classId', userName: 'userName');
        expect(fakeMockFirebaseAuth.currentUser, fakeUser);

        await sut.signOutRequested();
        expect(fakeMockFirebaseAuth.currentUser, null);
      },
    );
  });

  group("isUserConnected", () {
    test(
      "Should return false when an user is not authenticated",
      () async {
        bool isUserConnected = sut.isUserConnected();
        expect(isUserConnected, false);
      },
    );
    test(
      "Should return true when an user is authenticated",
      () async {
        arrangeUserCredential();
        arrangeCollectionRef();
        mockFirebaseMessagingGetTokenCall();

        await sut.signUserAnonymously(classId: 'classId', userName: 'userName');
        bool isUserConnected = sut.isUserConnected();
        expect(isUserConnected, true);
      },
    );
  });

  group("UserModelConverter", () {
    test(
      "toFirestore method should return expected Map<String, Object>",
      () async {
        var testVar = UserModelConverter.toFirestore(user);

        expect(mockUserFromFirestore, testVar);
      },
    );
    test(
      "From firestore method should return valid UserEntity",
      () async {
        var testUser = UserModelConverter.fromFirestore(mockUserFromFirestore);

        expect(user, testUser);
      },
    );
  });
}
