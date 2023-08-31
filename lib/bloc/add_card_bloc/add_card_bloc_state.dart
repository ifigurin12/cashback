part of 'add_card_bloc_bloc.dart';

sealed class AddCardBlocState extends Equatable {
  const AddCardBlocState();

  @override
  List<Object> get props => [];
}

final class AddCardBlocInitial extends AddCardBlocState {}

final class AddCardBlocLoading extends AddCardBlocState {}

final class AddCardBlocSuccess extends AddCardBlocState {}

final class AddCardBlocFailure extends AddCardBlocState {}
