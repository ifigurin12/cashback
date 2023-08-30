import 'dart:io';

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
      (item) async => await db.insert(_cashbackAlphaTable, item.toJson()),
    );
  }

  Future<List<Map<String, dynamic>>> getCategory(
      int categoryId, int bankType) async {
    Database db = await database;
    switch (bankType) {
      case 0:
        return await db.rawQuery(
          'SELECT* FROM $_cashbackTinkoffTable WHERE $_categoryId = ?',
          [categoryId],
        );

      case 1:
        return await db.rawQuery(
          'SELECT* FROM $_cashbackAlphaTable WHERE $_categoryId = ?',
          [categoryId],
        );
      default:
        return [];
    }
  }

  // // READ
  Future<List<BankCard>> getCards() async {
    Database db = await database;

    List<BankCard> cardList = []; // Result of request

    List<Map<String, dynamic>> cardMapList =
        await db.query(_cardTable); // select bank_card
    List<Map<String, dynamic>> cashbackIdCategories =
        []; // category_id with card_id
    List<Map<String, dynamic>> jsonCashbackList =
        []; // json for cashback initialize
    List<Map<String, dynamic>> jsonCashbackOne = [];

    for (Map<String, dynamic> jsonCard in cardMapList) {
      jsonCashbackList.clear();
      switch (jsonCard['bank_type']) {
        case 0:
          cashbackIdCategories = await db.query(
            _cardTinkoffCashbackTable,
            columns: [_idCategory],
            where: '$_idCard = ?',
            whereArgs: [jsonCard[_cardId]],
          );
          for (Map<String, dynamic> id in cashbackIdCategories) {
            jsonCashbackOne = await getCategory(id[_idCategory], 0);
            jsonCashbackList.add(jsonCashbackOne[0]);
          }
        case 1:
          cashbackIdCategories = await db.query(
            _cardAlphaCashbackTable,
            columns: [_idCategory],
            where: '$_idCard = ?',
            whereArgs: [jsonCard[_cardId]],
          );

          for (Map<String, dynamic> id in cashbackIdCategories) {
            jsonCashbackOne = await getCategory(id[_idCategory], 1);
            jsonCashbackList.add(jsonCashbackOne[0]);
          }
      }
      cardList.add(BankCard.fromJson(jsonCard, jsonCashbackList));
    }
    return cardList;
  }

  //  INSERT
  Future<int> insertCard(BankCard card) async {
    Database db = await database;
    Map<String, dynamic> cardJson = card.toJson();
    final id = await db.rawInsert('''INSERT INTO 
    $_cardTable($_cardName, $_bankType, $_lastUpdate) 
    VALUES(?, ?, ?)''', [
      cardJson['card_name'],
      cardJson['bank_type'],
      cardJson['card_last_update']
    ]);

    switch (card.bankType) {
      case BankType.tinkoff:
        for (Cashback category in card.cashbackCategories) {
          await db.insert(
            _cardTinkoffCashbackTable,
            {_idCard: id, _idCategory: category.id},
          );
        }
      case BankType.alpha:
        for (Cashback category in card.cashbackCategories) {
          await db.insert(
            _cardAlphaCashbackTable,
            {_idCard: id, _idCategory: category.id},
          );
        }
    }
    return id;
  }

  //UPDATE
  Future<int> updateCard(BankCard card) async {
    Database db = await database;
    switch (card.bankType) {
      case BankType.tinkoff:
        await db.rawDelete(
          '''DELETE FROM  $_cardTinkoffCashbackTable WHERE $_idCard = ? ''',
          [card.id],
        );
        for (Cashback cashback in card.cashbackCategories) {
          await db.rawInsert(
            '''INSERT INTO $_cardTinkoffCashbackTable ($_idCard, $_idCategory) VALUES (?, ?); ''',
            [card.id, cashback.id],
          );
        }
      case BankType.alpha:
        await db.rawDelete(
          '''DELETE FROM  $_cardAlphaCashbackTable WHERE $_idCard = ? ''',
          [card.id],
        );
        for (Cashback cashback in card.cashbackCategories) {
          await db.rawInsert(
            '''INSERT INTO $_cardAlphaCashbackTable ($_idCard, $_idCategory) VALUES (?, ?); ''',
            [card.id, cashback.id],
          );
        }
    }
    return await db.update(
      _cardTable,
      card.toJson(),
      where: '$_idCard = ?',
      whereArgs: [card.id],
    );
  }

  //DELETE
  Future<int> deleteCard(BankCard card) async {
    Database db = await database;
    switch (card.bankType) {
      case BankType.tinkoff:
        await db.rawDelete(
          '''DELETE FROM  $_cardTinkoffCashbackTable WHERE $_idCard = ? ''',
          [card.id],
        );
      case BankType.alpha:
        await db.rawDelete(
          '''DELETE FROM  $_cardAlphaCashbackTable WHERE $_idCard = ? ''',
          [card.id],
        );
    }
    return await db.delete(
      _cardTable,
      where: '$_idCard = ?',
      whereArgs: [card.id],
    );
  }
}
