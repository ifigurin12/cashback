import 'package:cashback_info/data_layer/database/database.dart';
import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/data_layer/models/cashback.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {
  group('db_test', () {
    var dataBase = DBProvider.db;
    List<Cashback> category = [
      Cashback(id: 4, name: 'Аренда авто'),
      Cashback(id: 5, name: 'Детские товары'),
      Cashback(id: 6, name: 'Дом, ремонт'),
      Cashback(id: 7, name: 'Ж/д билеты'),
      Cashback(id: 8, name: 'Животные'),
    ];
    BankCard aga = BankCard(
      id: 0,
      cardName: 'Пирожки',
      bankType: BankType.tinkoff,
      cashbackCategories: category,
      lastUpdate: DateTime.now(),
    );
    test(
      'db_delete_test',
      () async {
        List<BankCard> listCard = [];
        listCard = await dataBase.getCards();
        for (BankCard card in listCard) {
          await dataBase.deleteCard(card);
        }
        listCard.clear();
        listCard = await dataBase.getCards();
        expect(listCard, []);
      },
    );

    test(
      'db_read_and_add_test',
      () async {
        final id = await dataBase.insertCard(aga);
        aga.id = id;
        final listCard = await dataBase.getCards();
        final card = listCard.firstWhere((element) => element.id == id);
        expect(card, aga);
      },
    );

    test('db_update_test', () async {
      final id = await dataBase.insertCard(aga);
      aga.id = id;
      category = [
        Cashback(id: 9, name: 'Искусство'),
        Cashback(id: 10, name: 'Канцтовары'),
        Cashback(id: 11, name: 'Каршеринг'),
      ];
      aga.cashbackCategories = category;
      await dataBase.updateCard(aga);
      final listCard = await dataBase.getCards();
      final card = listCard.firstWhere((element) => element.id == id); 
      expect(card, aga);
    });
  });
}
