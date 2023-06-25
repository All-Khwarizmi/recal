import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:recal_mobile2/domain/user/user_repository.dart';

part 'user_connection_event.dart';
part 'user_connection_state.dart';
part 'user_connection_bloc.freezed.dart';

@injectable
class UserConnectionBloc
    extends Bloc<UserConnectionEvent, UserConnectionState> {
  final UserRepository _userRepository;
  UserConnectionBloc(this._userRepository)
      : super(UserConnectionState.initial()) {
    on<UserConnectionEvent>((event, emit) async {
      await event.map(
        started: (_) {},
        userConnected: (_) async {
          final userConnectionStreak =
              await _userRepository.getUserConnectionStreak();
          final userLastConnection =
              await _userRepository.getUserLastConnection();
          final streak = userConnectionStreak.getOrElse(() => 0);
          final lastConnection =
              userLastConnection.getOrElse(() => DateTime.now());

          final lastConnectionDay = lastConnection.day;
          final today = DateTime.now().day;

          // If it's one day after last connection
          if (lastConnection.isBefore(DateTime.now()) &&
              today > lastConnectionDay) {
            // Update user
            await _userRepository.updateUserLastConnection();

            // If it's exactly the day after last connection day, add 10 xp to user score
            if (today == lastConnectionDay + 1) {
              await _userRepository.updateUserConnectionStreak(false);
              await _userRepository.updateUserScore(10);
              emit(
                UserConnectionState.userStreakKept(
                  streak,
                  lastConnection,
                ),
              );
            } else {
              await _userRepository.updateUserConnectionStreak(true);
              await _userRepository.updateUserScore(5);
              emit(
                UserConnectionState.userStreakBroke(
                  lastConnection,
                ),
              );
            }
          }
        },
      );
    });
  }
}
