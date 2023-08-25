import 'package:cashback_info/data_layer/models/cashback.dart';

enum BankType { tinkoff, alpha }

class BankCard {
  String cardName;
  BankType bankType;
  List<Cashback> cashbackCategories;
  DateTime lastUpdate;

  BankCard(
      {required this.cardName,
      required this.bankType,
      required this.cashbackCategories,
      required this.lastUpdate});

  @override
  String toString() {
    String cashback = '';
    for (var item in cashbackCategories) {
      cashback += item.name + ' ';
    }
    return 'Name: $cardName ' 'cashbacks: $cashback' 
        'last update: $lastUpdate\n';
  }
}
