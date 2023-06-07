import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recal_mobile2/data/auth/repositories/auth_repositories_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUserCredential extends Mock implements UserCredential {}

void main() async {
  late MockFirebaseMessaging mockFirebaseMessaging;
  late MockUserCredential mockUserCredential;
  late FirebaseAuth mockFirebaseAuth;
  late String expectedToken;
  late AuthRepositoryImpl sut;

  setUp(() async {
    expectedToken = "DEVICE-TOKEN";
    mockFirebaseMessaging = MockFirebaseMessaging();
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();

    sut = AuthRepositoryImpl(
        messaging: mockFirebaseMessaging, firebaseAuth: mockFirebaseAuth);
  });

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
        await sut.signUserAnonymously();
        verify(
          () => mockFirebaseAuth.signInAnonymously(),
        ).called(1);
      },
    );

  });
}
