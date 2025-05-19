import 'package:cashback_info/feature/card/bloc/card_bloc.dart';
import 'package:cashback_info/feature/card/ui/page/create_card_page.dart';
import 'package:cashback_info/feature/cashback/bloc/cashback_bloc.dart';
import 'package:cashback_info/feature/cashback/ui/page/update_cashback.dart';
import 'package:cashback_info/internal/api/api.swagger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardPage extends StatelessWidget with RouteAware {
  late List<CardCard> _userCardList;

  CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cashbackBloc = BlocProvider.of<CashbackBloc>(context);
    final cardBloc = BlocProvider.of<CardBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Кешбек по картам',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => BlocProvider.value(
                    value: cardBloc,
                    child: CreateCardPage(),
                  ),
                ),
              );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: BlocBuilder<CardBloc, CardState>(builder: (context, state) {
        if (state is CardLoading && state.userCards != null ||
            state is CardLoaded) {
          late List<CardCard> cardsFromBloc;
          if (state is CardLoading) {
            cardsFromBloc = state.userCards ?? [];
          } else if (state is CardLoaded) {
            cardsFromBloc = state.userCards;
          }
          _userCardList = cardsFromBloc;
          return ListView.builder(
            itemCount: _userCardList.length,
            itemBuilder: (context, index) => showCardInformation(
              context,
              cardBloc,
              cashbackBloc,
              _userCardList[index],
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}

Widget showCardInformation(
  BuildContext context,
  CardBloc cardBloc,
  CashbackBloc cashbackBloc,
  CardCard card,
) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.grey[800],
      borderRadius: const BorderRadius.all(
        Radius.circular(11),
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
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              card.title,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              card.bank!.name,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        textWithCashbacksInColumn(
          context,
          card.categories,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                        value: cashbackBloc,
                        child: BlocProvider.value(
                          value: cardBloc,
                          child: UpdateCashbackPage(
                            bankId: card.bank!.id,
                            cardId: card.id,
                          ),
                        )),
                  ),
                );
              },
              child: Text('Редактировать'),
            ),
            TextButton(
              onPressed: () {
                cardBloc.add(
                  DeleteCard(id: card.id),
                );
              },
              child: Text(
                'Удалить',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Color colorByCashbackPercentage(double percantage) {
  if (percantage < 5) {
    return Colors.green;
  } else if (percantage < 10) {
    return Colors.yellow;
  } else {
    return Colors.red;
  }
}

Widget textWithCashbacksInColumn(
  BuildContext context,
  List<CategoryCategoryWithCashback> cashbacks,
) {
  return Column(
    children: List.generate(
      cashbacks.length,
      (index) => Card(
        color: Colors.grey[700],
        elevation: 4, // Эффект тени
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Закругленные углы
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Внутренние отступы
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cashbacks[index].category.title,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white, // Измените цвет текста, если нужно
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${cashbacks[index].cashback.percentage} %',
                style: TextStyle(
                  fontSize: 16,
                  color: colorByCashbackPercentage(
                      cashbacks[index].cashback.percentage), // Цвет для кэшбэка
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
