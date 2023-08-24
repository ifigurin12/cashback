import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/data_layer/models/cashback.dart';
import 'package:cashback_info/ui/add_card_page.dart';
import 'package:cashback_info/ui/update_card_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/homePage';

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Кешбек по картам',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(
                      AddCardPage.routeName,
                    );

            },
            icon: Icon(Icons.add),
          ),
        ],
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) =>
            showCardInformation(context, cardList[index], _size.width, _size.height),
      ),
    );
  }
}

Widget showCardInformation(BuildContext context, BankCard card, double width, double height) {
  return Container(
    height: height * 0.30,
    padding: EdgeInsets.all(width * 0.03),
    margin: EdgeInsets.all(width * 0.03),
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 54, 131, 175),
      borderRadius: BorderRadius.all(
        Radius.circular(15),
      ),
      boxShadow: [
        BoxShadow(
          blurRadius: 21,
          spreadRadius: 2,
          color: Color.fromRGBO(0, 0, 0, 0.2),
          blurStyle: BlurStyle.inner,
          offset: Offset(0, 0),
        ),
      ],
    ),
    child: Row(children: [
      Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              card.bankName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            textWithCashbacksInColumn(card.cashbackCategories),
          ],
        ),
      ),
      Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                      UpdateCardPage.routeName,
                      arguments: card,
                    );

              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.delete,
                color: Colors.redAccent,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    ]),
  );
}

Widget textWithCashbacksInColumn(List<Cashback> cashbacks) {
  String result = '';
  cashbacks.forEach((element) {
    result += element.name;
    result += '\n';
  });
  return Text(
    result,
    style: const TextStyle(
      fontSize: 15,
      color: Colors.white,
      fontWeight: FontWeight.w300,
    ),
  );
}

BankCard cardOne = BankCard(
  bankName: 'Сбербанк Мама',
  cashbackCategories: [
    Cashback(name: 'Авто'),
    Cashback(name: 'АЗС'),
    Cashback(name: 'Цветы'),
    Cashback(name: 'Рестораны'),
    Cashback(name: 'Фастфуд'),
  ],
  lastUpdate: DateTime.now(),
);
BankCard cardTwo = BankCard(
  bankName: 'Сбербанк Папа',
  cashbackCategories: [
    Cashback(name: 'Авто'),
    Cashback(name: 'АЗС'),
    Cashback(name: 'Цветы'),
    Cashback(name: 'Рестораны'),
    Cashback(name: 'Фастфуд'),
  ],
  lastUpdate: DateTime.now(),
);
BankCard cardThree = BankCard(
  bankName: 'Тинькофф Бабушка или сбербанк',
  cashbackCategories: [
    Cashback(name: 'Авто'),
    Cashback(name: 'АЗС'),
    Cashback(name: 'Цветы'),
    Cashback(name: 'Рестораны'),
    Cashback(name: 'Фастфуд'),
  ],
  lastUpdate: DateTime.now(),
);

List<BankCard> cardList = [
  cardOne,
  cardTwo,
  cardThree,
];
