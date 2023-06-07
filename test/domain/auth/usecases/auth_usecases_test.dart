import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recal_mobile2/data/auth/repositories/auth_repositories_impl.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recal_mobile2/domain/quizz/entities/user.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() async {
  late MockFirebaseMessaging mockFirebaseMessaging;
  late MockUserCredential mockUserCredential;
  late MockFirebaseFirestore mockFirebaseFirestore;
  late FirebaseAuth mockFirebaseAuth;
  late String expectedToken;
  late AuthRepositoryImpl sut;
  late FakeFirebaseFirestore fakeFirebaseFirestore;
  late User user;

  setUp(() {
    expectedToken = "DEVICE-TOKEN";
    mockFirebaseMessaging = MockFirebaseMessaging();
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockFirebaseFirestore = MockFirebaseFirestore();
    fakeFirebaseFirestore = FakeFirebaseFirestore();
    user = User(
        userId: "12345",
        userName: "Mike",
        classId: "502",
        userNotificationTokenId: "userNotificationTokenId",
        userScore: 50,
        lastConnection: DateTime.now(),
        connectionStreak: 5);

    sut = AuthRepositoryImpl(
        messaging: mockFirebaseMessaging,
        firebaseAuth: mockFirebaseAuth,
        firebaseFirestore: mockFirebaseFirestore,
        user: user);
  });
  void arrangeCollectionRef() {
    when(() => mockFirebaseFirestore.collection("users"))
        .thenReturn(fakeFirebaseFirestore.collection('users'));
  }

  void arrangeUserCredential() {
    when(
      () => mockFirebaseAuth.signInAnonymously(),
    ).thenAnswer((invocation) async => mockUserCredential);
  }

  group("getUserNotificationToken", () {
    void mockFirebaseMessagingGetTokenCall() {
      when(
        () => mockFirebaseMessaging.getToken(),
      ).thenAnswer((_) async => expectedToken);
    }

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
        String? result = await sut.getUserNotificationToken();
        expect(result.runtimeType, String);
      },
    );
    test(
      "Return value should be [DEVICE-ID]",
      () async {
        mockFirebaseMessagingGetTokenCall();
        String? result = await sut.getUserNotificationToken();

        expect(result, expectedToken);
      },
    );
  });

  group("signUserAnonymously", () {
    void arrangeMethodCall() {
      when(
        () => mockFirebaseAuth.signInAnonymously(),
      ).thenAnswer((invocation) async => mockUserCredential);
    }

    test(
      "Should call method signUserAnonymously",
      () async {
        arrangeMethodCall();
        arrangeCollectionRef();
        await sut.signUserAnonymously(user);
        verify(
          () => mockFirebaseAuth.signInAnonymously(),
        ).called(1);
      },
    );
    /* test(
      "Should call addUser ",
      () async {
        arrangeUserCredential();
        // arrangeCollectionRef();
        when(() => mockFirebaseFirestore.collection("users"))
            .thenReturn(fakeFirebaseFirestore.collection('users'));

        await sut.addUser(user);
        verify(
          () => sut.addUser(user),
        ).called(1);
      },
    ); */
  });
  group('addUser', () {
    test(
      "Should call firestore instance",
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
}
