part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class CreateUserEvent extends UserEvent {
  final String email;
  final String password;
  final String login;

  const CreateUserEvent({
    required this.email,
    required this.password,
    required this.login,
  });
}
