part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class LoggedIn extends AuthState {
  final UserUser user;
  final String authHeader;
  const LoggedIn({required this.authHeader, required this.user});
}

final class LoggedOut extends AuthState {}

final class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});
}
