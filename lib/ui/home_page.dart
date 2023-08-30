import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/data_layer/models/cashback.dart';

import 'package:cashback_info/ui/add_card_page.dart';
import 'package:cashback_info/ui/update_card_page.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/homePage';
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<BankCard> _usersCard = [];
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
      // body: ListView.builder(
      //   itemCount: cardList.length,
      //   itemBuilder: (context, index) => showCardInformation(
      //       context, cardList[index], _size.width, _size.height),
      // ),
    );
  }
}

Widget showCardInformation(
    BuildContext context, BankCard card, double width, double height) {
  return Container(
    height: card.cashbackCategories.length < 3 ? height * 0.2 : height * 0.25,
    padding: EdgeInsets.all(width * 0.03),
    margin: EdgeInsets.all(width * 0.03),
    decoration: BoxDecoration(
      color: card.bankType == BankType.tinkoff ? const Color.fromARGB(197, 0, 0, 0) : const Color.fromARGB(172, 244, 67, 54),
      borderRadius: const BorderRadius.all(
        Radius.circular(15),
      ),
      boxShadow: const [
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
              card.cardName,
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

