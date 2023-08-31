part of 'add_card_bloc_bloc.dart';

sealed class AddCardBlocEvent extends Equatable {
  const AddCardBlocEvent();

  @override
  List<Object> get props => [];
}

class AddCardToDb extends AddCardBlocEvent {
  BankCard card;

  AddCardToDb({required this.card});

  @override
  List<Object> get props => [card];
}
