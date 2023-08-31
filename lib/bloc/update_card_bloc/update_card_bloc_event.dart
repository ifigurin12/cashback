part of 'update_card_bloc_bloc.dart';

sealed class UpdateCardBlocEvent extends Equatable {
  const UpdateCardBlocEvent();

  @override
  List<Object> get props => [];
}

class UpdateCardOnDb extends UpdateCardBlocEvent{
  BankCard userCard; 

  UpdateCardOnDb({required this.userCard});
}