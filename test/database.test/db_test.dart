import 'package:cashback_info/data_layer/database/database.dart' as db;
import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/data_layer/models/cashback.dart';
import 'package:test/test.dart';

void main() {
  group('db_crud_test', () {
    var dataBase = db.DBProvider;
    List<Cashback> category = [
      Cashback(id: 0, name: 'Цветы'),
      Cashback(id: 1, name: 'Авто'),
      Cashback(id: 2, name: 'АЗС')
    ];
    BankCard aga = BankCard(
        id: 0,
        cardName: 'cardName',
        bankType: BankType.alpha,
        cashbackCategories: category,
        lastUpdate: DateTime.now());

  });
}
