part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {
  const UserLoading();
}

final class UserSuccess extends UserState {
  const UserSuccess();
}

final class UserError extends UserState {
  final String message;

  const UserError({required this.message});
}
