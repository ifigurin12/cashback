import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/data_layer/models/cashback.dart';

class DataBase {
  String baseName;
  Future<Box<BankCard>>? cardBox;

  void closeDatabase() {
    Hive.close();
  }

  void initialize() {
    cardBox = Hive.openBox<BankCard>(baseName);
  }

  DataBase({required this.baseName}) {
    Hive.init(Directory.current.path);
    if (!Hive.isAdapterRegistered(0) || !Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(CashbackAdapter());
      Hive.registerAdapter(BankCardAdapter());
    }
    initialize();
  }

  Future<String> addBankCard(BankCard card) async {
    String resultMessage = '';
    var box = await cardBox;
    if (box!.keys.contains(card.bankName)) {
      resultMessage = 'Карта с таким именем уже существует';
    } else {
      box.put('${card.bankName}', card);
      resultMessage = 'Карта успешно добавлена';
    }
    return resultMessage;
  }

  Future<String> deleteBankCard(String cardName) async {
    String resultMessage = '';
    var box = await cardBox;
    if (box!.containsKey(cardName)) {
      box.delete(cardName);
      resultMessage = 'Карта успешно удалена';
    } else {
      resultMessage = 'Карта с таким именем не существует';
    }
    return resultMessage;
  }

  Future<String> updateBankCardWithName(
      String previousCardName, BankCard card) async {
    String resultMessage = '';
    var box = await cardBox;
    if (box!.containsKey(previousCardName)) {
      box.delete(previousCardName);
      box.put(card.bankName, card);
      resultMessage = 'Карта успешно обновлена';
    } else {
      resultMessage = 'Карта с таким именем не существует';
    }
    return resultMessage;
  }

  Future<BankCard> getBankCardWithName(String cardName) async {
    var box = await cardBox;
    BankCard desiredCard = box!.get(cardName)!;
    return desiredCard;
  }

  Future<Iterable<BankCard>> getAllBankCards() async {
    var box = await cardBox;
    var cardList = box!.values;
    return cardList;
  }
}
