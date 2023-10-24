import 'package:cashback_info/bloc/add_card_bloc/add_card_bloc_bloc.dart';
import 'package:cashback_info/bloc/read_cards_bloc/read_cards_bloc_bloc.dart';

import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/data_layer/models/cashback.dart';

import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  BankCard cardOld = BankCard(
    cardName: 'TestCard', 
    bankType: BankType.tinkoff,
    cashbackCategories: const [
    Cashback( id: 10, name: 'Образование',),
    Cashback(id: 11, name: 'Одежда и обувь'),
    Cashback(id: 12, name: 'Путешествия'),
    Cashback(id: 13, name: 'Развлечения'),
    ], lastUpdate: DateTime.now(),
  );
  BankCard cardNew = BankCard(
    cardName: 'TestCard', 
    bankType: BankType.tinkoff,
    cashbackCategories: const [
    Cashback( id: 10, name: 'Образование',),
    Cashback(id: 11, name: 'Одежда и обувь'),
    Cashback(id: 12, name: 'Путешествия'),
    ], 
    lastUpdate: DateTime.now(),
  );
  group('blocCard', () {
    blocTest(
      'ListOfCardTest', 
      build:() => ReadCardsBloc(),  
      act: (bloc) => bloc.add(ReadCardList()  ),
      expect: () => <ReadCardsBlocState> [ReadCardsBlocLoading(), ReadCardsBlocSuccess(listCard: const [])],
      );
    blocTest(
      'AddTest', 
      build:() => AddCardBloc(),  
      act: (bloc) => bloc.add(AddCardToDb(card: cardOld)),
      expect: () => <AddCardBlocState> [AddCardBlocLoading(), AddCardBlocSuccess()],
      );
  });
}
