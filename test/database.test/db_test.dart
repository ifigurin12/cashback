import 'package:cashback_info/data_layer/database/database.dart';
import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/data_layer/models/cashback.dart';
import 'package:flutter/material.dart';
import 'package:test/test.dart';

void main() {
  group('db_crud_test', () {
    var dataBase = DBProvider.db;
    List<Cashback> category = [
      Cashback(id: 0, name: 'Авто'),
      Cashback(id: 1, name: 'АЗС'),
      Cashback(id: 2, name: 'Аренда авто'),
      Cashback(id: 3, name: 'Дом и ремонт'),
    ];
    BankCard aga = BankCard(
      id: 0,
      cardName: 'Пирожки',
      bankType: BankType.tinkoff,
      cashbackCategories: category,
      lastUpdate: DateTime.now(),
    );
    // test('aga', () async {
    //   final perCard = await dataBase.getCard();
    //   final perCompose = await dataBase.getCompose();
    //   BankCard test = await dataBase.insertCard(aga);
    //   expect(test, aga);
    //   perCard.forEach(
    //     (element) => print(element),
    //   );
    //   perCompose.forEach(
    //     (element) => print(element),
    //   );
    // });

    test('add value test', () async {
      BankCard test = await dataBase.insertCard(aga);
      expect(test, aga);
      final perCard = await dataBase.getCard();
      perCard.forEach((element) {
        print('loh');
        print(element);
      });
    });
    // test('get cards list test', () async {
    //   List<BankCard> testList = await dataBase.getCards();
    //   testList.forEach((element) => print(element.toString()),);
    //   expect(1, 1);
    // });

    // test() async {
    //   List<BankCard> cardList = await dataBase.getCards();
    //   expect(cardList, [aga]);
    // }
  });
}
