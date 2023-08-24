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
      emit(BankCardInitial());
      String? message;
      try {
        db.addBankCard(event.userCard).then((value) => message = value);
        emit(AddBankCard(message: message ?? 'null'));
      } catch (e) {
        print('Ошибка в добавлении карты: ' + e.toString());
      }
    });
    on<UpdateBankCardOnDB>((event, emit) {
      emit(BankCardInitial());
      String? message;
      try {
        db.updateBankCardWithName(event.previousCardName, event.userCard).then(
              (value) => message = value,
            );
        emit(UpdateBankCard(message: message ?? 'null'));
      } catch (e) {
        print('Ошибка в обновлении карты: ' + e.toString());
      }
    });
    on<DeleteBankCardFromDB>((event, emit) {
      emit(BankCardInitial());
      String? message;
      try {
        db.deleteBankCard(event.cardName, ).then(
              (value) => message = value,
            );
        emit(DeleteBankCard(message: message ?? 'null'));
      } catch (e) {
        print('Ошибка в удалении карты: ' + e.toString());
      }
    });
    on<GetBankCardFromDB>((event, emit) {
      emit(BankCardInitial());
      BankCard? userCard; 
      try {
        db.getBankCardWithName(event.cardName).then(
              (value) => userCard = value,
            );
        if (userCard != null)
        {
          emit(GetBankCardByName(card: userCard!));
        }
        else {
          emit(GetBankCardFail(message: 'Ошибка в получении карты'));
        }
      } catch (e) {
        print('Ошибка в получении карты: ' + e.toString());
      }
    });
    on<GetAllBankCardsFromDB>((event, emit) {
      emit(BankCardInitial());
      List<BankCard> userCard = []; 
      try {
        db.getAllBankCards().then(
              (value) => userCard = value.toList(),
            );
        if (!userCard.isEmpty)
        {
          emit(GetAllBankCards(cards: userCard));
        }
        else {
          emit(GetBankCardFail(message: 'Вы пока еще не добавили ни одной карты в приложение'));
        }
      } catch (e) {
        print('Ошибка в получении карты: ' + e.toString());
      }
    });
  }

  @override
  Future<void> close() {
    db.closeDatabase();
    return super.close();
  }


}
