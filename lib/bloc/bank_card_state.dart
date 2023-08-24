part of 'bank_card_bloc.dart';

@immutable
sealed class BankCardState extends Equatable{
  const BankCardState();
}

final class BankCardInitial extends BankCardState {
  BankCardInitial();
  
  @override

  List<Object?> get props => [];
}

final class AddBankCard extends BankCardState {
  String message;
  
  AddBankCard({required this.message});

  @override
  List<Object?> get props => [message];

}

final class DeleteBankCard extends BankCardState {
  String message;
  
  DeleteBankCard({required this.message});

  @override
  List<Object?> get props => [message];
}

final class GetAllBankCards extends BankCardState {
  List<BankCard> cards; 

  GetAllBankCards({required this.cards}); 

  @override
  List<Object?> get props => [cards];
}
final class GetAllCardsFail extends BankCardState {
  String message; 

  GetAllCardsFail({required this.message}); 

  @override
  List<Object?> get props => [message];
}

final class GetBankCardByName extends BankCardState {
  BankCard card; 

  GetBankCardByName({required this.card});

  @override
  List<Object?> get props => [card];
}
final class GetBankCardFail extends BankCardState {
  String message; 

  GetBankCardFail({required this.message});

  @override
  List<Object?> get props => [message];
}
final class UpdateBankCard extends BankCardState{
  String message; 

  UpdateBankCard({required this.message});

  @override
  List<Object?> get props => [message];
}