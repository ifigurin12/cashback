import 'package:bloc/bloc.dart';
import 'package:cashback_info/feature/user/data/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _repo;

  UserBloc(this._repo) : super(UserInitial()) {
    on<CreateUserEvent>((event, emit) async {
      emit(
        UserLoading(),
      );

      final response = await _repo.createUser(
        email: event.email,
        login: event.login,
        password: event.password,
      );

      if (response.isSuccessful) {
        emit(
          UserSuccess(),
        );
      } else {
        emit(
          UserError(
            message: response.error.toString(),
          ),
        );
      }
    });
  }
}
