import 'package:cashback_info/bloc/add_card_bloc/add_card_bloc_bloc.dart';
import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/data_layer/models/cashback.dart';
import 'package:cashback_info/ui/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<String> listOfBank = ['Tinkoff Bank', 'Alpha Bank'];
List<String> countOfCategories = ['1', '2', '3', '4', '5', '6'];

class AddCardPage extends StatefulWidget {
  static const String routeName = '/addCardPage';

  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  List<Cashback> categoriesOfCashback = [];
  String _selectedCountOfCategory = countOfCategories[3];
  List<Cashback> _selectedCategories = [];
  String _selectedCardBank = listOfBank[0];

  TextEditingController _cardNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  late BankCard _userCard;

  @override
  void initState() {
    _selectedCategories = List.filled(
      int.parse(_selectedCountOfCategory),
      _selectedCardBank == listOfBank[0]
          ? Cashback.tinkoffCategoriesOfCashback[0]
          : Cashback.alphaCategoriesOfCashback[0],
    );
    super.initState();
  }

  @override
  void dispose() {
    _cardNameController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Добавление карты',
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                    controller: _cardNameController,
                    decoration: const InputDecoration(
                      hintText: 'Введите название карты',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Пожалуйста введие название карты';
                      }
                      return null;
                    }),
                Row(
                  children: [
                    const Expanded(
                      flex: 2,
                      child: Text('Выберите банк вашей карты:'),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        value: _selectedCardBank,
                        items: listOfBank
                            .map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCardBank = value!;
                            _selectedCategories = List.filled(
                              int.parse(_selectedCountOfCategory),
                              _selectedCardBank == listOfBank[0]
                                  ? Cashback.tinkoffCategoriesOfCashback[0]
                                  : Cashback.alphaCategoriesOfCashback[0],
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Text('Выберите кол-во категорий:'),
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        value: _selectedCountOfCategory,
                        items: countOfCategories
                            .map<DropdownMenuItem<String>>(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(e),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCountOfCategory = value!;
                            _selectedCategories = List.filled(
                              int.parse(_selectedCountOfCategory),
                              _selectedCardBank == listOfBank[0]
                                  ? Cashback.tinkoffCategoriesOfCashback[0]
                                  : Cashback.alphaCategoriesOfCashback[0],
                            );
                          });
                        },
                      ),
                    ),
                  ],
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    List<DropdownButtonFormField<String>> menuList =
                        List.generate(
                      int.parse(_selectedCountOfCategory),
                      (index) => DropdownButtonFormField<String>(
                        validator: (value) {
                          bool isUnrepeat = true;
                          for (int i = 0;
                              i < _selectedCategories.length - 1;
                              i++)
                            // ignore: curly_braces_in_flow_control_structures
                            for (int j = i + 1;
                                j < _selectedCategories.length;
                                j++) {
                              if (_selectedCategories[i] ==
                                  _selectedCategories[j]) {
                                isUnrepeat = false;
                              }
                            }

                          if (!isUnrepeat) {
                            return 'Выберите разные категории из предложенных';
                          } else {
                            return null;
                          }
                        },
                        value: _selectedCategories[index].name,
                        items: _selectedCardBank == listOfBank[0]
                            ? Cashback.tinkoffCategoriesOfCashback
                                .map<DropdownMenuItem<String>>(
                                  (e) => DropdownMenuItem(
                                    child: Text(e.name),
                                    value: e.name,
                                  ),
                                )
                                .toList()
                            : Cashback.alphaCategoriesOfCashback
                                .map<DropdownMenuItem<String>>(
                                  (e) => DropdownMenuItem(
                                    child: Text(e.name),
                                    value: e.name,
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategories[index] = _selectedCardBank ==
                                    listOfBank[0]
                                ? Cashback.tinkoffCategoriesOfCashback
                                    .firstWhere(
                                        (element) => element.name == value)
                                : Cashback.alphaCategoriesOfCashback.firstWhere(
                                    (element) => element.name == value);
                          });
                        },
                      ),
                    );
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: menuList.length,
                      itemBuilder: (context, index) => menuList[index],
                    );
                  },
                ),
                ElevatedButton(
                  child: const Text('Добавить'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _userCard = BankCard(
                        id: 0,
                        bankType: _selectedCardBank == listOfBank[0]
                            ? BankType.tinkoff
                            : BankType.alpha,
                        cardName: _cardNameController.text,
                        lastUpdate: DateTime.now(),
                        cashbackCategories: _selectedCategories,
                      );
                      BlocProvider.of<AddCardBloc>(context).add(
                        AddCardToDb(card: _userCard),
                      );
                    }
                  },
                ),
                BlocConsumer<AddCardBloc, AddCardBlocState>(
                  listener: (context, state) {
                    if (state is AddCardBlocInitial) {
                    }
                  },
                  builder: (context, state) {
                    if (state is AddCardBlocInitial) {
                      return SizedBox();
                    } else if (state is AddCardBlocLoading) {
                      return CircularProgressIndicator();
                    } else if (state is AddCardBlocSuccess) {
                      return AlertDialog(
                        title: const Text('Успешно'),
                        content: const Text('Карта была добавлена успешно'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        HomePage(),
                              ),
                            ),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    } else {
                      return Center(
                        child: AlertDialog(
                          title: const Text('Ошибка'),
                          content: const Text('Ваша карта не была добавлена'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {},
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
