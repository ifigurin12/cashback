import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/data_layer/models/cashback.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static late Database _database;

  // Таблица с картами
  final String _cardTable = 'bank_card';
  final String _bankType = 'bank_type';
  final String _cardId = 'card_id';
  final String _cardName = 'card_name';
  final String _lastUpdate = 'card_last_update';
  // 2 Таблицы с кешбеками для альфа и тинькофф карт
  final String _cashbackTinkoffTable = 'tinkoff_cashback';
  final String _cashbackAlphaTable = 'alpha_cashback';
  final String _categoryId = 'category_id';
  final String _categoryName = 'category_name';
  // 2 Таблицы с сопоставлением id карты и id кешбека
  final String _cardTinkoffCashbackTable = 'bank_card_tinkoff_cashback';
  final String _bankCardTinkoffCashbackPk = 'bank_card_alpha_cashnack_pk';
  final String _cardAlphaCashbackTable = 'bank_card_alpha_cashback';
  final String _bankCardAlphaCashbackPk = 'bank_card_alpha_cashback_pk';
  final String _idCard = 'card_id';
  final String _idCategory = 'category_id';

  Future<Database> get database async {
    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    sqfliteFfiInit();
    Directory dir = Directory.current;
    String path = 'сards.db';
    databaseFactory = databaseFactoryFfi;
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }
  void clearDB() async{
    Database db = await database;
    await db.execute('DROP TABLE $_cardTable');
    await db.execute('DROP TABLE $_cardTinkoffCashbackTable');
    await db.execute('DROP TABLE $_cardAlphaCashbackTable');
  }
  void _createDB(Database db, int version) async {
    await db.execute(
      '''CREATE TABLE $_cardTable(
      $_cardId INTEGER  PRIMARY KEY AUTOINCREMENT, 
      $_cardName TEXT, 
      $_bankType INTEGER,
      $_lastUpdate TEXT
      )''',
    );
    await db.execute(
      '''CREATE TABLE $_cashbackTinkoffTable($_categoryId INTEGER PRIMARY KEY,
       $_categoryName TEXT)''',
    );
    await db.execute(
      '''CREATE TABLE $_cashbackAlphaTable($_categoryId INTEGER PRIMARY KEY, 
      $_categoryName TEXT)''',
    );
    await db.execute('''CREATE TABLE $_cardTinkoffCashbackTable(
      $_idCard INTEGER REFERENCES $_cardTable($_cardId), 
      $_idCategory INTEGER REFERENCES $_cashbackTinkoffTable($_idCategory), 
      CONSTRAINT $_bankCardTinkoffCashbackPk PRIMARY KEY ($_idCard, $_idCategory) 
      )
    ''');
    await db.execute(
      '''CREATE TABLE $_cardAlphaCashbackTable(
      $_idCard INTEGER REFERENCES $_cardTable($_cardId), 
      $_idCategory INTEGER REFERENCES $_cashbackAlphaTable($_idCategory), 
      CONSTRAINT $_bankCardAlphaCashbackPk PRIMARY KEY ($_idCard, $_idCategory)
       )''',
    );
    Cashback.tinkoffCategoriesOfCashback.forEach(
      (item) async => await db.insert(_cashbackTinkoffTable, item.toJson()),
    );
    Cashback.alphaCategoriesOfCashback.forEach(
      (item) async => await db.insert(_cashbackTinkoffTable, item.toJson()),
    );
  }

  Future<Map<String, dynamic>> getCategory(int categoryId, int bankType) async {
    Database db = await database;
    Map<String, dynamic> categories = {};
    switch (bankType) {
      case 0:
        categories = (
          await db.query(
            _cashbackTinkoffTable,
            where: '"$categoryId" = ?',
            whereArgs: [categoryId],
          ),
        ) as Map<String, dynamic>;
      case 1:
        categories = (
          await db.query(
            _cashbackAlphaTable,
            where: '"$categoryId" = ?',
            whereArgs: [categoryId],
          ),
        ) as Map<String, dynamic>;
    }
    return categories;
  }
  Future<List<Map<String, dynamic>>> getCard() async {
    Database db = await database;
    return db.query(_cardTable);
  }
  Future<List<Map<String, dynamic>>> getCompose() async {
    Database db = await database;
    return db.query(_cashbackTinkoffTable);
  }
  // // READ
  Future<List<BankCard>> getCards() async {
    Database db = await database;
    List<BankCard> cardList = [];
    final List<Map<String, dynamic>> cardMapList = await db.query(_cardTable);
    var cashbackIdCategories = [];
    List<Map<String, dynamic>> jsonCashback = [];

    cardMapList.forEach((jsonCard) async {
      switch (jsonCard['bank_type']) {
        case 0:
          cashbackIdCategories = await db.query(
            _cardTinkoffCashbackTable,
            columns: ['$_idCategory'],
            where: '"$_idCard" = ?',
            whereArgs: [jsonCard['id']],
          );
          cashbackIdCategories.forEach(
              (id) async => jsonCashback.add(await getCategory(id, 0)));
        case 1:
          cashbackIdCategories = await db.query(
            _cardAlphaCashbackTable,
            columns: ['$_idCategory'],
            where: '"$_idCard" = ?',
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
    db.insert(_cardTable, card.toJson());
    switch (card.bankType) {
      case BankType.tinkoff:
        card.cashbackCategories.forEach((category) {
          db.insert(_cardTinkoffCashbackTable,
              {_idCard: card.id, _idCategory: category.id});
        });
      case BankType.alpha:
        card.cashbackCategories.forEach((category) {
          db.insert(_cardTinkoffCashbackTable,
              {_idCard: card.id, _idCategory: category.id});
        });
    }
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
