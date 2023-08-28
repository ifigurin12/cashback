import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/data_layer/models/cashback.dart';

import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static late Database _database;

  // Таблица с картами
  String cardTable = 'bank_card';
  String bankType = 'bank_type';
  String cardId = 'card_id';
  String cardName = 'card_name';
  String lastUpdate = 'card_last_update';
  // 2 Таблицы с кешбеками для альфа и тинькофф карт
  String cashbackTinkoffTable = 'tinkoff_cashback';
  String cashbackAlphaTable = 'alpha_cashback';
  String categoryId = 'category_id';
  String categoryName = 'category_name';
  // 2 Таблицы с сопоставлением id карты и id кешбека
  String cardTinkoffCashbackTable = 'bank_card_tinkoff_cashback';
  String bankCardTinkoffCashbackPk = 'bank_card_alpha_cashnack_pk';
  String cardAlphaCashbackTable = 'bank_card_alpha_cashback';
  String bankCardAlphaCashbackPk = 'bank_card_alpha_cashback_pk';
  String idCard = 'card_id';
  String idCategory = 'category_id';
  Future<Database> get database async {
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'Cards.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE $cardTable($cardId INTEGER PRIMARY KEY AUTOINCREMENT, 
      $cardName TEXT, 
      $bankType INTEGER,
      $lastUpdate TEXT)''',
    );
    await db.execute(
      '''CREATE TABLE $cashbackTinkoffTable($categoryId INTEGER PRIMARY KEY,
       $categoryName TEXT)''',
    );
    await db.execute(
      '''CREATE TABLE $cashbackAlphaTable($categoryId INTEGER PRIMARY KEY, 
      $categoryName TEXT)''',
    );
    await db.execute('''CREATE TABLE $cardTinkoffCashbackTable(
      $idCard INTEGER REFERENCES $cardTable($cardId), 
      $idCategory INTEGER REFERENCES $cashbackTinkoffTable($idCategory), 
      CONSTRAINT $bankCardTinkoffCashbackPk PRIMARY KEY ($idCard, $idCategory)
      )',
    ''');
    await db.execute(
      '''CREATE TABLE $cardAlphaCashbackTable(
      $idCard INTEGER REFERENCES $cardTable($cardId), 
      $idCategory INTEGER REFERENCES $cashbackAlphaTable($idCategory), 
      CONSTRAINT $bankCardAlphaCashbackPk PRIMARY KEY ($idCard, $idCategory)
       )''',
    );
    Cashback.tinkoffCategoriesOfCashback.forEach(
      (item) async => await db.insert(cashbackTinkoffTable, item.toJson()),
    );
    Cashback.alphaCategoriesOfCashback.forEach(
      (item) async => await db.insert(cashbackTinkoffTable, item.toJson()),
    );
  }

  Future<Map<String, dynamic>> getCategory(int categoryId, int bankType) async {
    Database db = await database;
    Map<String, dynamic> categories = {};
    switch (bankType) {
      case 0:
        categories = (
          await db.query(
            cashbackTinkoffTable,
            where: '"$categoryId" = ?',
            whereArgs: [categoryId],
          ),
        ) as Map<String, dynamic>;
      case 1:
        categories = (
          await db.query(
            cashbackAlphaTable,
            where: '"$categoryId" = ?',
            whereArgs: [categoryId],
          ),
        ) as Map<String, dynamic>;
    }
    return categories;
  }

  // // READ
  Future<List<BankCard>> getStudents() async {
    Database db = await database;
    List<BankCard> cardList = [];
    final List<Map<String, dynamic>> cardMapList = await db.query(cardTable);
    var cashbackIdCategories = [];
    List<Map<String, dynamic>> jsonCashback = [];

    cardMapList.forEach((jsonCard) async {
      switch (jsonCard['bank_type']) {
        case 0:
          cashbackIdCategories = await db.query(
            cardTinkoffCashbackTable,
            columns: ['idCategory'],
            where: '"$idCard" = ?',
            whereArgs: [jsonCard['id']],
          );
          cashbackIdCategories.forEach(
              (id) async => jsonCashback.add(await getCategory(id, 0)));
        case 1:
          cashbackIdCategories = await db.query(
            cardTinkoffCashbackTable,
            columns: ['idCategory'],
            where: '"$idCard" = ?',
            whereArgs: [jsonCard['id']],
          );
          cashbackIdCategories.forEach(
              (id) async => jsonCashback.add(await getCategory(id, 1)));
      }
      cardList.add(BankCard.fromJson(jsonCard, jsonCashback));
      jsonCashback.clear();
    });
    return cardList;
  }

  //  INSERT
  Future<BankCard> insertCard(BankCard card) async {
    Database db = await database;
    switch (card.bankType) {
      case BankType.tinkoff:
        card.cashbackCategories.forEach((element) {
          db.insert(cardTinkoffCashbackTable, element.toJson());
        });
      case BankType.alpha:
        card.cashbackCategories.forEach((element) {
          db.insert(cardAlphaCashbackTable, element.toJson());
        });
    }
    ;
    db.insert(cardTable, card.toJson());
    return card;
  }

  // //UPDATE
  // Future<int> updateStudent(Student student) async {
  //   Database db = await this.database;
  //   return await db.update(
  //     studentsTable,
  //     student.toMap(),
  //     where: '$columnId = ?',
  //     whereArgs: [student.id],
  //   );
  // }

  // //DELETE
  // Future<int> deleteStudent(int? id) async {
  //   Database db = await this.database;
  //   return await db.delete(
  //     studentsTable,
  //     where: '$columnId = ?',
  //     whereArgs: [id],
  //   );
  // }
}
