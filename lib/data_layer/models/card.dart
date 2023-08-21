import 'package:cashback_info/data_layer/models/cashback.dart';
import 'package:hive/hive.dart';

part 'card.g.dart';


@HiveType(typeId: 0)
class BankCard {
  @HiveField(0)
  String bankName;
  @HiveField(1)
  List<Cashback> cashbackCategories;
  @HiveField(2)
  DateTime lastUpdate;

  BankCard(
      {required this.bankName,
      required this.cashbackCategories,
      required this.lastUpdate});

  @override
  String toString() {
    String cashback = '';
    for (var item in cashbackCategories) 
    {
      cashback += item.name + ' '; 
    }
    return 'Name: $bankName ' + 'cashbacks: $cashback' + 'last update: $lastUpdate\n';
  }
}