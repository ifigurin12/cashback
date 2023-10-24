import 'package:cashback_info/bloc/add_card_bloc/add_card_bloc_bloc.dart';
import 'package:cashback_info/data_layer/models/card.dart';
import 'package:cashback_info/data_layer/models/cashback.dart';
import 'package:cashback_info/ui/home_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<String> listOfBank = ['Tinkoff Bank', 'Alpha Bank'];
List<String> countOfCategories = ['1', '2', '3', '4', '5', '6'];

class AddCardPage extends StatefulWidget {
  static const String routeName = '/addCardPage';

  const AddCardPage({super.key});

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  List<Cashback> categoriesOfCashback = [];
  String _selectedCountOfCategory = countOfCategories[3];
  List<Cashback> _selectedCategories = [];
  String _selectedCardBank = listOfBank[0];

  final TextEditingController _cardNameController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: TextFormField(
                      controller: _cardNameController,
                      decoration: const InputDecoration(
                        labelText: 'Имя карты',
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        prefixIcon: Icon(Icons.payment),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        hintText: 'Введите название карты',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Пожалуйста введие название карты';
                        }
                        return null;
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text(
                    'Выберите банк вашей карты:',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Wrap(
                  spacing: 10,
                  children: List<Widget>.generate(
                    listOfBank.length,
                    (int index) {
                      return ChoiceChip(
                        label: Text(listOfBank[index]),
                        selected: _selectedCardBank == listOfBank[index],
                        onSelected: (bool selected) {
                          setState(
                            () {
                              if (selected) {
                                _selectedCardBank = listOfBank[index];
                                _selectedCategories = List.filled(
                                  int.parse(_selectedCountOfCategory),
                                  _selectedCardBank == listOfBank[0]
                                      ? Cashback.tinkoffCategoriesOfCashback[0]
                                      : Cashback.alphaCategoriesOfCashback[0],
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                  ).toList(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Выберите кол-во категорий:',
                      style: TextStyle(fontSize: 15),
                    ),
                    DropdownButton<String>(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
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
                        setState(
                          () {
                            _selectedCountOfCategory = value!;
                            _selectedCategories = List.filled(
                              int.parse(_selectedCountOfCategory),
                              _selectedCardBank == listOfBank[0]
                                  ? Cashback.tinkoffCategoriesOfCashback[0]
                                  : Cashback.alphaCategoriesOfCashback[0],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    List<DropdownButtonFormField<String>> menuList =
                        List.generate(
                      int.parse(_selectedCountOfCategory),
                      (index) => DropdownButtonFormField<String>(
                        padding: EdgeInsets.only(bottom: 8),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(25),
                            ),
                          ),
                        ),
                        validator: (value) {
                          bool isUnrepeat = true;
                          Set<Cashback> unrepeatCheck =
                              Set.from(_selectedCategories);
                          unrepeatCheck.length == _selectedCategories.length
                              ? isUnrepeat = true
                              : isUnrepeat = false;
                          return isUnrepeat
                              ? null
                              : 'Выберите разные категории из предложенных';
                        },
                        value: _selectedCategories[index].name,
                        items: _selectedCardBank == listOfBank[0]
                            ? Cashback.tinkoffCategoriesOfCashback
                                .map<DropdownMenuItem<String>>(
                                  (e) => DropdownMenuItem(
                                    value: e.name,
                                    child: Text(e.name),
                                  ),
                                )
                                .toList()
                            : Cashback.alphaCategoriesOfCashback
                                .map<DropdownMenuItem<String>>(
                                  (e) => DropdownMenuItem(
                                    value: e.name,
                                    child: Text(e.name),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(
                            () {
                              _selectedCategories[index] =
                                  _selectedCardBank == listOfBank[0]
                                      ? Cashback.tinkoffCategoriesOfCashback
                                          .firstWhere(
                                          (element) => element.name == value,
                                        )
                                      : Cashback.alphaCategoriesOfCashback
                                          .firstWhere(
                                          (element) => element.name == value,
                                        );
                            },
                          );
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
                BlocListener<AddCardBloc, AddCardBlocState>(
                  listener: (context, state) {
                    if (state is AddCardBlocSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          backgroundColor: Colors.green,
                          content: Text(
                            'Карта успешно добавлена',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      );
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          HomePage.routeName, (route) => false);
                    }
                    if (state is AddCardBlocFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(seconds: 1),
                          backgroundColor: Colors.red,
                          content: Text(
                            'Добавление карты вызвало ошибку',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        child: const Text('Добавить'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _userCard = BankCard(
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
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
