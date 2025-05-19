import 'package:bloc/bloc.dart';
import 'package:cashback_info/feature/auth/data/repository/repository.dart';
import 'package:cashback_info/feature/user/data/repository/repository.dart';
import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:cashback_info/internal/service/local_storage.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepo;
  final UserRepository userRepo;
  final LocalStorageService localStorageService;
  AuthBloc(this.authRepo, this.userRepo, this.localStorageService)
      : super(AuthInitial()) {
    on<AuthCheck>(
      (event, emit) async {
        emit(AuthLoading());
        final token = await localStorageService.getUserToken();
        if (token == null) {
          emit(LoggedOut());
        } else {
          final response = await userRepo.getUser(id: token.userId);

          if (response.isSuccessful) {
            final authHeader = "Bearer ${token.token}";
            final user = response.body!;
            emit(LoggedIn(
              authHeader: authHeader,
              user: user,
            ));
          } else {
            emit(AuthError(message: 'Unknown error occured user'));
          }
        }
      },
    );
    on<AuthLogin>(
      (event, emit) async {
        emit(AuthLoading());

        final loginResponse = await authRepo.loggedIn(
          email: event.email,
          password: event.password,
        );

        if (loginResponse.isSuccessful) {
          await localStorageService.saveUserToken(loginResponse.body!);

          add(AuthCheck());
        } else {
          emit(AuthError(message: loginResponse.error.toString()));
        }
      },
    );
    on<AuthLogout>(
      (event, emit) async {
        emit(AuthLoading());
        await localStorageService.clear();

        add(AuthCheck());
      },
    );
  }
}
