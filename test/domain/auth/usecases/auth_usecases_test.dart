import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:recal_mobile2/data/auth/repositories/auth_repositories_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

void main() async {
  late MockFirebaseMessaging mockFirebaseMessaging;
  late String expectedToken;
  late AuthRepositoryImpl sut;

  setUp(() async {
    expectedToken = "DEVICE-TOKEN";
    mockFirebaseMessaging = MockFirebaseMessaging();

    sut = AuthRepositoryImpl(messaging: mockFirebaseMessaging);
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
}
