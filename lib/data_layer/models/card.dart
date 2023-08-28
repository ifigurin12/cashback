import 'dart:convert';

import 'package:cashback_info/data_layer/models/cashback.dart';
import 'package:cashback_info/ui/update_card_page.dart';

enum BankType { tinkoff, alpha }

class BankCard {
  int id;
  String cardName;
  BankType bankType;
  List<Cashback> cashbackCategories;
  DateTime lastUpdate;

  BankCard(
      {required this.cardName,
      required this.id,
      required this.bankType,
      required this.cashbackCategories,
      required this.lastUpdate});

  Map<String, dynamic> toJson() {
    final jsonMap = Map<String, dynamic>();
    jsonMap['card_name'] = cardName;
    jsonMap['bank_type'] = bankType == BankType.tinkoff ? 0 : 1;
    jsonMap['card_last_update'] = lastUpdate.toString();
    return jsonMap;
  }

  factory BankCard.fromJson(
      Map<String, dynamic> jsonCard, List<Map<String, dynamic>> jsonCashbackList) {
    final id = jsonCard['id'];
    final cardName = jsonCard['card_name'];
    final bankType =
        jsonCard['bank_type'] == 0 ? BankType.tinkoff : BankType.alpha;
    final lastUpdate = DateTime.parse(jsonCard['card_last_update']);
    List<Cashback> cashbackCategories = [];
    jsonCashbackList.forEach(
      (element) => cashbackCategories.add(Cashback.fromJson(element)),
    );
    return BankCard(
        cardName: cardName,
        id: id,
        bankType: bankType,
        cashbackCategories: cashbackCategories,
        lastUpdate: lastUpdate);
  }
  @override
  String toString() {
    String cashback = '';
    for (var item in cashbackCategories) {
      cashback += item.name + ' ';
    }
    return 'Name: $cardName '
        'cashbacks: $cashback'
        'last update: $lastUpdate\n';
  }
}
