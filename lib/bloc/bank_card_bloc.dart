import 'package:bloc/bloc.dart';
import 'package:cashback_info/data_layer/database/database.dart';
import 'package:cashback_info/data_layer/models/card.dart';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'bank_card_event.dart';
part 'bank_card_state.dart';

class BankCardBloc extends Bloc<BankCardEvent, BankCardState> {
  DataBase db = DataBase(baseName: 'clients_card');

  BankCardBloc() : super(BankCardInitial()) {
    on<AddBankCardToDB>((event, emit) {
      db.addBankCard(event.userCard).then(
            (value) => emit(
              AddBankCard(message: value),
            ),
          );
    });
    on<UpdateBankCardOnDB>((event, emit) {
      db.updateBankCardWithName(event.previousCardName, event.userCard).then(
            (value) => emit(
              UpdateBankCard(message: value),
            ),
          );
    });
    on<DeleteBankCardFromDB>((event, emit) {
      db.deleteBankCard(event.cardName).then(
            (value) => emit(
              DeleteBankCard(message: value),
            ),
          );
    });
    on<GetBankCardFromDB>((event, emit) {
      db.getBankCardWithName(event.cardName).then(
            (value) => emit(
              GetBankCardByName(card: value),
            ),
          );
    });
    on<GetAllBankCardsFromDB>((event, emit) {
      db.getAllBankCards().then(
            (value) => emit(
              GetAllBankCards(
                cards: value.toList(),
              ),
            ),
          );
    });
  }

}
