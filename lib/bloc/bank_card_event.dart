part of 'bank_card_bloc.dart';

@immutable
sealed class BankCardEvent {} 

class AddBankCardToDB extends BankCardEvent {
  BankCard userCard; 

  AddBankCardToDB({required this.userCard});
} 
class UpdateBankCardOnDB extends BankCardEvent {
  BankCard userCard; 
  String previousCardName; 

  UpdateBankCardOnDB({required this.userCard, required this.previousCardName});
}

class DeleteBankCardFromDB extends BankCardEvent {
  String cardName; 

  DeleteBankCardFromDB({required this.cardName});
}
class GetBankCardFromDB extends BankCardEvent {
  String cardName; 

  GetBankCardFromDB({required this.cardName});
} 
class GetAllBankCardsFromDB extends BankCardEvent {}

