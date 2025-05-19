part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthCheck extends AuthEvent {}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  const AuthLogin(this.email, this.password);
}

final class AuthLogout extends AuthEvent {}
