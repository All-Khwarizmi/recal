import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recal_mobile2/core/error/failure.dart';
import 'package:recal_mobile2/data/auth/repositories/auth_repositories_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recal_mobile2/domain/quizz/entities/user.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:rxdart/rxdart.dart';

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
        ).called(1);
      },
    );
  });
  group('addUser', () {
    test(
      "Should call firestore instance to get doc reference",
      () async {
        arrangeCollectionRef();
        await sut.addUser(user);
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
        await sut.addUser(user);
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
      await ref.doc(userId).set(user.toMap());
      final snapshot = await instance.collection('users').doc(userId).get();

      Map<String, dynamic> returnMap = {'userId': userId, 'ref': ref};
      return returnMap;
    }

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
  });
  group('userStream', () {
    test(
      "Should notify when an user logs in",
      () async {
        arrangeUserCredential();
        arrangeCollectionRef();
        mockFirebaseMessagingGetTokenCall();
        var userStram = sut.userStream();

        userStram.listen((event) {
          if (event != null) {
            print('user');
            expectLater(event, null);
          }
        });
      },
    );
    test(
      "Should notify that an user logged in",
      () async {
        arrangeUserCredential();
        arrangeCollectionRef();
        mockFirebaseMessagingGetTokenCall();
        var userStram = fakeMockFirebaseAuth.authStateChanges();
        sut.signUserAnonymously(classId: 'classId', userName: 'userName');
        userStram.listen((event) {
          if (event != null) {
            print(event);
            print(fakeUser);
            expect(event, fakeUser);
          }
        });
      },
    );
  });
}
