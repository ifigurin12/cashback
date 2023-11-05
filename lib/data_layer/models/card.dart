import 'package:equatable/equatable.dart';

import 'package:cashback_info/data_layer/models/cashback.dart';

enum BankType { tinkoff, alpha }

class BankCard extends Equatable {
  final int? id;
  final String cardName;
  final BankType bankType;
  final List<Cashback> cashbackCategories;
  final DateTime lastUpdate;

  const BankCard({
    this.id,
    required this.cardName,
    required this.bankType,
    required this.cashbackCategories,
    required this.lastUpdate,
  });

  Map<String, dynamic> toJson() {
    final jsonMap = <String, dynamic>{};
    jsonMap['card_name'] = cardName;
    jsonMap['bank_type'] = bankType == BankType.tinkoff ? 0 : 1;
    jsonMap['card_last_update'] = lastUpdate.toString();
    return jsonMap;
  }

  Map<String, dynamic> toJsonWithoutBankType() {
    final jsonMap = <String, dynamic>{};
    jsonMap['card_name'] = cardName;
    jsonMap['card_last_update'] = DateTime.now().toString();
    return jsonMap;
  }

  factory BankCard.fromJson(Map<String, dynamic> jsonCard,
      List<Map<String, dynamic>> jsonCashbackList) {
    final id = jsonCard['card_id'];
    final cardName = jsonCard['card_name'];
    final bankType =
        jsonCard['bank_type'] == 0 ? BankType.tinkoff : BankType.alpha;
    final lastUpdate = DateTime.parse(jsonCard['card_last_update']);
    List<Cashback> cashbackCategories = [];
    for (var element in jsonCashbackList) {
      cashbackCategories.add(Cashback.fromJson(element));
    }
    return BankCard(
      cardName: cardName,
      bankType: bankType,
      cashbackCategories: cashbackCategories,
      lastUpdate: lastUpdate,
      id: id,
    );
  }
  @override
  String toString() {
    String cashback = '';
    for (var item in cashbackCategories) {
      cashback += '${item.name} ';
    }
    return 'Name: $cardName '
        'cashbacks: $cashback'
        'last update: $lastUpdate\n';
  }

  @override
  List<Object> get props =>
      [id!, cardName, bankType, cashbackCategories, lastUpdate];

  void then(Function(dynamic value) param0) {}
}
