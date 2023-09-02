import 'package:cashback_info/bloc/delete_card_bloc/delete_card_bloc_bloc.dart';
import 'package:cashback_info/bloc/read_cards_bloc/read_cards_bloc_bloc.dart';
import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/data_layer/models/cashback.dart';

import 'package:cashback_info/ui/add_card_page.dart';
import 'package:cashback_info/ui/update_card_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget with RouteAware {
  late List<BankCard> _userCardList;
  static const String routeName = '/homePage';

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ReadCardsBloc>();
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
      body: BlocConsumer<ReadCardsBloc, ReadCardsBlocState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ReadCardsBlocInitial) {
            return const Center(
              child: Text('aga'),
            );
          } else if (state is ReadCardsBlocLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ReadCardsBlocSuccess) {
            _userCardList = state.props[0] as List<BankCard>;
            return ListView.builder(
              itemCount: _userCardList.length,
              itemBuilder: (context, index) => showCardInformation(
                context,
                _userCardList[index],
                _size.width,
                _size.height,
              ),
            );
          } else if (state is ReadCardsBlocEmpty) {
            return const Center(
              child: Text(
                'Вы пока не добавили ни одной карты в приложение',
              ),
            );
          } else {
            return const Center(
              child: Text(
                'Загрузка данных завершена с ошибкой, приносим свои изменения(',
              ),
            );
          }
        },
      ),
    );
  }
}

Widget showCardInformation(
    BuildContext mainContext, BankCard card, double width, double height) {
  return Container(
    height: card.cashbackCategories.length < 3 ? height * 0.2 : height * 0.25,
    padding: EdgeInsets.all(width * 0.03),
    margin: EdgeInsets.all(width * 0.03),
    decoration: BoxDecoration(
      color: card.bankType == BankType.tinkoff
          ? const Color.fromARGB(197, 0, 0, 0)
          : const Color.fromARGB(172, 244, 67, 54),
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
                Navigator.of(mainContext).pushNamed(
                  UpdateCardPage.routeName,
                  arguments: card,
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
            ),
            BlocListener<DeleteCardBloc, DeleteCardBlocState>(
              listener: (context, state) {
                if (state is DeleteCardBlocFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.red,
                      content: Text(
                        'Удаление карты выполнено с ошибкой',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  );
                }
                if (state is DeleteCardBlocSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      duration: Duration(seconds: 1),
                      backgroundColor: Colors.green,
                      content: Text(
                        'Удаление карты выполнено успешно',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                  );
                  context.read<ReadCardsBloc>().add(ReadCardList());
                }
              },
              child: IconButton(
                onPressed: () {
                  showDialog<String>(
                    context: mainContext,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text('Удалить'),
                      content: Text('Удалить карту с именем ${card.cardName}'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Отмена'),
                        ),
                        TextButton(
                          onPressed: () {
                            mainContext.read<DeleteCardBloc>().add(
                                  DeleteCardFromDb(userCard: card),
                                );
                            Navigator.pop(context);
                          },
                          child: const Text('Удалить'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                  size: 30,
                ),
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
