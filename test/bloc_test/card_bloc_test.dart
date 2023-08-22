import 'package:cashback_info/bloc/bank_card_bloc.dart';
import 'package:cashback_info/data_layer/database/database.dart';

import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/data_layer/models/cashback.dart';

import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';

void main() {
  group('blocCard', () {
    DataBase db = DataBase(baseName: 'clients_card');

    late BankCardBloc cardBloc;

    setUp(() {
      cardBloc = BankCardBloc();
    });

    BankCard card = BankCard(
      bankName: 'bye',
      cashbackCategories: [
        Cashback(name: 'Авто'),
        Cashback(name: 'АЗС'),
        Cashback(name: 'Цветы'),
      ],
      lastUpdate: DateTime.now(),
    );

    db.deleteBankCard(card.bankName);
    blocTest(
      'Add card with success message',
      build: () => BankCardBloc(),
      act: (bloc) => bloc.add(AddBankCardToDB(userCard: card)),
      expect: () => [AddBankCard(message: 'Карта успешно добавлена')],
    );
    blocTest(
      'Add card with error message',
      build: () => BankCardBloc(),
      act: (bloc) => bloc.add(AddBankCardToDB(userCard: card)),
      expect: () =>
          [AddBankCard(message: 'Карта с таким именем уже существует')],
    );
    blocTest(
      'Delete card with error message',
      build: () => BankCardBloc(),
      act: (bloc) => bloc.add(AddBankCardToDB(userCard: card)),
      expect: () =>
          [AddBankCard(message: 'Карта с таким именем уже существует')],
    );
  });
}
