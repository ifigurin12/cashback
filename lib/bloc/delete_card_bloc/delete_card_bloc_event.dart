part of 'delete_card_bloc_bloc.dart';

sealed class DeleteCardBlocEvent extends Equatable {
  const DeleteCardBlocEvent();

  @override
  List<Object> get props => [];
}

class DeleteCardFromDb extends DeleteCardBlocEvent{
  final BankCard userCard; 

  const DeleteCardFromDb({required this.userCard});

  @override
  List<Object> get props => [userCard];
}