import "package:fetch_data_flutter/bloc/user_app_event.dart";
import "package:fetch_data_flutter/bloc/user_app_state.dart";
import "package:fetch_data_flutter/repo/repositories.dart";
import "package:flutter_bloc/flutter_bloc.dart";

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;

  UserBloc(this._userRepository) : super(UserLoadingState()) {
    on<LoadUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        final users = await _userRepository.getUser();
        emit(UserLoadedState(users));
      } catch (e) {
        emit(
          UserErrorState(e.toString()),
        );
      }
    });
  }
}
