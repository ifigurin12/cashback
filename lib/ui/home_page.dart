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

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            icon: const Icon(Icons.add),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return CardCategoryFilter();
                },
              );
            },
          ),
        ],
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
                size.width,
                size.height,
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

class CardCategoryFilter extends StatefulWidget {
  const CardCategoryFilter({super.key});

  @override
  State<CardCategoryFilter> createState() => _CardCategoryFilterState();
}

class _CardCategoryFilterState extends State<CardCategoryFilter> {
  Set<Cashback> cashbackTinkoff = <Cashback>{};
  Set<Cashback> cashbackAlpha = <Cashback>{};

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        height: size.height * 0.35,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text('Категории тинькофф: '),
            SizedBox(
              height: size.height * 0.1,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: Cashback.tinkoffCategoriesOfCashback.length,
                itemBuilder: (context, index) => FilterChip(
                  selected: cashbackTinkoff
                      .contains(Cashback.tinkoffCategoriesOfCashback[index]),
                  onSelected: (bool selected) {
                    setState(() {
                      selected
                          ? cashbackTinkoff
                              .add(Cashback.tinkoffCategoriesOfCashback[index])
                          : cashbackTinkoff.remove(
                              Cashback.tinkoffCategoriesOfCashback[index]);
                    });
                  },
                  label: Text(Cashback.tinkoffCategoriesOfCashback[index].name),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 5),
              ),
            ),
            const Text('Категории Альфа: '),
            SizedBox(
              height: size.height * 0.1,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: Cashback.alphaCategoriesOfCashback.length,
                itemBuilder: (context, index) => FilterChip(
                  selected: cashbackAlpha
                      .contains(Cashback.alphaCategoriesOfCashback[index]),
                  onSelected: (bool selected) {
                    setState(() {
                      selected
                          ? cashbackAlpha
                              .add(Cashback.alphaCategoriesOfCashback[index])
                          : cashbackAlpha.remove(
                              Cashback.alphaCategoriesOfCashback[index]);
                    });
                  },
                  label: Text(Cashback.alphaCategoriesOfCashback[index].name),
                ),
                separatorBuilder: (context, index) => SizedBox(width: 5),
              ),
            ),
            Center(
              child: OutlinedButton(
                child: Text('Выбрать'),
                onPressed: () {
                  // context.read<ReadCardsBloc>().add(
                  //       ReadCardListWithFilter(
                  //         tinkoffCashback: cashbackTinkoff.toList(),
                  //         alphaCashback: cashbackAlpha.toList(),
                  //       ),
                  //     );
                  //     Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget showCardInformation(
    BuildContext context, BankCard card, double width, double height) {
  double containerHeight =
      card.cashbackCategories.length < 4 ? height * 0.20 : height * 0.25;
  return Container(
    height: containerHeight,
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
            textWithCashbacksInColumn(
                card.cashbackCategories, containerHeight, context),
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
                    context: context,
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
                            context.read<DeleteCardBloc>().add(
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

Widget textWithCashbacksInColumn(
    List<Cashback> cashbacks, double containerHeight, BuildContext context) {
  List<Row> cashbackName = List.generate(
    cashbacks.length,
    (index) => Row(
      children: [
        Text(cashbacks[index].name),
      ],
    ),
  );

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: cashbackName,
  );
}
